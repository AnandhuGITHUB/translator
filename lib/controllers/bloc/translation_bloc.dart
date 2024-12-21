import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/language_local.dart';
import '../../models/languages_model.dart';
import '../../services/translation_service.dart';

part 'translation_event.dart';
part 'translation_state.dart';

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  final TranslationService translationService;

  TranslationBloc({required this.translationService})
      : super(TranslationInitial()) {
    on<TranslateTextEvent>(_onTranslationChanged);
    on<FetchLanguagesEvent>(_fetchLanguages);
    on<UpdateFromLanguageEvent>(_updateFromLanguage);
    on<UpdateToLanguageEvent>(_updateToLanguage);
  }

  void _onTranslationChanged(
    TranslateTextEvent event,
    Emitter<TranslationState> emit,
  ) async {
    if (event.text.isNotEmpty) {
      try {
        final languageLocal = LanguageLocal();

        final sourceLanguage =
            languageLocal.getLanguageCode(event.targetLanguage);
        final targetLanguage =
            languageLocal.getLanguageCode(event.sourceLanguage);
        final translatedText = await translationService.translate(
          event.text,
          sourceLanguage ?? "",
          targetLanguage ?? "",
        );
        emit(TranslationResultState(translatedText));
      } catch (e) {
        emit(TranslationError("Error translating text: $e"));
      }
    }
  }

  Future<void> _fetchLanguages(
      FetchLanguagesEvent event, Emitter<TranslationState> emit) async {
    emit(LanguageLoading());
    try {
      final languages = await translationService.getLanguages();
      emit(LanguageLoaded(languages));
    } catch (e) {
      emit(LanguageError("Error fetching languages: $e"));
    }
  }

  void _updateFromLanguage(
      UpdateFromLanguageEvent event, Emitter<TranslationState> emit) {
    if (state is LanguageLoaded) {
      final currentState = state as LanguageLoaded;
      emit(currentState.copyWith(translatedFrom: event.fromLanguage));
    }
  }

  void _updateToLanguage(
      UpdateToLanguageEvent event, Emitter<TranslationState> emit) {
    if (state is LanguageLoaded) {
      final currentState = state as LanguageLoaded;
      emit(currentState.copyWith(translatedTo: event.toLanguage));
    }
  }
}
