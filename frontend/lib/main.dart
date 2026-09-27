import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:news_app_clean_architecture/config/routes/routes.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/home/daily_news.dart';
import 'config/theme/app_themes.dart';
import 'features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'injection_container.dart';

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
    FirebaseFirestore.instance.settings = const Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
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
