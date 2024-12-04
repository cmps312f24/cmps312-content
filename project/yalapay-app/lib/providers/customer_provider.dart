import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalapay/models/customer.dart';
import 'package:yalapay/repositories/app_repository.dart';

class CustomerProvider extends Notifier<List<Customer>> {
   final AppRepository _appRepository = AppRepository();

  @override
  List<Customer> build() {
    initalizeState();
    return [];
  }

  void initalizeState() async {
    state = (await _appRepository.initCustomers()).reversed.toList();
  }

  void searchCustomers(String text){
    state = List.from(_appRepository.searchCustomers(text).reversed);
  }

  Customer? getCustomerById(int id) {
    return _appRepository.getCustomerById(id);
  }

  void addCustomer(Customer customer){
    _appRepository.addCustomer(customer);
    state = List.from(_appRepository.customers.reversed);
  }

  void deleteCustomer(Customer customer){
    _appRepository.deleteCustomer(customer);
    state = List.from(_appRepository.customers.reversed);
  }

  void updateCustomer(Customer customer){
    _appRepository.updateCustomer(customer);
    state = List.from(_appRepository.customers.reversed);
  }

  int getlastId(){
    return _appRepository.customers.last.id;
  }

  void resetState(){
    state = List.from(_appRepository.customers.reversed);
  }

}

final customerProviderNotifier = NotifierProvider<CustomerProvider, List<Customer>>(() => CustomerProvider());