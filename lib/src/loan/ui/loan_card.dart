import 'package:stackker_demo/utils/app_core.dart';

class LoanCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final Widget child;
  const LoanCard({Key? key, required this.title, required this.subTitle, required this.child}) : super(key: key);

  @override
  State<LoanCard> createState() => _LoanCardState();
}

class _LoanCardState extends State<LoanCard> {
  
  static double get _screenHeight => AppSingleton().screenSize.height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: PaddingConstants.padding24, left: PaddingConstants.padding24, right: PaddingConstants.padding24, bottom: _screenHeight * 0.1 + PaddingConstants.padding8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: PaddingConstants.padding12),
            child: Text(
              widget.subTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Flexible(
            child: widget.child       
          )
        ],
      ),
    );

  }
}