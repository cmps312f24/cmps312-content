import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalapay/models/cheque.dart';
import 'package:yalapay/models/cheque_image.dart';
import 'package:yalapay/repositories/app_repository.dart';

class ChequeProvider extends Notifier<List<Cheque>> {
  final AppRepository _appRepository = AppRepository();
  final chequeImages = (List<ChequeImage>.generate(7, (index) => ChequeImage(id: index+100, image: 'cheque${index + 1}.jpg')));
  @override
  List<Cheque> build() {
    initalizeState();
    return [];
  }

  void initalizeState() async {
     state = (await _appRepository.initCheques()).reversed.toList();
  }

  Cheque getChequeById(int id) {
    return _appRepository.getChequeById(id);
  }
  
  void getByDate(DateTime fromDate,DateTime toDate){
    state = _appRepository.getByDate(fromDate, toDate).reversed.toList();
  }

  void addCheque(Cheque cheque) {
     _appRepository.addCheque(cheque);
     state = List.from(_appRepository.cheques.reversed);
  }

  void updateCheque(Cheque cheque) {
    _appRepository.updateCheque(cheque);
    state = List.from(_appRepository.cheques.reversed);
    
  }

  List<Cheque> filterList(String status){
    return List.from(_appRepository.filterList(status));
  }

  void deleteCheque(Cheque cheque) {
    _appRepository.deleteCheque(cheque);
    state = List.from(_appRepository.cheques.reversed);
  }

  double getTotalAmount(List<Cheque> cheques){
    return _appRepository.getTotalAmount(cheques);
  }

  (List<Cheque>, int amount, double totalAmount) filterChequeReport(DateTime fromDate, DateTime toDate, String status){
    List<Cheque> cheques = List.from(_appRepository.cheques);
    int length = 0;

    if(status != 'All'){
      cheques = cheques.where((element) => element.status.toLowerCase() == status.toLowerCase() && element.receivedDate.isAfter(fromDate) && element.receivedDate.isBefore(toDate)).toList();
    }
    else{
      cheques = cheques.where((element) => element.receivedDate.isAfter(fromDate) && element.receivedDate.isBefore(toDate)).toList();
    }

    length = cheques.length;

    double total = 0.0;

    for (var cheque in cheques) {
      total+=cheque.amount;
    }

    return (cheques, length, total);
  }

  void resetState() {
    state = List.from(_appRepository.cheques.reversed);
  }
}
final chequeProviderNotifier = NotifierProvider<ChequeProvider, List<Cheque>>(() => ChequeProvider());