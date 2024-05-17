import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_cubit_clean_architecture/domain/repositories/note_repository.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/cubit/home_cubit.dart';
import 'package:my_notes_cubit_clean_architecture/ui/pages/home/view/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NoteRepository>(
          create: (context) => NoteRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(
              RepositoryProvider.of<NoteRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            cardTheme: const CardTheme(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 6,
              shadowColor: Colors.black12,
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
            ),
          ),
          home: const HomeView(),
        ),
      ),
    );
  }
}
