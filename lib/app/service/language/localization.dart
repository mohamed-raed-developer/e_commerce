import 'package:e_commerce/app/service/language/ar.dart';
import 'package:e_commerce/app/service/language/en.dart';
import 'package:e_commerce/app/service/language/fr.dart';
import 'package:get/get.dart';

import '../../../utils/my_string.dart';

class LocaliztionApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        ene: en,
        ara: ar,
        frf: fr,
      };
}
