import 'package:dartz/dartz.dart';
import 'package:netigo_front/features/tabs/feed/domain/repositories/feed_repository.dart';
import 'package:netigo_front/features/tabs/feed/domain/entities/feed_entity.dart';

import '../../../../shared/domain/usecases/usecases.dart';

class GetFeedHistory
    implements UseCase<Either<String, List<FeedEntity>>, NoParams> {
  final FeedRepository repository;

  GetFeedHistory({required this.repository});

  @override
  call(NoParams params) async {
    return await repository.getFeedHistory();
  }
}
