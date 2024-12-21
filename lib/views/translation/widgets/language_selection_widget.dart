import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_app/core/theme/app_palette.dart';

import '../../../controllers/bloc/translation_bloc.dart';
import 'languages_bottom_sheet.dart';

class LanguageSelectionWidget extends StatelessWidget {
  const LanguageSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String? translatedFrom;
    String? translatedTo;
    return BlocBuilder<TranslationBloc, TranslationState>(
        builder: (context, state) {
      if (state is LanguageLoaded) {
        translatedFrom = state.translatedFrom;
        translatedTo = state.translatedTo;
      }
      return Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      const LanguageBottomSheet(sectionMethod: 'From'),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppPalette.fillColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: Text(translatedFrom ?? '')),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.swap_horiz),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      const LanguageBottomSheet(sectionMethod: 'To'),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppPalette.fillColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: Text(translatedTo ?? "")),
              ),
            ),
          ),
        ],
      );
    });
  }
}
