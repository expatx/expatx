import 'package:netigo_front/features/feed/finances/domain/entity/finance_entity.dart';

class FinanceModel extends FinanceEntity {
  const FinanceModel({
    super.id,
    super.title,
    super.workType,
    super.expireTime,
    super.totalRate,
    super.status,
  });

  factory FinanceModel.fromJson(Map<String, dynamic> json) => FinanceModel(
        id: json["id"],
        title: json["title"],
        workType: json["workType"],
        expireTime: json["expireTime"],
        totalRate: json["totalRate"],
        status: json["status"],
      );

  FinanceEntity toEntity() => FinanceEntity(
        id: id,
        title: title,
        workType: workType,
        expireTime: expireTime,
        totalRate: totalRate,
        status: status,
      );
}
