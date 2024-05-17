import 'dart:math';

import 'package:my_notes_cubit_clean_architecture/data/response/note_entity_response.dart';
import 'package:my_notes_cubit_clean_architecture/data/response/user_entity_response.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/note_status_enum.dart';
import 'package:my_notes_cubit_clean_architecture/mock/users_mock.dart';

class NoteMock {
  static List<NoteEntityResponse> get notes {
    List<NoteEntityResponse> notes = [];

    for (int i = 0; i < 80; i++) {
      String title = "Note ${i + 1}";
      String content = "Content of note ${i + 1}";
      String date = DateTime.now().toIso8601String();
      String dateUpdated = DateTime.now().toIso8601String();

      List<String> types = NoteTypeStatus.values.map((e) => e.name).toList();

      String randomType = types[Random().nextInt(types.length)];

      List<UserEntityResponse> users = UserMock.users;

      notes.add(NoteEntityResponse(
        title: title,
        content: content,
        date: date,
        dateUpdated: dateUpdated,
        type: randomType,
        user: users[0],
        members: users,
      ));
    }

    return notes;
  }
}
