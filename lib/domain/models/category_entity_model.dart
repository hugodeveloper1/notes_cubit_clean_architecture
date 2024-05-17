import 'package:my_notes_cubit_clean_architecture/domain/models/note_entity_model.dart';

class CategoryEntityModel {
  final String name;
  final List<NoteEntityModel> notes;

  CategoryEntityModel({
    required this.name,
    required this.notes,
  });

  CategoryEntityModel copyWith({
    String? name,
    List<NoteEntityModel>? notes,
  }) {
    return CategoryEntityModel(
      name: name ?? this.name,
      notes: notes ?? this.notes,
    );
  }
}
