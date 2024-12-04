import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/components/cheque_deposit_card.dart';
import 'package:yalapay/data_classes/cheque_deposit_args.dart';
import 'package:yalapay/models/bank_account.dart';
import 'package:yalapay/models/cheque.dart';
import 'package:yalapay/models/cheque_deposit.dart';
import 'package:yalapay/providers/cheque_checked_provider.dart';
import 'package:yalapay/providers/cheque_deposit_provider.dart';
import 'package:yalapay/providers/cheque_provider.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/providers/selected_cheques_provider.dart';
import 'package:yalapay/providers/updated_cheques_provider.dart';
import 'package:yalapay/routes/app_router.dart';

class AddChequeDepositScreen extends ConsumerStatefulWidget {
  final bool isAdd;
  final ChequeDeposit? chequeDeposit;
  const AddChequeDepositScreen({super.key, required this.isAdd, this.chequeDeposit});

  @override
  ConsumerState<AddChequeDepositScreen> createState() => _AddChequeDepositScreenState();
}

class _AddChequeDepositScreenState extends ConsumerState<AddChequeDepositScreen>{
  String? selectedBankAccount;
  List<Cheque> cheques = [];

  double? amount;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final watchChequeCheck = ref.watch(chequeCheckProviderNotifier);
      final readChequeCheckNotifier = ref.read(chequeCheckProviderNotifier.notifier);
      final watchUpdatedCheques = ref.watch(updatedChequesProviderNotifier);
      final bool logged = await ref.read(loginProviderNotifier.notifier).isLoggedIn();

      if(!watchChequeCheck){
      var check = watchUpdatedCheques.where((element) => element.status == 'Cashed');

      if(check.length == watchUpdatedCheques.length && check.isNotEmpty){
          readChequeCheckNotifier.toggle();
        }
      }

