import 'package:dartz/dartz.dart';
import 'package:my_notes_cubit_clean_architecture/data/exception/data_exception.dart';
import 'package:my_notes_cubit_clean_architecture/data/response/note_entity_response.dart';

abstract class NoteImplement {
  Future<Either<DataException, List<NoteEntityResponse>>> getNotes();
}
