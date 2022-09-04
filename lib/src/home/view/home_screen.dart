import 'package:stackker_demo/utils/app_core.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isVisible = false;
  UserLoanDm? userLoanDm;
  LoanApplicationBloc loanApplicationBloc = LoanApplicationBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    loanApplicationBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    AppSingleton().screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                   AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation){
                      return ScaleTransition(
                        scale: animation,
                        alignment: Alignment.bottomCenter,
                        child: child,
                      );
                    },
                    child: _buildLoanApplicationBlocWidget()
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanApplicationBlocWidget(){
    return BlocConsumer(
      bloc: loanApplicationBloc,
      listener: (context, state){
        if(state is LoanApplicationError){
          //todo: show error 
        }
      },
      builder: (context, LoanApplicationState state){
        if(state is LoanApplicationInitial){
          return _buildStartButton();
        }
        else if(state is LoanApplicationLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is LoanApplicationLoaded){
          return _buildStackker(state.userLoanDm);
        }
        return const SizedBox();
      }
    );
  }

  Widget _buildStartButton(){
    return Visibility(
      visible: !isVisible,
      child: Align(
        alignment: Alignment.center,
        child: ActionButton(
          title: appTranslationService.text('key_start')!, 
          onTap: onStartTap
        ),
      )
    );
  }

  Widget _buildStackker(UserLoanDm userLoanDm){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all( PaddingConstants.padding12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIconButton(onTap: onDone, icon: Icons.close_rounded),
              _buildIconButton(onTap: (){}, icon: Icons.question_mark),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Stackker(
              widgetList: [
                StackkerUiDm(
                  collapsedView: SelectLoanAmountCollapsed(userLoanDm: userLoanDm,), 
                  expandedView: SelectLoanAmount(userLoanDm: userLoanDm,), 
                  actionTitle: appTranslationService.text('key_apply_for_loan')!,
                ),
                StackkerUiDm(
                  collapsedView: SelectEmiOptionCollapsed(userLoanDm: userLoanDm,), 
                  expandedView: SelectEmiOption(userLoanDm: userLoanDm,), 
                  actionTitle: appTranslationService.text('key_proceed_for_emi_selection')!
                ),
                StackkerUiDm(
                  collapsedView: SelectBankCollapsed(userLoanDm: userLoanDm,), 
                  expandedView: SelectBank(userLoanDm: userLoanDm,), 
                  actionTitle: appTranslationService.text('key_select_your_bank_account')!
                ),
                StackkerUiDm(
                  collapsedView: Container(), 
                  expandedView: KycScreen(onDone: onDone), 
                  actionTitle: appTranslationService.text('key_tap_for_kyc')!
                ),
              ],
            )
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton({required VoidCallback onTap, required IconData icon}){
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:Theme.of(context).cardTheme.color?.withOpacity(0.7)
        ),
        child: Padding(
          padding: EdgeInsets.all(PaddingConstants.padding8),
          child: Icon(icon, size: 20,),
        ),
      ),
    );
  }


  //ACTIONS
  void onStartTap(){
    loanApplicationBloc.add(FetchLoanApplicationEvent());
  }

  void onDone(){
    loanApplicationBloc.add(ResetBloc());
  }
}

