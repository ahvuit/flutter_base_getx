enum Language { vi, en }

extension LanguageExt on Language {
  String get languageCode {
    switch (this) {
      case Language.vi:
        return LanguageName.vn;
      case Language.en:
        return LanguageName.en;
    }
  }
}

Language getLanguageFromCode(String? languageCode) {
  switch (languageCode) {
    case LanguageName.vn:
      return Language.vi;
    case LanguageName.en:
      return Language.en;
  }
  return Language.vi;
}

class LanguageName {
  static const String vn = 'vi';
  static const String en = 'en';
}

class LanguageConstant {
  static List<LanguageModel> language = [
    LanguageModel(flag: '🇻🇳', language: Language.vi, label: 'vietnamese'),
    LanguageModel(flag: '🇺🇸', language: Language.en, label: 'english'),
  ];
}

class LanguageModel {
  String flag;
  String label;
  Language language;

  LanguageModel({
    required this.flag,
    required this.label,
    required this.language,
  });
}
