part of 'home_cubit.dart';

enum HomeSection {
  search,
  loading,
  allNotes,
}

enum StatusPage { loading, error, success }

class HomeState extends Equatable {
  final StatusPage status;
  final HomeSection section;
  final List<CategoryEntityModel> categories;
  final CategoryEntityModel? category;
  final List<NoteEntityModel> searchNotes;
  final String query;

  const HomeState({
    this.status = StatusPage.loading,
    this.section = HomeSection.allNotes,
    this.categories = const [],
    this.category,
    this.searchNotes = const [],
    this.query = '',
  });

  @override
  List<Object?> get props => [
        status,
        section,
        categories,
        category,
        searchNotes,
        query,
      ];

  HomeState copyWith({
    StatusPage? status,
    HomeSection? section,
    List<CategoryEntityModel>? categories,
    CategoryEntityModel? category,
    List<NoteEntityModel>? searchNotes,
    String? query,
  }) {
    return HomeState(
      status: status ?? this.status,
      section: section ?? this.section,
      categories: categories ?? this.categories,
      category: category ?? this.category,
      searchNotes: searchNotes ?? this.searchNotes,
      query: query ?? this.query,
    );
  }
}
