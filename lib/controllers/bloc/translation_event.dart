part of 'translation_bloc.dart';

@immutable
sealed class TranslationEvent {}

// class TranslateTextEvent extends TranslationEvent {
//   final String text;

//   TranslateTextEvent(this.text);
// }

class FetchLanguagesEvent extends TranslationEvent {}

class SearchLanguagesEvent extends TranslationEvent {
  final String query;
  final List<Language> languages;

  SearchLanguagesEvent(this.query, this.languages);
}

class UpdateFromLanguageEvent extends TranslationEvent {
  final String fromLanguage;
  UpdateFromLanguageEvent(this.fromLanguage);
}

class UpdateToLanguageEvent extends TranslationEvent {
  final String toLanguage;
  UpdateToLanguageEvent(this.toLanguage);
}

class TranslateTextEvent extends TranslationEvent {
  final String text;
  final String sourceLanguage;
  final String targetLanguage;

  TranslateTextEvent(this.text, this.sourceLanguage, this.targetLanguage);
}
