import 'package:stackker_demo/utils/app_core.dart';

class PaddingConstants{
  static double get _screenHeight => AppSingleton().screenSize.height;
  static double get padding2 => _screenHeight * 0.001 * 2;
  static double get padding4 => _screenHeight * 0.001 * 4;
  static double get padding8 => _screenHeight * 0.001 * 8;
  static double get padding12 => _screenHeight * 0.001 * 12;
  static double get padding16 => _screenHeight * 0.001 * 16;
  static double get padding24 => _screenHeight * 0.001 * 24;
  static double get padding48 => _screenHeight * 0.001 * 48;
}