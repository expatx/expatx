import 'package:equatable/equatable.dart';
import 'package:expatx/features/tabs/history/presentation/model/history_view_model.dart';

class HistoryEntity extends Equatable {
  const HistoryEntity({
    this.id,
    this.workType,
    this.expireTime,
    this.title,
    this.status,
  });

  final String? id;
  final String? workType;
  final String? expireTime;
  final String? title;
  final String? status;

  HistoryViewModel toViewModel() {
    return HistoryViewModel(
      title: title!,
      workType: workType!,
      expireDate: expireTime!,
      status: status!,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        workType,
        expireTime,
        status,
      ];
}
