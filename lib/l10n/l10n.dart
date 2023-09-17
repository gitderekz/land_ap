import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('sw'),
    const Locale('en'),
    const Locale('ar'),
    const Locale('hi'),
    const Locale('es'),
    const Locale('de'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'sw':
        return '🇹🇿'' kiswahili';
      case 'ar':
        return '🇦🇪'' Arabic';
      case 'hi':
        return '🇮🇳'' Hindi';
      case 'es':
        return '🇪🇸'' Spanish';
      case 'de':
        return '🇩🇪'' German';
      case 'en':
      default:
        return '🇬🇧'' English';
    }
  }
}