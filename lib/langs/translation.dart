import 'package:cart/langs/langs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'es': EsLanguage.language,
        'en': EnLanguage.language,
      };

  static const List<Locale> supportedLocales = [
    Locale('es'),
    Locale('en'),
  ];

  static const Locale defaultLocale = Locale('es');
}
