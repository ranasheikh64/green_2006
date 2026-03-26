import '../../domain/entities/try_on_entity.dart';

class TryOnModel extends TryOnEntity {
  const TryOnModel({required super.resultImageUrl});

  factory TryOnModel.fromJson(Map<String, dynamic> json) {
    return TryOnModel(resultImageUrl: json['result_url']);
  }

  Map<String, dynamic> toJson() {
    return {'result_url': resultImageUrl};
  }
}
