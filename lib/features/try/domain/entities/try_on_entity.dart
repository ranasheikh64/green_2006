import 'package:equatable/equatable.dart';

class TryOnEntity extends Equatable {
  final String resultImageUrl;

  const TryOnEntity({required this.resultImageUrl});

  @override
  List<Object?> get props => [resultImageUrl];
}
