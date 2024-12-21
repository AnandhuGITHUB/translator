import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_app/core/common/widgets/app_text_field.dart';
import 'package:translator_app/core/utils/language_local.dart';
import 'package:translator_app/models/languages_model.dart';

import '../../../controllers/bloc/translation_bloc.dart';
import '../../../core/theme/app_palette.dart';

class LanguageBottomSheet extends StatelessWidget {
  final String sectionMethod;
  const LanguageBottomSheet({
    super.key,
    required this.sectionMethod,
  });

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final languageLocal = LanguageLocal();

    List<Language> languages = [];

    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (context, state) {
        if (state is LanguageLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LanguageLoaded) {
          languages = state.languages;
        }
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$sectionMethod "),
              const SizedBox(height: 10),
              AppTextField(
                prefixIcon: const Icon(Icons.search),
                // onChanged: (value) {
                //   BlocProvider.of<TranslationBloc>(context).add(
                //     SearchLanguagesEvent(value, state.languages),
                //   );
                // },
                hintText: "Search languages...",
                controller: searchController,
              ),
              const SizedBox(height: 20),
              const Text("All Languages"),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.separated(
                  itemCount: languages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final language = languages[index];
                    final languageName = languageLocal.getDisplayLanguage(
                      language.language,
                    );
                    return InkWell(
                      onTap: () {
                        if (sectionMethod == 'From') {
                          context.read<TranslationBloc>().add(
                                UpdateFromLanguageEvent(languageName!),
                              );
                        } else {
                          context.read<TranslationBloc>().add(
                                UpdateToLanguageEvent(languageName!),
                              );
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppPalette.blackColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Text(languageName ?? "Not Available"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
