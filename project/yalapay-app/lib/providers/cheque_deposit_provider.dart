import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalapay/models/bank_account.dart';
import 'package:yalapay/models/cheque_deposit.dart';
import 'package:yalapay/repositories/app_repository.dart';

class ChequeDepositProvider extends Notifier<List<ChequeDeposit>> {
  final AppRepository _appRepository = AppRepository();

  @override
  List<ChequeDeposit> build() {
    initalizeState();
    return [];
  }

  void initalizeState() async {
    await _appRepository.initBankAccounts();
    state = (await _appRepository.initChequeDeposits()).reversed.toList();
  }

  void searchChequeDeposits(String text){
    state = List.from(_appRepository.searchChequeDeposits(text).reversed);
  }

  ChequeDeposit? getChequeDepositById(int id) {
    return _appRepository.getChequeDepositById(id);
  }

  void addChequeDeposit(ChequeDeposit chequeDeposit){
    _appRepository.addChequeDeposit(chequeDeposit);
    state = List.from(_appRepository.chequeDeposits.reversed);
  }

  void deleteChequeDeposit(ChequeDeposit chequeDeposit){
    _appRepository.deleteChequeDeposit(chequeDeposit);
    state = List.from(_appRepository.chequeDeposits.reversed);
  }

  void updateChequeDeposit(ChequeDeposit chequeDeposit){
    _appRepository.updateChequeDeposit(chequeDeposit);
    state = List.from(_appRepository.chequeDeposits.reversed);
  }

  void updateChequeDepositOnChequeDelete(int chequeId){
    _appRepository.updateChequeDepositOnChequeDelete(chequeId);
    state = List.from(_appRepository.chequeDeposits.reversed);
  }

  List<BankAccount> get bankAccounts => _appRepository.bankAccounts;

  int getlastId(){
    return _appRepository.chequeDeposits.last.id;
  }

  void resetState(){
    state = List.from(_appRepository.chequeDeposits.reversed);
  }
}

final chequeDepositProviderNotifier = NotifierProvider<ChequeDepositProvider, List<ChequeDeposit>>(() => ChequeDepositProvider());