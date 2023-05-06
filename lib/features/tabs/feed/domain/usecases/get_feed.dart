import 'package:dartz/dartz.dart';
import 'package:expatx/features/tabs/feed/domain/repositories/feed_repository.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';

import '../../../../shared/domain/usecases/usecases.dart';

class GetFeed
    implements UseCase<Either<String, List<FeedPostEntity>>, NoParams> {
  final FeedRepository repository;

  GetFeed({required this.repository});

  @override
  call(NoParams params) async {
    return await repository.getFeed();
  }
}
