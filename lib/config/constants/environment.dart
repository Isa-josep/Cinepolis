

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{
  static String moviDdKey =dotenv.env['THE_MOVIEDB_KEY'] ?? 'No existe el api key';
}