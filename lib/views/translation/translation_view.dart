import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_app/core/theme/app_palette.dart';
import 'package:translator_app/core/utils/language_local.dart';
import 'package:translator_app/views/translation/widgets/language_selection_widget.dart';
import 'package:translator_app/views/translation/widgets/translation_text_field.dart';

import '../../controllers/bloc/translation_bloc.dart';

class TranslationView extends StatefulWidget {
  const TranslationView({super.key});

  @override
  State<TranslationView> createState() => _TranslationViewState();
}

class _TranslationViewState extends State<TranslationView> {
  final languageLocal = LanguageLocal();
  @override
  void initState() {
    context.read<TranslationBloc>().add(FetchLanguagesEvent());
    super.initState();
  }

  final translateFromTextController = TextEditingController();
  final translateToTextController = TextEditingController();
  String? translateFrom;
  String? translateTo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Text Translation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(color: AppPalette.greyColor),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LanguageSelectionWidget(),
                      const SizedBox(height: 20),
                      BlocBuilder<TranslationBloc, TranslationState>(
                        builder: (context, state) {
                          if (state is LanguageLoaded) {
                            translateFrom = state.translatedFrom;
                          }
                          return Text(
                            'Translate From ($translateFrom)',
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<TranslationBloc, TranslationState>(
                        builder: (context, state) {
                          return TranslationTextField(
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                context.read<TranslationBloc>().add(
                                      TranslateTextEvent(
                                          value,
                                          translateFrom ?? '',
                                          translateTo ?? ''),
                                    );
                              }
                            },
                            controller: translateFromTextController,
                            hintText: 'Type text to translate...',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Content missing';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<TranslationBloc, TranslationState>(
                        builder: (context, state) {
                          if (state is LanguageLoaded) {
                            translateTo = state.translatedTo;
                          }
                          return Text(
                            'Translate From ($translateTo)',
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<TranslationBloc, TranslationState>(
                        builder: (context, state) {
                          if (state is TranslationInProgress) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is TranslationResultState) {
                            translateToTextController.text =
                                state.translatedText;
                          }
                          return TranslationTextField(
                            controller: translateToTextController,
                            onChanged: null,
                            hintText: 'Translated text will appear here...',
                            enabled: false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    translateFromTextController.dispose();
    translateToTextController.dispose();
    super.dispose();
  }
}
