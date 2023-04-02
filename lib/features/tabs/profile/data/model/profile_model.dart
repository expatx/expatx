import 'package:expatx/features/tabs/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    super.id,
    super.userName,
    super.userEmail,
    super.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        userName: json["userName"],
        userEmail: json["userEmail"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "userEmail": userEmail,
        "image": image,
      };

  ProfileEntity toEntity() => ProfileEntity(
        id: id,
        userName: userName,
        userEmail: userEmail,
        image: image,
      );
}
