import 'package:equatable/equatable.dart';
import 'package:netigo_front/features/tabs/finances/presentation/model/finance_view_model.dart';

class FinanceEntity extends Equatable {
  const FinanceEntity({
    this.id,
    this.workType,
    this.expireTime,
    this.title,
    this.status,
    this.totalRate,
  });

  final String? id;
  final String? workType;
  final String? expireTime;
  final String? title;
  final String? status;
  final double? totalRate;

  FinanceViewModel toViewModel() {
    return FinanceViewModel(
        title: title!, status: status!, totalRate: totalRate!);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        workType,
        expireTime,
        status,
        totalRate,
      ];
}
