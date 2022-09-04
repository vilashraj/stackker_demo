import 'package:stackker_demo/utils/app_core.dart';

class LoanApi{
  static Future<UserLoanDm> fetchUserLoanApplication()async{
    //todo: Perform API Call to fetch user loan
    return UserLoanDm(
      name: 'vilash', 
      maxLoan: 500000, 
      recommendedLoan: 150000, 
      minLoan: 10000, 
      emiMonths: [12,9,6,3],
      interestRate: 1.04, 
      banks: [
        BankDm(
          name: 'HDFC Bank', 
          iconPath: AppAssets.hdfcLogo,
          accountNo: '8382273727172'
        ),
        BankDm(
          name: 'ICICI Bank', 
          iconPath: AppAssets.iciciLogo,
          accountNo: '6216712727461'
        ),
      ]
    );
  }
}