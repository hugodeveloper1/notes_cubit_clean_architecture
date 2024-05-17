import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/note_entity_model.dart';
import 'package:my_notes_cubit_clean_architecture/domain/models/user_entity_model.dart';
import 'package:my_notes_cubit_clean_architecture/ui/widgets/custom_cache_image.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });

  final NoteEntityModel note;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        width: size.width,
        height: 150,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: _ProfileUser(
                user: note.user,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _Body(
                note: note,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileUser extends StatelessWidget {
  const _ProfileUser({
    this.user,
  });

  final UserEntityModel? user;

  @override
  Widget build(BuildContext context) {
    return user != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CustomCacheImage(
                    url: user!.imageUrl,
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                user!.fullName,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.note,
  });

  final NoteEntityModel note;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          note.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            note.content,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _MembersList(
              members: note.members,
            ),
            Text(
              Jiffy.parse(note.date).MMMEd,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MembersList extends StatelessWidget {
  const _MembersList({
    required this.members,
  });

  final List<UserEntityModel> members;
  List<UserEntityModel> get list => members.sublist(0, 3);

  double get sizeWidth => 30;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(list.length, (index) {
        return Container(
          padding: const EdgeInsets.all(1),
          margin: EdgeInsets.only(
            left: index * (sizeWidth * 0.6),
          ),
          child: ClipOval(
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              width: sizeWidth,
              height: sizeWidth,
              child: CustomCacheImage(
                url: list[index].imageUrl,
              ),
            ),
          ),
        );
      }),
    );
  }
}
