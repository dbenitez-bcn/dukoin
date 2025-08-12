import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dukoin_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(DukoinApp(prefs: prefs));
}
