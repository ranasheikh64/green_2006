import 'package:equatable/equatable.dart';
import '../../domain/entities/look_entity.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<LookEntity> looks;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.looks = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<LookEntity>? looks,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      looks: looks ?? this.looks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, looks, errorMessage];
}
