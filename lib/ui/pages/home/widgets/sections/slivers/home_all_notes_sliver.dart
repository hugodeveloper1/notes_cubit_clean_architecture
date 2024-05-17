import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/category_entity_model.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/cubit/home_cubit.dart';

class HomeAllNotesSliver extends StatefulWidget {
  const HomeAllNotesSliver({
    super.key,
    this.categories = const [],
    this.category,
    required this.tabController,
    required this.isSearch,
  });

  final List<CategoryEntityModel> categories;
  final CategoryEntityModel? category;
  final TabController tabController;
  final bool isSearch;

  @override
  State<HomeAllNotesSliver> createState() => _HomeAllNotesSliverState();
}

class _HomeAllNotesSliverState extends State<HomeAllNotesSliver> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isExpanded =
            constraints.maxHeight > (kTextTabBarHeight + kToolbarHeight);
        return FlexibleSpaceBar(
          titlePadding: EdgeInsets.zero,
          centerTitle: true,
          title: widget.isSearch
              ? null
              : (isExpanded
                  ? null
                  : Container(
                      height: kToolbarHeight,
                      alignment: Alignment.center,
                      child: Text(
                        widget.category?.name ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    )),
          collapseMode: CollapseMode.parallax,
          background: isExpanded
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: TabBar(
                    controller: widget.tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    physics: const BouncingScrollPhysics(),
                    onTap: (value) {
                      context.read<HomeCubit>().changeCategory(
                            category: widget.categories[value],
                          );
                    },
                    dividerColor: Colors.transparent,
                    indicator: const BoxDecoration(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    labelPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    splashBorderRadius: BorderRadius.circular(10),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    tabs: widget.categories.map((e) {
                      return Tab(
                        text: e.name,
                      );
                    }).toList(),
                  ),
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
