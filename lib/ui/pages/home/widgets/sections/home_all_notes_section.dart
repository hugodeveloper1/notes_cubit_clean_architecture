import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/category_entity_model.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/note_entity_model.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/cubit/home_cubit.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/widgets/note_card.dart';

class HomeAllNotesSection extends StatefulWidget {
  const HomeAllNotesSection({
    super.key,
    this.categories = const [],
    required this.tabController,
  });

  final List<CategoryEntityModel> categories;
  final TabController tabController;

  @override
  State<HomeAllNotesSection> createState() => _HomeAllNotesSectionState();
}

class _HomeAllNotesSectionState extends State<HomeAllNotesSection> {
  bool isSearch = false;
  late HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();
    homeCubit = context.read<HomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      physics: const BouncingScrollPhysics(),
      children: widget.categories.map(
        (e) {
          return NotesList(
            notes: e.notes,
          );
        },
      ).toList(),
    );
  }
}

class NotesList extends StatelessWidget {
  const NotesList({
    super.key,
    required this.notes,
  });

  final List<NoteEntityModel> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notes.length,
      padding: const EdgeInsets.all(15),
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteCard(note: note);
      },
    );
  }
}
