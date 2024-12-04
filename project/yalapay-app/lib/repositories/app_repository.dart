import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalapay/models/bank_account.dart';
import 'package:yalapay/models/cheque.dart';
import 'package:yalapay/models/cheque_deposit.dart';
import 'package:yalapay/models/customer.dart';
import 'package:yalapay/models/invoice.dart';
import 'package:yalapay/models/payment.dart';
import 'package:yalapay/models/users.dart';

class AppRepository {
  List<Customer> _customers = [];
  List<Invoice> _invoices = [];
  List<Payment> _payments = [];
  List<Cheque> _cheques = [];
  List<ChequeDeposit> _chequeDeposits = [];
  List<Users> _users = [];
  List<BankAccount> _bankAccounts = [];
  List<String> _banks = [];

  AppRepository();

  // ----------------| Customers Section |----------------
  Future<List<Customer>> initCustomers() async {
    var customerData = await rootBundle.loadString('assets/data/customers.json');
    var customersMap = jsonDecode(customerData);

    _customers = customersMap.map<Customer>((customer) => Customer.fromJson(customer)).toList();
    return _customers;
  }

  Customer? getCustomerById(int id) {
    try {

      return _customers.firstWhere((customer) => customer.id == id);

    } 
    catch (e) {

      return null;

    }

  }

  List<Customer> get customers => _customers;

  set customers(List<Customer> customers) => _customers = customers;

  List<Customer> searchCustomers(String text) {
    final isInteger = int.tryParse(text) != null;

    if(isInteger) {
      return customers.where((customer) => customer.id == int.parse(text)).toList();
    }
    else{
      return customers.where((customer) => customer.containsText(text.toLowerCase())).toList();
    }
  }

  void addCustomer(Customer customer) {
    _customers.add(customer);
  }

  void deleteCustomer(Customer customer) {
    _customers.remove(customer);
  }

  void updateCustomer(Customer customer) {
    int index = _customers.indexWhere((element) => element.id == customer.id);
    _customers[index] = customer;
  }


  // ----------------| Invoices Section |----------------
  List<Invoice> get invoices => _invoices;
  set invoices(List<Invoice> invoices) => _invoices = invoices;

  Future<List<Invoice>> initInvoices() async {
    var invoiceData = await rootBundle.loadString('assets/data/invoices.json');
    var invoicesMap = jsonDecode(invoiceData);

    _invoices = invoicesMap.map<Invoice>((invoice) => Invoice.fromJson(invoice)).toList();
    return _invoices;
  }
  
  Invoice getInvoiceById(int id) {
    return _invoices.firstWhere((invoice) => invoice.id == id);
  }

  List<Invoice> searchInvoices(String text, List<Payment> payments, List<Cheque> cheques) {
    final isInteger = int.tryParse(text) != null;

    return invoices.where((invoice) {
      double amountDue = invoice.amount;
      bool containsAwaitingPayments = false;

      for (var payment in payments) {
        if(invoice.id == payment.invoiceNo) {
          if(payment.chequeNo > 0 ){
            Cheque cheque = cheques.firstWhere((cheque) => cheque.chequeNo == payment.chequeNo);

            if(cheque.status != 'Returned') {
              amountDue -= cheque.amount;
            }

            if(cheque.status == 'Deposited' || cheque.status == 'Awaiting') {
              containsAwaitingPayments = true;
            }
          }
          else {
            amountDue -= payment.amount;
          }
        }
      }

      bool matchesId = isInteger && invoice.id == int.parse(text);
      bool matchesDescription = invoice.containsText(text.toLowerCase());
      bool matchesStatus = ('due'.contains(text.toLowerCase()) && amountDue > 0) || 
      ('awaiting payments'.contains(text.toLowerCase()) && amountDue == 0 && containsAwaitingPayments) || 
      ('fully paid'.contains(text.toLowerCase()) && amountDue == 0 && !containsAwaitingPayments);

      return matchesId || matchesDescription || matchesStatus;
    }).toList();

  }

  void addInvoice(Invoice invoice) {
    _invoices.add(invoice);
  }

  void deleteInvoice(Invoice invoice) {
    _invoices.remove(invoice);
  }

  List<Invoice> getByInvoiceDate(DateTime fromDate,DateTime toDate){
    return _invoices.where((invoice)=> invoice.invoiceDate.isAfter(fromDate) && invoice.dueDate.isBefore(toDate)).toList();
  }


