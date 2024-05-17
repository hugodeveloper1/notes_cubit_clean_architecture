import 'package:my_notes_cubit_clean_architecture/data/response/user_entity_response.dart';

class UserMock {
  static List<UserEntityResponse> get users {
    List<UserEntityResponse> notes = [];

    for (int i = 0; i < 80; i++) {
      String fullName = "Full name user ${i + 1}";
      String email = "email${i + 1}@gmail.com";
      String userId = "${i + 1}";
      String imageUrl = 'https://randomuser.me/api/portraits/men/75.jpg';

      notes.add(UserEntityResponse(
        email: email,
        fullName: fullName,
        imageUrl: imageUrl,
        userId: userId,
      ));
    }

    return notes;
  }
}
