import 'package:my_notes_cubit_clean_architecture/data/response/user_entity_response.dart';

class NoteEntityResponse {
  final String title;
  final String content;
  final UserEntityResponse? user;
  final String date;
  final String dateUpdated;
  final String type;
  final List<UserEntityResponse> members;

  NoteEntityResponse({
    required this.title,
    required this.content,
    this.user,
    required this.date,
    required this.dateUpdated,
    required this.type,
    required this.members,
  });
}
