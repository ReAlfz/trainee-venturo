import 'dart:ui';

import 'package:get/get.dart';

import '../../constants/cores/assets/image_constant.dart';
import '../langs/en_us.dart';
import '../langs/id_id.dart';

class Localization extends Translations {
  static const defaultLocale = Locale('id', 'ID');
  static const fallbackLocale = Locale('en', 'en_US');

  static const langs = [
    'English',
    'Indonesia',
  ];

  static const flags = [
    ImageConstant.flag_en,
    ImageConstant.flag_id,
  ];

  static const locales = [
    Locale('en', 'en_US'),
    Locale('id', 'ID')
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': translationsEnUs,
    'id_ID': translationsIdId,
  };

  static void changeLocale(String lang) async {
    final locale = getLocaleFromLanguage(lang);
    await Get.updateLocale(locale);
  }

  static Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (langs[i].toLowerCase() == lang.toLowerCase()) {
        return locales[i];
      }
    }

    return defaultLocale;
  }

  static Locale get currentLocale {
    return Get.locale ?? fallbackLocale;
  }

  static String get currentLanguage {
    return langs.elementAt(locales.indexOf(currentLocale));
  }
}