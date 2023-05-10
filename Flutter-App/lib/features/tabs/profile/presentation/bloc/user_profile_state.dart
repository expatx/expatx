part of 'user_profile_bloc.dart';

class UserProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileSuccess extends UserProfileState {
  final ProfileEntity profileEntity;

  UserProfileSuccess({required this.profileEntity});
}

class UserProfileFailure extends UserProfileState {
  final String errorMessage;

  UserProfileFailure({required this.errorMessage});
}
