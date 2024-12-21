part of 'translation_bloc.dart';

@immutable
abstract class TranslationState {}

class TranslationInitial extends TranslationState {}

class TextUpdatedState extends TranslationState {
  final String text;

  TextUpdatedState(this.text);
}

class LanguageLoading extends TranslationState {}

class LanguageLoaded extends TranslationState {
  final List<Language> languages;
  final String translatedFrom;
  final String translatedTo;

  LanguageLoaded(
    this.languages, {
    this.translatedFrom = 'From',
    this.translatedTo = 'To',
  });

  LanguageLoaded copyWith({
    List<Language>? languages,
    String? translatedFrom,
    String? translatedTo,
  }) {
    return LanguageLoaded(
      languages ?? this.languages,
      translatedFrom: translatedFrom ?? this.translatedFrom,
      translatedTo: translatedTo ?? this.translatedTo,
    );
  }
}

class LanguageError extends TranslationState {
  final String message;

  LanguageError(this.message);
}

class TranslationResultState extends TranslationState {
  final String translatedText;

  TranslationResultState(this.translatedText);
}

class TranslationInProgress extends TranslationState {}

class TranslationError extends TranslationState {
  final String message;

  TranslationError(this.message);
}
