LanguagesModel languagesModelFromJson(Map<String, dynamic> json) =>
    LanguagesModel.fromJson(json);

class LanguagesModel {
  final Data? data;

  LanguagesModel({
    this.data,
  });

  factory LanguagesModel.fromJson(Map<String, dynamic> json) => LanguagesModel(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );
}

class Data {
  final List<Language> languages;

  Data({
    required this.languages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        languages: (json['languages'] as List)
            .map((languageJson) => Language.fromJson(languageJson))
            .toList(),
      );
}

class Language {
  final String language;

  Language({
    required this.language,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        language: json['language'],
      );
}
