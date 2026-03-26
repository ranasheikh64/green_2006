import 'package:equatable/equatable.dart';

class LookEntity extends Equatable {
  final String id;
  final String imageUrl;
  final bool isBookmarked;

  const LookEntity({
    required this.id,
    required this.imageUrl,
    this.isBookmarked = false,
  });

  @override
  List<Object?> get props => [id, imageUrl, isBookmarked];
}
