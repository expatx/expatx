import 'package:dartz/dartz.dart';
import 'package:netigo_front/features/feed/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<String, ProfileEntity>> getUserProfile();
}
