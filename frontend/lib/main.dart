import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:news_app_clean_architecture/config/routes/routes.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/home/daily_news.dart';
import 'config/theme/app_themes.dart';
import 'features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'injection_container.dart';

final _log = Logger('main');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up logging — prints every record to the console with level + logger name.
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('[${record.level.name}] ${record.loggerName}: ${record.message}'
        '${record.error != null ? '\nERROR: ${record.error}' : ''}'
        '${record.stackTrace != null ? '\n${record.stackTrace}' : ''}');
  });

  await configureDependencies();

  await Firebase.initializeApp();

  const bool USE_EMULATOR = true;

  if (USE_EMULATOR) {
    const String emulatorHost = 'localhost';

    await FirebaseAuth.instance.useAuthEmulator(emulatorHost, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, 8080);
    await FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);
  }

  // Sign in anonymously so Storage rules (require auth) are satisfied.
  // In a real app this would be replaced by proper auth.
  if (FirebaseAuth.instance.currentUser == null) {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      _log.info('Signed in anonymously: '
          '${FirebaseAuth.instance.currentUser?.uid}');
    } catch (e) {
      _log.severe('Anonymous sign-in failed', e);
      return;
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const DailyNews(),
      ),
    );
  }
}
