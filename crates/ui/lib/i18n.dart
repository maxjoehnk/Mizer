import 'package:i18n_extension/i18n_extension.dart';
export 'package:i18n_extension/i18n_extension.dart';

class MizerI18n {
  static var translations = Translations.byFile("en", dir: "assets/locales");

  static Future<void> loadTranslations() async {
    Set encounteredKeys = {};
    Translations.missingKeyCallback = (key, locale) {
      if (locale == "en") {
        return;
      }
      if (encounteredKeys.contains(key)) {
        return;
      }
      print("Missing translation key '$key' for locale '$locale'");
      encounteredKeys.add(key);
    };
  }
}

extension Localization on String {
  String get i18n => localize(this, MizerI18n.translations);
  String plural(value) => localizePlural(value, this, MizerI18n.translations);
  String fill(List<Object> params) => localizeFill(this, params);
}
