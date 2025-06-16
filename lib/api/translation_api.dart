import 'dart:convert';

import 'package:html_unescape/html_unescape_small.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;


class TranslationApi {
  static const _apiKey = '1bbd2933';

  static const  urlOxford = "https://owlbot.info/api/v4/dictionary/";
  static const  tokenOxford = "eed7ff420e3f3c2da5d7a929222c6c3f";

  static Future<String> translate(String text, String toLanguageCode) async {
    final response = await http.post(Uri.parse('https://translation.googleapis.com/language/translate/v2?target=$toLanguageCode&key=$_apiKey&q=$text'),);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final translations = body['data']['translations'] as List;
      final translation = translations.first;

      return HtmlUnescape().convert(translation['translatedText']);
    } else {
      throw Exception();
    }
  }

  static Future<String> translate2(String text, String fromLanguageCode, String toLanguageCode) async {
    final translation = await GoogleTranslator().translate(
      text,
      from: fromLanguageCode,
      to: toLanguageCode,
    );

    return translation.text;
  }

  static Future<dynamic> translate3(String text, String fromLanguageCode, String toLanguageCode) async {
    var response = await http.get(Uri.parse("https://od-api.oxforddictionaries.com/api/v2/translations/$fromLanguageCode/$toLanguageCode/${text.trim()}?strictMatch=false"), headers: {"Accept": "application/json", "app_id": _apiKey, "app_key": tokenOxford});

    return json.decode(response.body);
  }


}
