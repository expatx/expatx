import 'package:expatx/features/tabs/feed/domain/entities/feed_entity.dart';

class FeedModel extends FeedEntity {
  const FeedModel({
    required super.id,
    required super.title,
    required super.content,
    required super.workType,
    required super.appointmentTime,
    required super.stage,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        workType: json["work_type"],
        appointmentTime: json["appointment_time"],
        stage: json["stage"],
      );

  FeedEntity toEntity() => FeedEntity(
        id: id,
        title: title,
        content: content,
        workType: workType,
        appointmentTime: appointmentTime,
        stage: stage,
      );
}
