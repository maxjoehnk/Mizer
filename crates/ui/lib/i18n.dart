import 'package:i18n_extension/i18n_extension.dart';
// TODO: figure out how to import locales in new i18n_extension version
// import 'package:i18n_extension/io/import.dart';

class MizerI18n {
  static var translations = Translations.byLocale("en");

  static Future<void> loadTranslations() async {
    Translations.missingKeyCallback = (key, locale) {};
    // translations += await GettextImporter().fromAssetDirectory("assets/locales");
  }
}

extension Localization on String {
  String get i18n => localize(this, MizerI18n.translations);
  String plural(value) => localizePlural(value, this, MizerI18n.translations);
  String fill(List<Object> params) => localizeFill(this, params);
}
