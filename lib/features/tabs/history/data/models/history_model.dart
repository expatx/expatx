import 'package:netigo_front/features/tabs/history/domain/entities/history_entity.dart';

class HistoryModel extends HistoryEntity {
  const HistoryModel({
    super.id,
    super.title,
    super.workType,
    super.expireTime,
    super.status,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json["id"],
        title: json["title"],
        workType: json["workType"],
        expireTime: json["expireTime"],
        status: json["status"],
      );

  HistoryEntity toEntity() => HistoryEntity(
        id: id,
        title: title,
        workType: workType,
        expireTime: expireTime,
        status: status,
      );
}
