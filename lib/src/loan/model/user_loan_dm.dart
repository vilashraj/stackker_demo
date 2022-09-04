import 'package:stackker_demo/utils/app_core.dart';

class UserLoanDm {
  String name;
  double maxLoan;
  double recommendedLoan;
  double minLoan;
  double? desiredLoan;
  List<int> emiMonths;
  int? recommendedTenure;
  int? desiredTenure;
  BankDm? selectedBank;
  List<BankDm> banks;
  double? interestRate;
  UserLoanDm({
    required this.name,
    required this.maxLoan,
    required this.recommendedLoan,
    required this.minLoan,
    this.desiredLoan,
    required this.emiMonths,
    this.recommendedTenure,
    this.selectedBank,
    required this.interestRate,
    required this.banks,
  }){
    selectedBank = banks.first;
    desiredLoan = recommendedLoan;
    recommendedTenure = emiMonths.first;
    desiredTenure = emiMonths.first;
  }

  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'maxLoan': maxLoan,
      'recommendedLoan': recommendedLoan,
      'minLoan': minLoan,
      'desiredLoan': desiredLoan,
      'emiMonths': emiMonths,
      'recommendedEmiLoan': recommendedTenure,
      'selectedBank': selectedBank?.toMap(),
      'banks': banks.map((x) => x.toMap()).toList(),
      'interestRate': interestRate,
    };
  }

  factory UserLoanDm.fromMap(Map<String, dynamic> map) {
    return UserLoanDm(
      name: map['name'] ?? '',
      maxLoan: map['maxLoan']?.toDouble() ?? 0.0,
      recommendedLoan: map['recommendedLoan']?.toDouble() ?? 0.0,
      minLoan: map['minLoan']?.toDouble() ?? 0.0,
      desiredLoan: map['desiredLoan']?.toDouble(),
      emiMonths: List<int>.from(map['emiMonths']),
      recommendedTenure: map['recommendedEmiLoan']?.toInt(),
      selectedBank: map['selectedBank'] != null ? BankDm.fromMap(map['selectedBank']) : null,
      banks: List<BankDm>.from(map['banks']?.map((x) => BankDm.fromMap(x))),
      interestRate: map['interestRate']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoanDm.fromJson(String source) => UserLoanDm.fromMap(json.decode(source));
}

class BankDm {
  String name;
  String iconPath;
  String accountNo;
  BankDm({
    required this.name,
    required this.iconPath,
    required this.accountNo,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iconPath': iconPath,
      'accountNo': accountNo,
    };
  }

  factory BankDm.fromMap(Map<String, dynamic> map) {
    return BankDm(
      name: map['name'] ?? '',
      iconPath: map['iconPath'] ?? '',
      accountNo: map['accountNo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BankDm.fromJson(String source) => BankDm.fromMap(json.decode(source));
}
