import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/note_status_enum.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/cubit/home_cubit.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/widgets/home_content.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late HomeCubit homeCubit;
  final String title = 'My Notes Group';
  late TabController tabController;
  PageController pageController = PageController(
    initialPage: HomeSection.allNotes.index,
  );

  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: NoteTypeStatus.values.length,
      vsync: this,
    );
    homeCubit = context.read<HomeCubit>();
    homeCubit.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch (state.status) {
            case StatusPage.success:
              return HomeContent(
                categories: state.categories,
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
