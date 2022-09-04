import 'package:stackker_demo/utils/app_core.dart';

class KycScreen extends StatelessWidget {
  final VoidCallback onDone;
  const KycScreen({Key? key, required this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoanCard(
      title: appTranslationService.text('key_kyc_completed')!, 
      subTitle: appTranslationService.text('key_amount_credited')!, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: PaddingConstants.padding16),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: AppSingleton().screenSize.width/6,
            backgroundImage: AssetImage(AppAssets.kycCompletedGif)),
          ActionButton(title: appTranslationService.text('key_done')!, onTap: onDone)
        ],
      )
    );
  }
}