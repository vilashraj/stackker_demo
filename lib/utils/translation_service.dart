import 'package:stackker_demo/utils/app_core.dart';

class AppTranslationService {
  Locale? _locale;
  Map<dynamic, dynamic>? _localizedValues;

  ///
  /// Returns the translation that corresponds to the [key]
  ///
  String? text(String key) {
  // Return the requested string
    return (_localizedValues == null || _localizedValues![key] == null)
        ? '** $key not found'
        : _localizedValues![key];
  }

  ///
  /// One-time initialization
  ///
  Future init([String? language]) async {
    if (_locale == null) {
      await setNewLanguage(language);
    }
    return null;
  }

  ///
  /// Routine to change the language
  ///
  Future<Null> setNewLanguage([String? newLanguage, bool saveInPrefs = false]) async {
    var language = newLanguage;
    if (language == null || language == '') {
      language = "en";
    }

    var languageFile = language.toLowerCase();

    _locale = Locale(language, "");
    
    // Load the language strings
    var jsonContent = await rootBundle
        .loadString('assets/locale/i18n_$languageFile.json');
    _localizedValues = json.decode(jsonContent);
    return null;
  }

  ///
  /// Singleton Object
  ///
  static final AppTranslationService _translations = AppTranslationService._internal();
  factory AppTranslationService() {
    return _translations;
  }
  AppTranslationService._internal();
}

AppTranslationService appTranslationService = AppTranslationService();
