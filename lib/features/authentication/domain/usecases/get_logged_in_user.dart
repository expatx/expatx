import 'package:netigo_front/features/shared/domain/entities/user_entity.dart';

import '../../../shared/domain/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class GetLoggedInUser implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  GetLoggedInUser(this.authRepository);

  @override
  Future<UserEntity> call(NoParams params) {
    return authRepository.loggedInUser;
  }
}
