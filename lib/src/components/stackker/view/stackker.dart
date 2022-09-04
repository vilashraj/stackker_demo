import 'package:stackker_demo/utils/app_core.dart';

class Stackker extends StatefulWidget {
  final int selectedIndex;
  final OnPageSelected? onSelectedPage;
  final List<StackkerUiDm> widgetList;
  final double? expandedHeight;
  final double? collapsedHeight;

  const Stackker({Key? key, this.onSelectedPage, this.selectedIndex = -1, required this.widgetList, this.expandedHeight, this.collapsedHeight}) : super(key: key);

  @override
  State<Stackker> createState() => _StackkerState();
}

class _StackkerState extends State<Stackker> {

  //Variables:
  int selectedWidgetIndex = -1;
  List<Widget> stackList = [];

  //Controllers: 
  ScrollController scrollController = ScrollController();

  //Getters:
  double get screenHeight => AppSingleton().screenSize.height;
  double get expandedHeight => screenHeight * 0.9;
  double get collapsedHeight => screenHeight * 0.1;
  List<StackkerUiDm> get widgetList => widget.widgetList;

  @override
  void initState() {
    selectedWidgetIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(stackList.isEmpty){
      setStackList(length: widgetList.length);
    }
    return AnimatedSize(
      duration: const Duration(milliseconds: 150),
      child: SizedBox(
        height: getWidgetHeight(0),
        child: SingleChildScrollView(
          reverse: true,
          controller: scrollController,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: stackList
          ),
        ),
      ),
    );
  }

  Widget cardView(StackkerUiDm stackkerWidget, int index){
    return GestureDetector(
      onTap: (){
        if(stackkerWidget.viewState == StackkerWidgetState.collapsed){
          onCardTap(stackkerWidget, index);
        }
      },
      child: Container(
        decoration: getStackkerDecoration(index),
        child: AnimatedSize(
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 150),
          child: SizedBox(
            height: getWidgetHeight(index),
            child: stackkerWidget.viewState == StackkerWidgetState.expanded ? 
              stackkerWidget.expandedView 
              : AnimatedSwitcher(
                duration: const Duration(milliseconds: 50),
                transitionBuilder: (child, animation){
                  return FadeTransition(opacity: animation,child: child,);
                },
                child: index <= selectedWidgetIndex+1 ? Column(
                  mainAxisAlignment:index==selectedWidgetIndex+1 ? MainAxisAlignment.center : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildCollapsedView(stackkerWidget, index),
                  ],
                ) : const SizedBox(height: 0,)),
          ),
        ),
      ),
    );
  }

  Widget buildCollapsedView(StackkerUiDm stackkerWidget, int index){
    if(index==selectedWidgetIndex+1){
      return Center(child: Text(stackkerWidget.actionTitle, style: Theme.of(context).textTheme.bodyMedium,));
    }
    return SizedBox(
      height: collapsedHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Padding(
              padding: EdgeInsets.all(PaddingConstants.padding12),
              child: stackkerWidget.collapsedView,
            )),
            const Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Icon(Icons.expand_more),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration getStackkerDecoration(int index){
    return BoxDecoration(
      color:index>selectedWidgetIndex ? Theme.of(context).primaryColor :
       Theme.of(context).cardTheme.color,
       boxShadow: [
        BoxShadow(
          color: Theme.of(context).cardTheme.shadowColor!,
          offset: const Offset(0.0, 10.0),
          blurRadius:index>selectedWidgetIndex ? 0.0 : 12.0,
          spreadRadius: index>selectedWidgetIndex ? 0.0 : 12.0
        )],
      borderRadius: const  BorderRadius.vertical(top: Radius.circular(25))
    );
  }

  double getWidgetHeight(int index){    
    if(index<=selectedWidgetIndex){
      return expandedHeight - ((index) * collapsedHeight);
    }
    else if(index > selectedWidgetIndex){
      return collapsedHeight;
    }
    return 0;
  }

  void onCardTap(StackkerUiDm stackkerWidget, int index){
    //Collapsing the current expanded card
    if(selectedWidgetIndex >= 0){
      widgetList[selectedWidgetIndex].viewState = StackkerWidgetState.collapsed;
    }

    //Expanding the tapped collapsed card
    selectedWidgetIndex = index;
    widgetList[selectedWidgetIndex].viewState = StackkerWidgetState.expanded;

    //Send callback to the parent widget that the card is selected
    widget.onSelectedPage?.call(selectedWidgetIndex);

    //Refreshing the stacked card widgets
    setStackList();
    scrollController.jumpTo(scrollController.position.minScrollExtent);
    setState(() {});        
  }

  void setStackList({int? length}){
    var defaultLength = stackList.length > widgetList.length ? widgetList.length : stackList.length;
    stackList = List<Widget>.generate(length ?? defaultLength, (index){
      return cardView(widgetList[index], index);
    }).toList();
  }
}

