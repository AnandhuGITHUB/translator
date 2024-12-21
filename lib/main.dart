import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_app/core/theme/app_theme.dart';

import 'controllers/bloc/translation_bloc.dart';
import 'services/translation_service.dart';
import 'views/translation/translation_view.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TranslationBloc(
            translationService: TranslationService(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      themeMode: ThemeMode.dark,
      home: const TranslationView(),
    );
  }
}
