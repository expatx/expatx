import 'package:dartz/dartz.dart';
import 'package:expatx/features/tabs/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<String, ProfileEntity>> getUserProfile();
}
