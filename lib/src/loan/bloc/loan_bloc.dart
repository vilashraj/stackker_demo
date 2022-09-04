import 'package:stackker_demo/utils/app_core.dart';

abstract class LoanApplicationEvent{}
class FetchLoanApplicationEvent extends LoanApplicationEvent{}
class ResetBloc extends LoanApplicationEvent{}

abstract class LoanApplicationState{}
class LoanApplicationInitial extends LoanApplicationState{}
class LoanApplicationLoading extends LoanApplicationState{}
class LoanApplicationLoaded extends LoanApplicationState{
  UserLoanDm userLoanDm;
  LoanApplicationLoaded(this.userLoanDm);
}
class LoanApplicationError extends LoanApplicationState{
  String error;
  LoanApplicationError(this.error);
}

class LoanApplicationBloc extends Bloc<LoanApplicationEvent,LoanApplicationState>{
  LoanApplicationBloc():super(LoanApplicationInitial()){
    on<FetchLoanApplicationEvent>(_mapFetchLoanApplicationEventToState);
    on<ResetBloc>(_mapResetBlocEventToState);
  }

  final ApiClientService _apiClientService = ApiClientService();

  FutureOr _mapFetchLoanApplicationEventToState(FetchLoanApplicationEvent event, Emitter<LoanApplicationState> emit)async{
    try{
      emit(LoanApplicationLoading());
      UserLoanDm userLoanDm = await _apiClientService.fetchUserLoanApplication();
      emit(LoanApplicationLoaded(userLoanDm));
    }
    catch(e){
      emit(LoanApplicationError(e.toString()));
    }
  }
  FutureOr _mapResetBlocEventToState(ResetBloc event, Emitter<LoanApplicationState> emit)async{
    emit(LoanApplicationInitial());
  }
}

