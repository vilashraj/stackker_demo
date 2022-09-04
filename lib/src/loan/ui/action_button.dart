import 'package:stackker_demo/utils/app_core.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const ActionButton({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).textTheme.titleLarge!.color!
          )
        ),
        child: Padding(
          padding: EdgeInsets.all(PaddingConstants.padding12),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).textTheme.titleLarge!.color!,
            fontWeight: FontWeight.w500
          ),),
        ),

      )
    );
  }
}