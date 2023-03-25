import 'package:equatable/equatable.dart';
import 'package:netigo_front/features/tabs/feed/presentation/model/feed_view_model.dart';

class FeedEntity extends Equatable {
  const FeedEntity({
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

  FeedViewModel toViewModel() {
    return FeedViewModel(
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
