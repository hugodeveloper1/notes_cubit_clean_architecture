import 'package:my_notes_cubit_clean_architecture/data/response/user_entity_response.dart';

class UserEntityModel {
  final String userId;
  final String fullName;
  final String imageUrl;
  final String email;

  UserEntityModel({
    required this.userId,
    required this.fullName,
    required this.imageUrl,
    required this.email,
  });

  factory UserEntityModel.fromMap(UserEntityResponse response) {
    return UserEntityModel(
      userId: response.userId,
      fullName: response.fullName,
      imageUrl: response.imageUrl,
      email: response.email,
    );
  }
}
