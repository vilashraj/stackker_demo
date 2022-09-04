import 'package:stackker_demo/utils/app_core.dart';

class KeyValue extends StatefulWidget {
  final String title;
  final String subTitle;
  const KeyValue({Key? key, required this.title, required this.subTitle}) : super(key: key);

  @override
  State<KeyValue> createState() => _KeyValueState();
}

class _KeyValueState extends State<KeyValue> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: PaddingConstants.padding8),
        Text(widget.subTitle, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}