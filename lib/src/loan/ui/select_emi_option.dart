import 'package:stackker_demo/utils/app_core.dart';

class SelectEmiOption extends StatefulWidget {
  final UserLoanDm userLoanDm;
  const SelectEmiOption({Key? key, required this.userLoanDm}) : super(key: key);

  @override
  State<SelectEmiOption> createState() => _SelectEmiOptionState();
}

class _SelectEmiOptionState extends State<SelectEmiOption> {

  Size get screenSize => AppSingleton().screenSize;

  @override
  Widget build(BuildContext context) {
    return LoanCard(
      title: appTranslationService.text('key_how_do_wish_to_repay')!, 
      subTitle: appTranslationService.text('key_choose_one_plan')!, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getEmiList(),
          SizedBox(
            height: PaddingConstants.padding12,
          ),
          createOwnPlan()
        ],
      )
    );
  }

  Widget getEmiList(){
    return SizedBox(
      height: screenSize.width/2,
      width: double.infinity,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.userLoanDm.emiMonths.length,
          itemBuilder: (context, index){
            return emiTileWidget(index);
          }
        ),
      ),
    );
  }

  Widget emiTileWidget(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: GestureDetector(
        onTap: (){
          setState(() {
            widget.userLoanDm.desiredTenure = widget.userLoanDm.emiMonths[index];
          });
        },
        child: Container(
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: AppTheme.cardColorList(context)[index]
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              emiTile(index),
              recommendedTag(index)
            ],
          ),
        ),
      ),
    );
  }

  Widget emiTile(int index){
    bool isSelected =  widget.userLoanDm.desiredTenure == widget.userLoanDm.emiMonths[index];
    return SizedBox(
      width: screenSize.width/2.75,
      child: Padding(
        padding: EdgeInsets.all(PaddingConstants.padding12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tenureSelectionCheckBoxIcon(isSelected),
            calculatedEmi(index),
            seeCalculation()
          ],
        ),
      ),
    );
  }

  Widget recommendedTag(int index){
    return Visibility(
      visible: widget.userLoanDm.recommendedTenure == widget.userLoanDm.emiMonths[index],
      child: Positioned(
        top: -10,
        child: Card(
          elevation: 5.0,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: PaddingConstants.padding4, horizontal: PaddingConstants.padding16),
              child: Text(appTranslationService.text('key_recommended')!, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).cardTheme.color, fontSize: 12),),
            )
          ),
        )
      )
    );
  }

  Widget tenureSelectionCheckBoxIcon(bool isSelected){
    return Padding(
      padding: EdgeInsets.only(bottom: PaddingConstants.padding8),
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
            ? Colors.black12.withOpacity(0.1) :
            null,
          border: Border.all(
            width: 1, 
            color: isSelected
              ? Colors.transparent
              : Colors.white
          )
        ),
        child: Visibility(
          visible: isSelected,
          child: const Center(
            child: Icon(Icons.check, color: Colors.white, size: 20,),
          )
        ),
      ),
    );
  }

  Widget calculatedEmi(int index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                AppConstants.currencyFormat.format(
                  AppHelper.emi(
                    principalAmount: widget.userLoanDm.desiredLoan!, 
                    rate: widget.userLoanDm.interestRate!/100, 
                    tenure: widget.userLoanDm.emiMonths[index]
                  )
                ),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
              Text(appTranslationService.text('key_per_month')!, 
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white.withOpacity(0.5)),
              )
        
            ],
          ),
        ),
        SizedBox(height: PaddingConstants.padding8,),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('${appTranslationService.text('key_for')} ${widget.userLoanDm.emiMonths[index].toString()} ${appTranslationService.text('key_months')}', 
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white.withOpacity(0.75), fontWeight: FontWeight.normal, fontSize: 14),
          ),
        )
      ],
    );
  }
  
  Widget seeCalculation(){
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(appTranslationService.text('key_see_calculations')!, 
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Colors.white.withOpacity(0.5),
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed
        ),
      ),
    );
  }

  Widget createOwnPlan(){
    return ActionButton(
      title: appTranslationService.text('key_create_own_plan')!,
      onTap: (){},
    );
  }
} 