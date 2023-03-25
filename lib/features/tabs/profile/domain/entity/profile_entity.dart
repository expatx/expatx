import 'package:equatable/equatable.dart';
import 'package:netigo_front/features/tabs/profile/presentation/model/profile_view_model.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity({
    this.id,
    this.userName,
    this.userEmail,
    this.image,
  });

  final String? id;
  final String? userName;
  final String? userEmail;
  final String? image;

  ProfileViewModel toViewModel() {
    return ProfileViewModel(
        userName: userName!, userEmail: userEmail!, image: image!);
  }

  @override
  List<Object?> get props => [
        id,
        userName,
        userEmail,
        image,
      ];
}
