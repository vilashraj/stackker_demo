import 'package:stackker_demo/utils/app_core.dart';

class AppSingleton {
  static final AppSingleton _singleton = AppSingleton._internal();

  factory AppSingleton() {
    return _singleton;
  }

  AppSingleton._internal();

  //Storing the screen size in singleton in order to call MediaQuery.of(context).size again and again
  Size screenSize = const Size(0,0);
}