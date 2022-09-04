import 'package:stackker_demo/utils/app_core.dart';

class AppTheme{

  static ThemeData lightThemeData = ThemeData.light().copyWith(
    primaryColor: Colors.indigo,
    canvasColor: Colors.black,
    textTheme: ThemeData.light().textTheme.copyWith(
      bodySmall: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      bodyMedium: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      titleLarge: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      titleMedium: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      titleSmall: const TextStyle(color: Colors.black54, fontWeight: FontWeight.normal),
    ),
    cardTheme: const CardTheme().copyWith(
      color: Colors.white,
      shadowColor: Colors.grey.shade300
    ),
  );

  static ThemeData darkThemeData = ThemeData.dark().copyWith(
    primaryColor: Colors.indigo,
    canvasColor: Colors.white,
    textTheme: ThemeData.dark().textTheme.copyWith(
      bodySmall: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      bodyMedium: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      titleLarge: const TextStyle(color: Color.fromRGBO(130, 148, 161, 1.0), fontWeight: FontWeight.bold, fontSize: 18),
      titleMedium: const TextStyle(color: Color.fromRGBO(78, 99, 111, 1.0), fontWeight: FontWeight.bold, fontSize: 16),
      titleSmall: const TextStyle(color: Color.fromRGBO(77, 83, 101, 1.0), fontWeight: FontWeight.normal),
    ),
    cardTheme: const CardTheme().copyWith(
      color: const Color.fromRGBO(23, 25, 34, 1.0),
      shadowColor: const Color.fromRGBO(130, 148, 161, 0.1)
    ),
  );

  static List<Color> cardColorList(BuildContext context){
    if(Theme.of(context).brightness == Brightness.light){
      return [
        Colors.lightGreen,
        Colors.blue.shade800,
        Colors.amber.shade800,
        Colors.purple.shade300,
      ];
    }
    return const [
      Color.fromRGBO(68, 52, 62, 1.0),
      Color.fromRGBO(125, 115, 124, 1.0),
      Color.fromRGBO(86, 101, 133, 1.0),
      Color.fromRGBO(66, 110, 67, 1.0),
    ];
  }
}