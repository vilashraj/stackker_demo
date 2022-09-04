import 'package:stackker_demo/utils/app_core.dart';

class ApiClientService{
 
  static final ApiClientService _singleton = ApiClientService._internal();

  factory ApiClientService() {
    return _singleton;
  }

  ApiClientService._internal();

  //Loan API
  Future<UserLoanDm> fetchUserLoanApplication()async{
    return LoanApi.fetchUserLoanApplication();
  }

}