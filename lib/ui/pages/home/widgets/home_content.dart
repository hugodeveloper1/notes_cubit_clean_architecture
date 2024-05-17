import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/category_entity_model.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/note_entity_model.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/cubit/home_cubit.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/widgets/sections/home_all_notes_section.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/widgets/sections/home_search_section.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/widgets/sections/slivers/home_loading_sliver.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/widgets/sections/slivers/home_all_notes_sliver.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/widgets/sections/slivers/home_search_sliver.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({
    super.key,
    required this.categories,
  });

  final List<CategoryEntityModel> categories;

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with SingleTickerProviderStateMixin {
  final String title = 'My Notes Group';
  late TabController tabController;
  late PageController headerController;
  late PageController bodyController;

  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: widget.categories.length,
      vsync: this,
    );

    headerController = PageController(
      initialPage: HomeSection.allNotes.index,
    );

    bodyController = PageController(
      initialPage: HomeSection.allNotes.index,
    );
  }

  void changeAnimationSection(int index) {
    headerController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );

    bodyController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );
  }

  void changeSection(int index) {
    headerController.jumpToPage(index);
    bodyController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (p, c) => p.section != c.section,
      listener: (context, state) {
        switch (state.section) {
          case HomeSection.search:
            changeAnimationSection(state.section.index);
            break;

          default:
            changeSection(state.section.index);
            break;
        }
      },
      builder: (context, state) {
        return NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                leading: isSearch
                    ? const SizedBox.shrink()
                    : IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.sort),
                      ),
                actions: [
                  isSearch
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            isSearch = false;
                            cubit.changeSection(section: HomeSection.allNotes);
                            setState(() {});
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            isSearch = true;
                            setState(() {});
                          },
                        ),
                ],
                pinned: true,
                floating: false,
                elevation: 0,
                centerTitle: !isSearch || state.section == HomeSection.search,
                title: state.section == HomeSection.search
                    ? const Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : (isSearch
                        ? HomeSearchSection(
                            hint: 'Search note',
                            onEditingComplete: () {
                              cubit.searchNotes();
                            },
                            onChanged: (value) {
                              if (value.trim().isNotEmpty) {
                                cubit.changeSection(
                                  section: HomeSection.loading,
                                );
                                cubit.onChangedSearch(
                                  query: value,
                                );
                              } else {
                                cubit.changeSection(
                                  section: HomeSection.allNotes,
                                );
                              }
                            },
                          )
                        : const SizedBox.shrink()),
                expandedHeight: kTextTabBarHeight + kToolbarHeight,
                flexibleSpace: _HeaderContent(
                  section: state.section,
                  category: state.category,
                  pageController: headerController,
                  tabController: tabController,
                  isSearch: isSearch,
                  categories: widget.categories,
                  searchText: state.query,
                ),
              ),
            ];
          },
          body: _BodyContent(
            tabController: tabController,
            categories: widget.categories,
            pageController: bodyController,
            notes: state.searchNotes,
          ),
        );
      },
    );
  }
}

class _BodyContent extends StatelessWidget {
  const _BodyContent({
    required this.tabController,
    required this.categories,
    required this.pageController,
    required this.notes,
  });

  final TabController tabController;
  final List<CategoryEntityModel> categories;
  final PageController pageController;
  final List<NoteEntityModel> notes;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: HomeSection.values.length,
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        switch (HomeSection.values[index]) {
          case HomeSection.allNotes:
            return HomeAllNotesSection(
              tabController: tabController,
              categories: categories,
            );

          case HomeSection.loading:
            return Container();

          case HomeSection.search:
            return NotesList(
              notes: notes,
            );
        }
      },
    );
  }
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent({
    required this.section,
    required this.category,
    required this.tabController,
    required this.pageController,
    required this.isSearch,
    required this.categories,
    required this.searchText,
  });

  final HomeSection section;
  final PageController pageController;
  final CategoryEntityModel? category;
  final TabController tabController;
  final bool isSearch;
  final List<CategoryEntityModel> categories;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: HomeSection.values.length,
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        switch (HomeSection.values[index]) {
          case HomeSection.allNotes:
            return HomeAllNotesSliver(
              category: category,
              isSearch: isSearch,
              categories: categories,
              tabController: tabController,
            );

          case HomeSection.loading:
            return const HomeLoadingSection();

          case HomeSection.search:
            return HomeSearchSliver(
              searchText: searchText,
            );
        }
      },
    );
  }
}
