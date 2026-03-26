import '../../domain/entities/look_entity.dart';

class LookModel extends LookEntity {
  const LookModel({
    required super.id,
    required super.imageUrl,
    super.isBookmarked,
  });

  factory LookModel.fromJson(Map<String, dynamic> json) {
    return LookModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'isBookmarked': isBookmarked,
    };
  }
}
