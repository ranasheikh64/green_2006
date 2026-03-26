import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class TryOnEvent extends Equatable {
  const TryOnEvent();

  @override
  List<Object?> get props => [];
}

class StartTryOnProcessingEvent extends TryOnEvent {
  final File image;

  const StartTryOnProcessingEvent(this.image);

  @override
  List<Object?> get props => [image];
}

class UpdateLoadingStageEvent extends TryOnEvent {
  final int stage;

  const UpdateLoadingStageEvent(this.stage);

  @override
  List<Object?> get props => [stage];
}
