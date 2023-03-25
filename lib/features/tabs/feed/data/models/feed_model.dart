import 'package:netigo_front/features/tabs/feed/domain/entities/feed_entity.dart';

class FeedModel extends FeedEntity {
  const FeedModel({
    super.id,
    super.title,
    super.workType,
    super.expireTime,
    super.status,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        id: json["id"],
        title: json["title"],
        workType: json["workType"],
        expireTime: json["expireTime"],
        status: json["status"],
      );

  FeedEntity toEntity() => FeedEntity(
        id: id,
        title: title,
        workType: workType,
        expireTime: expireTime,
        status: status,
      );
}
