import 'package:my_notes_cubit_clean_architecture/data/response/note_entity_response.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/note_status_enum.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/user_entity_model.dart';

class NoteEntityModel {
  final String title;
  final String content;
  final UserEntityModel? user;
  final String date;
  final String dateUpdated;
  final NoteTypeStatus type;
  final List<UserEntityModel> members;

  NoteEntityModel({
    required this.title,
    required this.content,
    this.user,
    required this.date,
    required this.dateUpdated,
    required this.type,
    required this.members,
  });

  factory NoteEntityModel.fromMap(NoteEntityResponse response) {
    return NoteEntityModel(
      title: response.title,
      content: response.content,
      user: response.user != null
          ? UserEntityModel.fromMap(response.user!)
          : null,
      date: response.date,
      dateUpdated: response.dateUpdated,
      type: noteTypeStatus.map[response.type] ?? NoteTypeStatus.none,
      members: response.members.map((e) => UserEntityModel.fromMap(e)).toList(),
    );
  }
}
