import 'package:dartz/dartz.dart';
import 'package:my_notes_cubit_clean_architecture/data/exception/data_exception.dart';
import 'package:my_notes_cubit_clean_architecture/data/implements/note_implement.dart';
import 'package:my_notes_cubit_clean_architecture/data/response/note_entity_response.dart';
import 'package:my_notes_cubit_clean_architecture/mock/note_mock.dart';

class NoteRemote extends NoteImplement {
  @override
  Future<Either<DataException, List<NoteEntityResponse>>> getNotes() async {
    try {
      return Right(NoteMock.notes);
    } catch (e) {
      return Left(DataException(message: e.toString()));
    }
  }
}
