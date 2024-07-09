import 'package:shared_preferences/shared_preferences.dart';

setColor(value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('color_key', value);
}

getColor() async {
  final prefs = await SharedPreferences.getInstance();
  int color = prefs.getInt('color_key') ?? 0;
  return color;
}

setCoin(value) async {
  final prefs = await SharedPreferences.getInstance();
  var old_value = prefs.getInt('coin_key') ?? 0;
  await prefs.setInt('coin_key', value + old_value);
}

getCoin() async {
  final prefs = await SharedPreferences.getInstance();
  var coin = prefs.getInt('coin_key') ?? 0;
  return coin;
}
