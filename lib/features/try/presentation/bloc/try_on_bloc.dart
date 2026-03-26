import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/try_repository.dart';
import 'try_on_event.dart';
import 'try_on_state.dart';

class TryOnBloc extends Bloc<TryOnEvent, TryOnState> {
  final TryRepository repository;
  Timer? _stageTimer;

  TryOnBloc({required this.repository}) : super(const TryOnState()) {
    on<StartTryOnProcessingEvent>(_onStartTryOnProcessing);
    on<UpdateLoadingStageEvent>(_onUpdateLoadingStage);
  }

  Future<void> _onStartTryOnProcessing(
    StartTryOnProcessingEvent event,
    Emitter<TryOnState> emit,
  ) async {
    emit(state.copyWith(status: TryOnStatus.loading, loadingStage: 0));

    // Start a timer to cycle loading stages locally for UI feedback
    _stageTimer?.cancel();
    _stageTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (state.loadingStage < 3) {
        add(UpdateLoadingStageEvent(state.loadingStage + 1));
      } else {
        timer.cancel();
      }
    });

    try {
      final result = await repository.processTryOn(event.image);
      _stageTimer?.cancel(); // Complete if it finishes early
      emit(state.copyWith(status: TryOnStatus.success, result: result, loadingStage: 3));
    } catch (e) {
      _stageTimer?.cancel();
      emit(state.copyWith(status: TryOnStatus.failure, errorMessage: e.toString()));
    }
  }

  void _onUpdateLoadingStage(
    UpdateLoadingStageEvent event,
    Emitter<TryOnState> emit,
  ) {
    emit(state.copyWith(loadingStage: event.stage));
  }

  @override
  Future<void> close() {
    _stageTimer?.cancel();
    return super.close();
  }
}
