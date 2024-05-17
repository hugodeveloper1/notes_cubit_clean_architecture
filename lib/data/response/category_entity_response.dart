import 'package:my_notes_cubit_clean_architecture/data/response/note_entity_response.dart';

class CategoryEntityResponse {
  final String name;
  final List<NoteEntityResponse> notes;

  CategoryEntityResponse({
    required this.name,
    required this.notes,
  });
}
