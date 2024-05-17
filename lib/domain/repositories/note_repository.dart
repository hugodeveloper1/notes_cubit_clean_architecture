import 'package:dartz/dartz.dart';
import 'package:my_notes_cubit_clean_architecture/data/exception/data_exception.dart';
import 'package:my_notes_cubit_clean_architecture/data/remote/note_remote.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/category_entity_model.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/note_entity_model.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/note_status_enum.dart';

class NoteRepository {
  final remote = NoteRemote();

  Future<Either<DataException, List<CategoryEntityModel>>>
      getCategories() async {
    final response = await remote.getNotes();
    return response.fold(
      (l) => Left(l),
      (r) {
        final notes = r.map((e) {
          return NoteEntityModel.fromMap(e);
        }).toList();
        final categories = clasificarPorCategoria(notas: notes);
        return Right(categories);
      },
    );
  }

  List<CategoryEntityModel> clasificarPorCategoria({
    required List<NoteEntityModel> notas,
  }) {
    Map<String, List<NoteEntityModel>> categoriasMap = {};

    for (var nota in notas) {
      if (!categoriasMap.containsKey(nota.type.value)) {
        categoriasMap[nota.type.value] = [];
      }
      categoriasMap[nota.type.value]!.add(nota);
    }

    List<CategoryEntityModel> categorias = categoriasMap.entries.map((entry) {
      return CategoryEntityModel(
        name: entry.key,
        notes: entry.value,
      );
    }).toList();

    final newList = categorias.where((element) {
      return element.name != NoteTypeStatus.none.value;
    }).toList();

    final fullList = newList.map(
      (e) {
        if (e.name == NoteTypeStatus.all.value) return e.copyWith(notes: notas);
        return e;
      },
    ).toList();

    return fullList;
  }
}
