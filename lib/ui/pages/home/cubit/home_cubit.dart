import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/category_entity_model.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/note_entity_model.dart';
import 'package:my_notes_cubit_clean_architecture/domain/repositories/note_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.noteRepository,
  ) : super(const HomeState());

  final NoteRepository noteRepository;

  void getCategories() async {
    final response = await noteRepository.getCategories();

    response.fold(
      (l) {
        emit(state.copyWith(
          status: StatusPage.error,
        ));
      },
      (r) {
        emit(state.copyWith(
          status: StatusPage.success,
          categories: r,
          category: r[0],
        ));
      },
    );
  }

  void changeSection({
    required HomeSection section,
  }) {
    emit(state.copyWith(
      section: section,
    ));
  }

  void changeCategory({
    required CategoryEntityModel category,
  }) {
    emit(state.copyWith(
      category: category,
    ));
  }

  void searchNotes() {
    List<CategoryEntityModel> categories = [...state.categories];
    String query = state.query;
    List<NoteEntityModel> matchingNotes = [];

    for (var category in categories) {
      for (var note in category.notes) {
        if (note.title.contains(query) || note.content.contains(query)) {
          matchingNotes.add(note);
        }
      }
    }

    emit(state.copyWith(
      searchNotes: matchingNotes,
      section: HomeSection.search,
    ));
  }

  void onChangedSearch({String query = ''}) {
    if (query.trim().isNotEmpty) {
      emit(state.copyWith(
        query: query,
      ));
    }
  }
}