      if(!logged){
        GoRouter.of(context).go(AppRouter.error.path);
      }
    });
  }

  void setAmount(double value) {
    setState(() {
      amount = value;
    });
  }

  void setCheques(List<Cheque> value) {
    setState(() {
      cheques = value;
    });
  }

  void getTotalChequeAmount() {
    double totalAmount = 0;

    if(cheques.isEmpty) {
      setAmount(0);
      return;
    }

    for (var cheque in cheques) {
      totalAmount += cheque.amount;
    }
    setAmount(totalAmount);
  }

  void showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

                 
  @override
  Widget build(BuildContext context) {
    final watchChequeCheck = ref.watch(chequeCheckProviderNotifier);
    final readChequeCheckNotifier = ref.read(chequeCheckProviderNotifier.notifier);
    final watchSelectedCheques = ref.watch(selectedChequeProviderNotifier);
    final watchUpdatedCheques = ref.watch(updatedChequesProviderNotifier);
    final readUpdatedChequesNotifier = ref.read(updatedChequesProviderNotifier.notifier);
    final readChequeDepositNotifier = ref.read(chequeDepositProviderNotifier.notifier);
    final watchChequeDeposit = ref.watch(chequeDepositProviderNotifier);
    final readChequeNotifier = ref.read(chequeProviderNotifier.notifier);

    final router = GoRouter.of(context);

    cheques = watchSelectedCheques;
    List<BankAccount> bankAccounts = readChequeDepositNotifier.bankAccounts;

    if(!widget.isAdd){
      
      double temp = 0;
      watchSelectedCheques.clear();

      for(var no in widget.chequeDeposit!.chequeNos){
        temp += readChequeNotifier.getChequeById(no).amount;
        watchSelectedCheques.add(readChequeNotifier.getChequeById(no));
      }

      setAmount(temp);

      selectedBankAccount = widget.chequeDeposit!.bankAccountNo;

      bankAccounts = bankAccounts.where((element) => element.accountNumber == selectedBankAccount).toList();
    }
    else{
      getTotalChequeAmount();
    }

    var amountText = amount?.toStringAsFixed(2) ?? '0.00';
    
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child:
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 50,),
                  Container(
                    width: MediaQuery.of(context).size.width -75,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color:  const Color.fromARGB(255, 234, 234, 234),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: 
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.isAdd ? 
                            const Text(
                              "Add Cheque Deposit.",
                              style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold,),
                            ) :
                            const Text(
                              "Update Cheque Deposit.",
                              style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold,),
                            ),

                            const SizedBox(height: 18,),

                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.onetwothree,color: Colors.black,),
                                    const Text(
                                      "Bank-Account No: ",
                                      style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                    ),
                                  ],
                                ),

                                DropdownButton <String> (
                                    hint: const Text("Select Bank Account"),
                                    isExpanded: true,
                                    value: selectedBankAccount,
                                    items: bankAccounts.map((BankAccount bankAccount) {
                                      return DropdownMenuItem<String>(
                                        value: bankAccount.accountNumber,
                                        child: Text(bankAccount.toString(),overflow: TextOverflow.ellipsis,)
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedBankAccount = newValue;
                                      });
                                    },
                                  ),
                              ],
                            ),
                            
                            const SizedBox(height: 18),

                            Row(
                              children: [
                                const Icon(Icons.attach_money_sharp,color: Colors.black,),
                                const Text(
                                  "Amount : ",
                                  style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Text("QAR ",style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),),
                                      Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.circular(50),
                                                  ),
                                        child: Center(
                                          child: Text(amountText, style: const TextStyle(color: Colors.black, fontSize: 14,),),
                                          ),
                                      ),
                                    ],   
                                  )
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),
                            
                            widget.isAdd ? const SizedBox() : 
                            Row(
                              children: [
                                const Icon(Icons.check_circle,color: Colors.black,),
                                const Text(
                                  "Cash All:",
                                  style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                              ),
                              SizedBox(width: 10,),
                              IconButton(
                                  icon: Icon(
                                    watchChequeCheck ? Icons.check_box : Icons.check_box_outline_blank,
                                    color: watchChequeCheck ? Colors.green : Colors.grey,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      readChequeCheckNotifier.toggle();
                                      for (var cheque in cheques) {
                                        if(watchUpdatedCheques.where((element) => element.chequeNo == cheque.chequeNo && element.status == 'Deposited').isNotEmpty){
                                          readUpdatedChequesNotifier.updateChequeStatusAndCashedDate(cheque, 'Cashed', watchUpdatedCheques.firstWhere((element) => element.chequeNo == cheque.chequeNo).cashedDate, '');
                                        }
                                      }
                                    });
                                  }
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: widget.isAdd? Text(
                                    "Cheque No's: ",
                                    style: TextStyle(color: Colors.black, fontSize: 22,fontWeight: FontWeight.bold,),
                                  ) : Text(
                                    "Deposited Cheques: ",
                                    style: TextStyle(color: Colors.black, fontSize: 22,fontWeight: FontWeight.bold,),
                                  ),
                                ),
                                widget.isAdd ? IconButton(
                                  icon: const Icon(Icons.add_circle_outline,color: Colors.black,size: 30,),
                                  onPressed:() {
                                      router.go(
                                        '${AppRouter.chequeDeposit.path}${AppRouter.addChequeDeposit.path}${AppRouter.cheque.path}',
                                        extra: ChequeDepositArgs(isAdd: true),
                                      );
                                  },) : Container()
                              ],
                            ),
                            const SizedBox(height: 8),
                            widget.isAdd ? cheques.isNotEmpty  ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  cheques.length,
                                  (index){
                                    final cheque = cheques[index];
                                    return Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                                  color: Colors.blue.withOpacity(0.15),
                                                  shape: BoxShape.rectangle,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                      child: Center(
                                        child: Text(cheque.chequeNo.toString(), style: const TextStyle(color: Colors.blue,fontSize: 14, fontWeight: FontWeight.bold),),
                                        ),
                                    );
                                  }
                                ),
                              ),
                            ): Container() :
                            SingleChildScrollView(
                              scrollDirection:Axis.vertical,
                              child:
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: List.generate(
                                        cheques.length,
                                        (index) {                             
                                          return ChequeDepositCard(cheque: cheques[index]);
                                        },
                                      ),
                                  ),
                                )
                            )
                          ],
                        ),
                  ),
                const SizedBox(height: 300,),
                ],
              ),
            ),
        ),
      bottomNavigationBar: Container(
        height: 65,
        padding:EdgeInsets.only(right: 24),
        width: MediaQuery.of(context).size.width -75,
        decoration: BoxDecoration(
          color:  const Color.fromARGB(255, 234, 234, 234),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
            width: 80,
            height: 30,
            decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(50),
                      ),
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.black,
              onPressed:() {
                watchUpdatedCheques.clear();
                watchSelectedCheques.clear();

                if(watchChequeCheck){
                  readChequeCheckNotifier.toggle();
                }

                router.pop();
              },
            child: const Text("Cancel", style: TextStyle(color: Colors.white,fontSize: 16,),),
            ),
          ),
          
          const SizedBox(width: 8,),

          Container(
            width: 80,
            height: 30,
            decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(50),
                      ),
            child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.green,
                onPressed:() {
                  if(widget.isAdd){

                    if(selectedBankAccount == null || amount == null || cheques.isEmpty){
                      showNotification("Please fill all fields");
                      return;
                    }

                    int id = readChequeDepositNotifier.getlastId() + 1;

                    //update all cheques to status deposited in cheques
                    for (var cheque in cheques) {
                      cheque.status = "Deposited";
                    }

                    readChequeDepositNotifier.addChequeDeposit(
                      ChequeDeposit(
                        id,
                        DateTime.now(),
                        selectedBankAccount??'',
                        "Deposited",
                        cheques.map((e) => e.chequeNo).toList(),
                      )
                    );

                    watchSelectedCheques.clear();
                  }
                  else{

                  for(Cheque e in watchUpdatedCheques) {
                    if(e.status.toLowerCase() == 'deposited' && e.returnReason.isEmpty){
                      showNotification('Please Fill in All Missing Fields in Cheque No: ${e.chequeNo}');
                      return;
                    }
                    else if(e.status.toLowerCase() == 'deposited' && e.returnReason.isNotEmpty){
                      e.status = 'Returned';
                      
                      readChequeNotifier.updateCheque(e);
                    }
                    else{                              
                      readChequeNotifier.updateCheque(e);
                    }
                    
                  }

                  if(watchUpdatedCheques.isNotEmpty){
                    ChequeDeposit temp = watchChequeDeposit.firstWhere((e)=> e.chequeNos.contains(watchUpdatedCheques[0].chequeNo));
                    
                    int cashed = 0;
                    int returned = 0;

                    for(var i in temp.chequeNos){
                      String status = readChequeNotifier.getChequeById(i).status;

                      if(status.toLowerCase() == 'cashed'){
                        cashed+=1;
                      }
                      else{
                        returned +=1;
                      }
                    }

                    if(cashed > 0 && returned == 0){
                      temp.status = 'Cashed';
                      readChequeDepositNotifier.updateChequeDeposit(temp);
                    }
                    else if(cashed > 0 && returned > 0){
                      temp.status = 'Cashed with Returns';
                      readChequeDepositNotifier.updateChequeDeposit(temp);
                    }
                    else if(cashed == 0 && returned > 0) {
                      temp.status = 'Returned';
                      readChequeDepositNotifier.updateChequeDeposit(temp);
                    }
                  }
                  
                  watchChequeCheck ? readChequeCheckNotifier.toggle() : null;

                  watchUpdatedCheques.clear();
                  }
                  watchSelectedCheques.clear();
                  router.pop();
                },
              child: const Text("Submit", style: TextStyle(color: Colors.white,fontSize: 16,),),
              ),
            ),
          ],
        )
      ),
    );
  }
}