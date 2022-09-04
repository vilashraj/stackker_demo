import 'package:stackker_demo/utils/app_core.dart';

class SelectBank extends StatefulWidget {
  final UserLoanDm userLoanDm;
  const SelectBank({Key? key, required this.userLoanDm}) : super(key: key);

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  @override
  Widget build(BuildContext context) {
    return LoanCard(
      title: appTranslationService.text('key_where_to_send_money')!,
      subTitle: appTranslationService.text('key_amount_will_credited_to_this_account')!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: PaddingConstants.padding16,),
          bankList(),
          SizedBox(height: PaddingConstants.padding16),
          ActionButton(title: appTranslationService.text('key_create_account')!, onTap: (){})
        ]
      ),
    );
  }

  Widget bankList(){
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.userLoanDm.banks.length,
        itemBuilder: (context, index){
          return bankTile(widget.userLoanDm.banks[index]);
        }
      ),
    );
  }

  Widget bankTile(BankDm bankDm){
    return GestureDetector(
      onTap: (){
        setState(() {
          widget.userLoanDm.selectedBank = bankDm;
        });        
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: PaddingConstants.padding16),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(PaddingConstants.padding4),
                  child: Image.asset(bankDm.iconPath, width: 30,),
                ),
              ),
            ),
            SizedBox(width: PaddingConstants.padding16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bankDm.name, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.normal)),
                  SizedBox(height: PaddingConstants.padding4,),
                  Text(bankDm.accountNo, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.normal),)
                ],
              ),
            ),
            bankSelectionCheckMark(widget.userLoanDm.selectedBank == bankDm)
          ],
        ),
      ),
    );
  }

  Widget bankSelectionCheckMark(bool isSelected){
    return Visibility(
      visible: isSelected,
      child: Padding(
        padding: EdgeInsets.only(bottom: PaddingConstants.padding8),
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:Theme.of(context).canvasColor.withOpacity(0.1)
          ),
          child: Center(
            child: Icon(Icons.check, color: Theme.of(context).canvasColor, size: 20,),
          ),
        ),
      ),
    );
  }

}


class SelectBankCollapsed extends StatefulWidget {
  final UserLoanDm userLoanDm;
  const SelectBankCollapsed({Key? key, required this.userLoanDm}) : super(key: key);

  @override
  State<SelectBankCollapsed> createState() => _SelectBankCollapsedState();
}

class _SelectBankCollapsedState extends State<SelectBankCollapsed> {
  @override
  Widget build(BuildContext context) {
    return bankTile(widget.userLoanDm.selectedBank!);
  }

  Widget bankTile(BankDm bankDm){
    return Row(
      children: [
        Container(
          height: 40,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(PaddingConstants.padding4),
              child: Image.asset(bankDm.iconPath, width: 30,),
            ),
          ),
        ),
        SizedBox(width: PaddingConstants.padding16,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(bankDm.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
              SizedBox(height: PaddingConstants.padding4,),
              Text(bankDm.accountNo, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.normal),)
            ],
          ),
        ),
      ],
    );
  }
}