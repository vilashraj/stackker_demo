import 'package:stackker_demo/utils/app_core.dart';

class AppHelper{
  static double emi({required double principalAmount, required double rate, required int tenure}) => (principalAmount * rate * pow((1+rate), tenure) / ( pow((1+rate),tenure) -1));
}