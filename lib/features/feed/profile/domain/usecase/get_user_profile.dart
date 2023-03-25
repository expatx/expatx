import 'package:dartz/dartz.dart';
import 'package:netigo_front/features/feed/profile/domain/entity/profile_entity.dart';
import 'package:netigo_front/features/feed/profile/domain/repository/profile_repository.dart';

import '../../../../shared/domain/usecases/usecases.dart';

class GetUserProfile
    implements UseCase<Either<String, ProfileEntity>, NoParams> {
  final ProfileRepository repository;

  GetUserProfile({required this.repository});

  @override
  call(NoParams params) async {
    return await repository.getUserProfile();
  }
}
