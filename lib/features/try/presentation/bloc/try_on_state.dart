import 'package:equatable/equatable.dart';
import '../../domain/entities/try_on_entity.dart';

enum TryOnStatus { initial, loading, success, failure }

class TryOnState extends Equatable {
  final TryOnStatus status;
  final int loadingStage;
  final TryOnEntity? result;
  final String? errorMessage;

  const TryOnState({
    this.status = TryOnStatus.initial,
    this.loadingStage = 0,
    this.result,
    this.errorMessage,
  });

  TryOnState copyWith({
    TryOnStatus? status,
    int? loadingStage,
    TryOnEntity? result,
    String? errorMessage,
  }) {
    return TryOnState(
      status: status ?? this.status,
      loadingStage: loadingStage ?? this.loadingStage,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, loadingStage, result, errorMessage];
}
