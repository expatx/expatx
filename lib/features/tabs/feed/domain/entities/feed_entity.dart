import 'package:equatable/equatable.dart';
import 'package:expatx/features/tabs/feed/presentation/model/feed_view_model.dart';

class FeedEntity extends Equatable {
  const FeedEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.workType,
    required this.appointmentTime,
    required this.stage,
  });

  final int id;
  final String title;
  final String content;
  final String workType;
  final String appointmentTime;
  final String stage;

  FeedViewModel toViewModel() {
    return FeedViewModel(
      title: title,
      content: content,
      workType: workType,
      appointmentTime: appointmentTime,
      stage: stage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        workType,
        appointmentTime,
        stage,
      ];
}
