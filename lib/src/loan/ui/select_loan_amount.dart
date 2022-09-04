import 'package:stackker_demo/utils/app_core.dart';

class SelectLoanAmount extends StatefulWidget {
  final UserLoanDm userLoanDm;

  const SelectLoanAmount({Key? key, required this.userLoanDm}) : super(key: key);

  @override
  State<SelectLoanAmount> createState() => _SelectLoanAmountState();
}

class _SelectLoanAmountState extends State<SelectLoanAmount> {

  double amountSelected = 50000;
  UserLoanDm get userLoanDm => widget.userLoanDm;

  @override
  Widget build(BuildContext context) {
    return LoanCard(
      title: '${widget.userLoanDm.name}, ${appTranslationService.text('key_how_much_do_you_need')}',
      subTitle: '${appTranslationService.text('key_move_dial_and_set_upto')} ${AppConstants.currencyFormat.format(userLoanDm.maxLoan)}',
      child: Card(
        elevation: 0.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: Padding(
        padding: EdgeInsets.all(PaddingConstants.padding24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: PaddingConstants.padding12,),
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    counterClockwise: false,
                    animationEnabled: true,
                    startAngle: 100,
                    infoProperties: InfoProperties(),
                    angleRange: 340,
                    size: AppSingleton().screenSize.width * 0.6,
                    customWidths: CustomSliderWidths(
                      trackWidth: PaddingConstants.padding24,
                      progressBarWidth: PaddingConstants.padding24,
                    ),
                    customColors: CustomSliderColors(
                      progressBarColor: const Color.fromRGBO(209, 141, 110, 1.0),
                      trackColor: const Color.fromRGBO(252, 234, 221, 1.0),
                      hideShadow: true,
                    )
                  ),
                min: userLoanDm.minLoan,
                max: userLoanDm.maxLoan,
                initialValue: userLoanDm.desiredLoan!,
                onChange: (value){
                  userLoanDm.desiredLoan = double.parse(value.toStringAsFixed(0));
                },
                innerWidget: (value){
                  return Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appTranslationService.text('key_credit_amount')!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: PaddingConstants.padding8,),
                      Text(
                        AppConstants.currencyFormat.format(double.parse(value.toStringAsFixed(0))),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).canvasColor),
                      ),
                      SizedBox(height: PaddingConstants.padding8,),
                      Text(
                        '@1.04% ${appTranslationService.text('key_monthly')}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 10, color: Colors.lightGreen),
                      ),
                    ],
                  ));
                },
            ),
              ),
              SizedBox(height: PaddingConstants.padding24,),
              Text(
                appTranslationService.text('key_stash_is_instant')!,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ]
          ),
        ),
      )
    );
  }
}

class SelectEmiOptionCollapsed extends StatelessWidget {
  final UserLoanDm userLoanDm;
  const SelectEmiOptionCollapsed({Key? key, required this.userLoanDm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: KeyValue(
            title: appTranslationService.text('key_emi')!, 
            subTitle: '${AppConstants.currencyFormat.format(AppHelper.emi(principalAmount: userLoanDm.desiredLoan!, rate: userLoanDm.interestRate!/100, tenure: userLoanDm.desiredTenure!))} ${appTranslationService.text('key_per_month')}'
          ),
        ),
        Expanded(
          child: KeyValue(
            title: appTranslationService.text('key_duration')!, 
            subTitle: '${userLoanDm.desiredTenure} ${appTranslationService.text('key_months')}'
          ),
        ),

      ],
    );
  }
}

class SelectLoanAmountCollapsed extends StatelessWidget {
  final UserLoanDm userLoanDm;
  const SelectLoanAmountCollapsed({Key? key, required this.userLoanDm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyValue(
      title: appTranslationService.text('key_credit_amount')!, 
      subTitle: AppConstants.currencyFormat.format(userLoanDm.desiredLoan)
    );
  }
}

