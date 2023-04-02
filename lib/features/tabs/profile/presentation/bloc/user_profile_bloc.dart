import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expatx/features/tabs/profile/domain/entity/profile_entity.dart';
import 'package:expatx/features/tabs/profile/domain/usecase/get_user_profile.dart';

import '../../../../shared/domain/usecases/usecases.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({required this.getUserProfile})
      : super(UserProfileInitial()) {
    on<GetUserProfileEvent>(_onGetUserProfileEvent);
  }

  late GetUserProfile getUserProfile;

  Future<void> _onGetUserProfileEvent(
    GetUserProfileEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(UserProfileLoading());

    // Mock await
    await Future.delayed(const Duration(seconds: 2));

    try {
      final response = await getUserProfile.call(NoParams());

      response.fold(
        (l) => emit(
          UserProfileFailure(
            errorMessage: l.toString(),
          ),
        ),
        (r) => emit(UserProfileSuccess(profileEntity: r)),
      );
    } catch (_) {
      emit(
        UserProfileFailure(
          errorMessage: "Failed to load user data!",
        ),
      );
    }
  }
}
