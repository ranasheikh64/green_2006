import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc({required this.repository}) : super(const HomeState()) {
    on<GetRecentlyCreatedLooksEvent>(_onGetRecentlyCreatedLooks);
  }

  Future<void> _onGetRecentlyCreatedLooks(
    GetRecentlyCreatedLooksEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final looks = await repository.getRecentlyCreatedLooks();
      emit(state.copyWith(status: HomeStatus.success, looks: looks));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()));
    }
  }
}
