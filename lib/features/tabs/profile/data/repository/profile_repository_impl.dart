import 'package:dartz/dartz.dart';
import 'package:expatx/features/tabs/profile/data/datasource/profile_local_datasource.dart';
import 'package:expatx/features/tabs/profile/data/datasource/profile_remote_datasource.dart';
import 'package:expatx/features/tabs/profile/data/model/profile_model.dart';
import 'package:expatx/features/tabs/profile/domain/entity/profile_entity.dart';
import 'package:expatx/features/tabs/profile/domain/repository/profile_repository.dart';

import '../../../../../core/network/network_info.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDatasource localDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<String, ProfileEntity>> getUserProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final ProfileModel profileModel =
            await remoteDataSource.getUserProfile();

        localDataSource.cacheProfile(profileModel);

        ProfileEntity profileEntity = profileModel.toEntity();

        return Right(profileEntity);
      } catch (e) {
        // ignore: avoid_print
        print("Error: ${e.toString()}");

        return Left(e.toString());
      }
    } else {
      try {
        ProfileModel profileModel = await localDataSource.getLastProfile();
        ProfileEntity profileEntity = profileModel.toEntity();
        return Right(profileEntity);
      } catch (e) {
        // ignore: avoid_print
        print("Error: ${e.toString()}");
        return Left(e.toString());
      }
    }
  }
}