  void updateInvoice(Invoice invoice) {
    int index = _invoices.indexWhere((element) => element.id == invoice.id);
    _invoices[index] = invoice;
  }


  // ----------------| Payments Section |----------------
  List<Payment> get payments => _payments;
  set payments(List<Payment> payments) => _payments = payments;

  Future<List<Payment>> initPayments() async {
    var paymentData = await rootBundle.loadString('assets/data/payments.json');
    var paymentsMap = jsonDecode(paymentData);

    _payments = paymentsMap.map<Payment>((payment) => Payment.fromJson(payment)).toList();
    return _payments;
  }

  Future<List<String>> initBanks() async {
    var bankData = await rootBundle.loadString('assets/data/banks.json');
    var banksMap = jsonDecode(bankData);

    _banks = banksMap.cast<String>();
    return _banks;
  }

  get banks => _banks;

  Payment getPaymentById(int id) {
    return _payments.firstWhere((payment) => payment.id == id);
  }

  List<Payment> getPaymentsByInvoiceNo(int invoiceNo) {
    return _payments.where((payment) => payment.invoiceNo == invoiceNo).toList();
  }

  List<Payment> searchPayments(String text, List<Cheque> cheques) {
    final isInteger = int.tryParse(text) != null;

    return payments.where((payment) {
      bool matchesId = isInteger && payment.id == int.parse(text);

      bool matchesContent = payment.containsText(text.toLowerCase());

      bool matchesChequeStatus = false;

      bool matchChequeDetails = false;

      if (payment.chequeNo > 0) {
        Cheque? cheque = cheques.firstWhere((cheque) => cheque.chequeNo == payment.chequeNo);
        matchesChequeStatus = cheque.status.toLowerCase().contains(text.toLowerCase());
      }

      if(payment.paymentMode.toLowerCase() == 'cheque'){
        Cheque? cheque = cheques.firstWhere((cheque) => cheque.chequeNo == payment.chequeNo);
        matchChequeDetails = cheque.containsText(text.toLowerCase());
      }

      return matchesId || matchesContent || matchesChequeStatus || matchChequeDetails;
    }).toList();
  }

  void addPayment(Payment payment) {
    _payments.add(payment);
  }

  void deletePayment(Payment payment) {
    _payments.remove(payment);
  }

  void updatePayment(Payment payment) {
    int index = _payments.indexWhere((element) => element.id == payment.id);
    _payments[index] = payment;
  }

  // ----------------| Cheque Section |----------------
  List<Cheque> get cheques => _cheques;
  set cheques(List<Cheque> cheques) => _cheques = cheques;

  Future<List<Cheque>> initCheques() async {
    var chequeData = await rootBundle.loadString('assets/data/cheques.json');
    var chequesMap = jsonDecode(chequeData);

    _cheques = chequesMap.map<Cheque>((cheque) => Cheque.fromJson(cheque)).toList();
    return _cheques;
  }

  List<Cheque> getByDate(DateTime fromDate,DateTime toDate){
    return _cheques.where((cheque)=> cheque.receivedDate.isAfter(fromDate) && cheque.receivedDate.isBefore(toDate) ).toList();
  }

  void addCheque(Cheque cheque) {
    _cheques.add(cheque);
  }

  void updateCheque(Cheque cheque) {
    int index = _cheques.indexWhere((element) => element.chequeNo == cheque.chequeNo);
    _cheques[index] = cheque;
  }

  void deleteCheque(Cheque cheque) {
    _cheques.remove(cheque);
  }

  Cheque getChequeById(int id) {
    return _cheques.firstWhere((cheque) => cheque.chequeNo == id);
  }

  List<Cheque> filterList(String status){
    return _cheques.where((element) => element.status.toLowerCase() == status.toLowerCase()).toList();
  }

  double getTotalAmount(List<Cheque> cheques){
    double total = 0.0;
    for (var cheque in cheques) {
      total+=cheque.amount;
    }
    return total;
  }

  // ----------------| Cheque Deposit Section |----------------
  List<ChequeDeposit> get chequeDeposits => _chequeDeposits;
  set chequeDeposits(List<ChequeDeposit> chequeDeposits) => _chequeDeposits = chequeDeposits;

