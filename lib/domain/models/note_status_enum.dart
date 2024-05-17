import 'package:my_notes_cubit_clean_architecture/domain/models/enum_values.dart';

enum NoteTypeStatus {
  all,
  work,
  family,
  personal,
  reminder,
  meeting,
  shopping,
  none;

  String get value {
    switch (this) {
      case NoteTypeStatus.all:
        return 'All';

      case NoteTypeStatus.work:
        return 'Work';

      case NoteTypeStatus.family:
        return 'Family';

      case NoteTypeStatus.personal:
        return 'Personal';

      case NoteTypeStatus.reminder:
        return 'Reminder';

      case NoteTypeStatus.meeting:
        return 'Meeting';

      case NoteTypeStatus.shopping:
        return 'Shopping';

      case NoteTypeStatus.none:
        return '';
    }
  }
}

final noteTypeStatus = EnumValues({
  NoteTypeStatus.work.name: NoteTypeStatus.work,
  NoteTypeStatus.family.name: NoteTypeStatus.family,
  NoteTypeStatus.personal.name: NoteTypeStatus.personal,
  NoteTypeStatus.reminder.name: NoteTypeStatus.reminder,
  NoteTypeStatus.meeting.name: NoteTypeStatus.meeting,
  NoteTypeStatus.shopping.name: NoteTypeStatus.shopping,
  NoteTypeStatus.none.name: NoteTypeStatus.none,
});
