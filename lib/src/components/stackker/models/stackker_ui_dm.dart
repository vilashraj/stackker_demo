import 'package:stackker_demo/utils/app_core.dart';

enum StackkerWidgetState{expanded, collapsed}

typedef OnPageSelected = void Function(int index);

class StackkerUiDm{
  Widget expandedView;
  Widget collapsedView;
  String actionTitle;
  StackkerWidgetState viewState;
  StackkerUiDm({Key? key, required this.collapsedView, required this.expandedView, this.viewState = StackkerWidgetState.collapsed, required this.actionTitle}); 
}