  Future<List<ChequeDeposit>> initChequeDeposits() async {
    var chequeDepositData = await rootBundle.loadString('assets/data/cheque-deposits.json');
    var chequeDepositsMap = jsonDecode(chequeDepositData);

    _chequeDeposits = chequeDepositsMap.map<ChequeDeposit>((chequeDeposit) => ChequeDeposit.fromJson(chequeDeposit)).toList();

    return _chequeDeposits;
  }

  Future<List<BankAccount>> initBankAccounts() async {
    var bankAccountData = await rootBundle.loadString('assets/data/bank-accounts.json');
    var bankAccountsMap = jsonDecode(bankAccountData);

    _bankAccounts = bankAccountsMap.map<BankAccount>((bankAccount) => BankAccount.fromJson(bankAccount)).toList();
    return _bankAccounts;
  }

  ChequeDeposit getChequeDepositById(int id) {
    return _chequeDeposits.firstWhere((chequeDeposit) => chequeDeposit.id == id);
  }

  List<ChequeDeposit> searchChequeDeposits(String text) {
    final isInteger = int.tryParse(text) != null;

    if(isInteger) {
      List<ChequeDeposit> tempID =  chequeDeposits.where((chequeDeposit) => chequeDeposit.id == int.parse(text)).toList();
      List<ChequeDeposit> tempChequeNo = chequeDeposits.where((chequeDeposit) => chequeDeposit.chequeNos.contains(int.parse(text))).toList();
      return [...tempID, ...tempChequeNo];
    }
    else{
      return chequeDeposits.where((chequeDeposit) => chequeDeposit.containsText(text.toLowerCase())).toList();
    }
  }

  void addChequeDeposit(ChequeDeposit chequeDeposit) {
    _chequeDeposits.add(chequeDeposit);
  }

  void deleteChequeDeposit(ChequeDeposit chequeDeposit) {
    _chequeDeposits.remove(chequeDeposit);
  }

  void updateChequeDeposit(ChequeDeposit chequeDeposit) {
    int index = _chequeDeposits.indexWhere((element) => element.id == chequeDeposit.id);
    _chequeDeposits[index] = chequeDeposit;
  }

  void updateChequeDepositOnChequeDelete(int chequeNo) {
    List<ChequeDeposit> temp = [];

    for (var chequeDeposit in _chequeDeposits) {
      if(chequeDeposit.chequeNos.contains(chequeNo)) {
        chequeDeposit.chequeNos.remove(chequeNo);
        
        if(chequeDeposit.chequeNos.isEmpty) {
          temp.add(chequeDeposit);
        }
      }
    }

    for (var chequeDeposit in temp) {
      _chequeDeposits.remove(chequeDeposit);
    }
  }

  get bankAccounts => _bankAccounts;

  // ----------------| Login Section |----------------
  List<Users> get users => _users;
  set users(List<Users> users) => _users = users;

  Future<List<Users>> initUsers() async {
    var userData = await rootBundle.loadString('assets/data/users.json');
    var usersMap = jsonDecode(userData);

    _users = usersMap.map<Users>((user) => Users.fromJson(user)).toList();
    return _users;
  }

  Users getUserByUserName(String userName) {
    Users user = _users.firstWhere((user) => user.email.split('@')[0].toLowerCase() == userName, orElse: () => Users('error', 'error', 'error', 'error'));
    return user;
  }

  Future<String> getUserBySession() async{
    final prefs = await SharedPreferences.getInstance();
    String sessionUserName = prefs.getString('sessionUserName') ?? '';

    return getUserByUserName(sessionUserName).firstName;
  }

  Future<bool> loginUser(String userName, String password) async {
    bool valid = await validateSession(userName.toLowerCase());
    if(valid) {
      Users user = getUserByUserName(userName);
      if(user.email.toLowerCase().split('@')[0] == userName && user.password == password) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('sessionUserName', userName);
        return true;
      }
      else {
        return false;
      }
    }
    return false;
  }

  Future<bool> validateSession(String username) async {
    final prefs = await SharedPreferences.getInstance();
    String sessionUserName = prefs.getString('sessionUserName') ?? '';
    if(sessionUserName == '') {
      return true;
    }
    else if(sessionUserName == username) {
      return true;
    }
    return false;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    String sessionUserName = prefs.getString('sessionUserName') ?? '';
    if(sessionUserName == '') {
      return false;
    }
    return true;
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessionUserName', '');
  }
}