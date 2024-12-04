import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalapay/models/cheque.dart';
import 'package:yalapay/models/simpleDate.dart';
import 'package:yalapay/providers/cheque_checked_provider.dart';
import 'package:yalapay/providers/updated_cheques_provider.dart';

class ChequeDepositCard extends ConsumerStatefulWidget {
  final Cheque cheque;
  const ChequeDepositCard({super.key, required this.cheque});

  @override
  ConsumerState<ChequeDepositCard> createState() => _ChequeDepositCardState();
}

class _ChequeDepositCardState extends ConsumerState<ChequeDepositCard> {
  bool isChecked = false;
  String? returnReason;
  DateTime cashedDate = DateTime.now();

  void setIsChecked(bool val){
    setState(() {
      isChecked = val;
    });
  }

  void setReturnReason(String reason){
    setState(() {
      returnReason = reason;
    });
  }

  void setCashedDate(DateTime date){
    setState(() {
      cashedDate = date;
    });
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bool checked = ref.watch(chequeCheckProviderNotifier);

      if(checked || widget.cheque.status == 'Cashed'){
        setIsChecked(true);
        setCashedDate(widget.cheque.cashedDate);
      }

      if(widget.cheque.status == 'Returned'){
        setReturnReason(widget.cheque.returnReason);
        setCashedDate(widget.cheque.cashedDate);
        setIsChecked(false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(ChequeDepositCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final watchChequeCheck = ref.watch(chequeCheckProviderNotifier);
      final readChequeCheckNotifier = ref.read(chequeCheckProviderNotifier.notifier);
      final watchUpdatedCheques = ref.watch(updatedChequesProviderNotifier);

      if(!watchChequeCheck){
        var check = watchUpdatedCheques.where((element) => element.status == 'Cashed');

        if(check.length == watchUpdatedCheques.length && check.isNotEmpty){
            readChequeCheckNotifier.toggle();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final readUpdatedChequesNotifier = ref.read(updatedChequesProviderNotifier.notifier);
    final watchUpdatedCheques = ref.watch(updatedChequesProviderNotifier);
    final readChequeCheckNotifier = ref.read(chequeCheckProviderNotifier.notifier);
    final bool checked = ref.watch(chequeCheckProviderNotifier);

    if(checked){
        setIsChecked(true);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(
        color: const Color.fromARGB(255, 234, 234, 234),
        elevation: 4,
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Column(
            children: [
              Text(
                    'Cheque #${widget.cheque.chequeNo}', 
                    style: const TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
                                        
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),                          
                child: Row(
                  children: [
                    Icon(Icons.money),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Amount: ', 
                      style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.cheque.amount.toString(), 
                      style: const TextStyle(color: Colors.black,fontSize: 16,),
                    ),
                  ],
                ),
              ),
                                        
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),                                  
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Drawer: ', 
                      style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.cheque.drawer, 
                      style: const TextStyle(color: Colors.black,fontSize: 16,),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),                                  
                child: Row(
                  children: [
                    Icon(Icons.margin),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Bank: ', 
                      style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.cheque.bankName, 
                      style: const TextStyle(color: Colors.black,fontSize: 16,),
                    ),
                  ],
                ),
              ),
                                                
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Icon(Icons.date_range_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'RecievedDate: ', 
                      style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      SimpleDate(widget.cheque.receivedDate.year, widget.cheque.receivedDate.month, widget.cheque.receivedDate.day).toString(), 
                      style: const TextStyle(color: Colors.black,fontSize: 16,),
                    ),
                  ],
                ),
              ),
                                          
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Icon(Icons.date_range_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'DueDate: ', 
                      style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      SimpleDate(widget.cheque.dueDate.year, widget.cheque.dueDate.month, widget.cheque.dueDate.day).toString(), 
                      style: const TextStyle(color: Colors.black,fontSize: 16,),
                    ),
                  ],
                ),
              ),
                                        
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
                                        
              SizedBox(height: 5,),
              
                                        
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cashed Date: ', 
                              style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: GestureDetector(
                                onTap:() {
                                  showDatePicker(
                                    context: context,
                                    initialDate: cashedDate,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    currentDate: DateTime.now(),
                                    ).then((value) =>
                                    setState(() {
                                        if(value != null){
                                          setCashedDate(value);

                                          String reason = returnReason ?? '';
                                          readUpdatedChequesNotifier.updateChequeStatusAndCashedDate(widget.cheque, isChecked ? 'Cashed':'Deposited', value, reason);
                                          
                                        }
                                      }
                                    )
                                  );
                                },
                                child: Text(
                                  '\t${SimpleDate(cashedDate.year, cashedDate.month, cashedDate.day)}\t', 
                                  style: const TextStyle(color: Colors.black,fontSize: 16, backgroundColor: Colors.white),
                                ),              
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: cashedDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                  currentDate: DateTime.now(),
                                  ).then((value) =>
                                  setState(() {
                                      if(value != null){

                                        setCashedDate(value);

                                        String reason = returnReason ?? '';
                                        readUpdatedChequesNotifier.updateChequeStatusAndCashedDate(widget.cheque, isChecked ? 'Cashed':'Deposited', value, reason);
                                        
                                      }
                                    }  
                                  ),
                                );
                              }, 
                              icon: Icon(Icons.calendar_today),
                            )
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cashed: ', 
                              style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(
                                isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                                color: isChecked ? Colors.green : Colors.grey,
                              ),
                              onPressed: (){
                                if(isChecked && checked){
                                  readChequeCheckNotifier.toggle();
                                }

                                setIsChecked(!isChecked);                                 

                                setState(() {

                                    String reason = returnReason ?? '';
                                    
                                    readUpdatedChequesNotifier.updateChequeStatusAndCashedDate(widget.cheque, isChecked ? 'Cashed':'Deposited', cashedDate, isChecked ? '' : reason);
                                  }
                                );

                                if(isChecked && !checked){
                                  var check = watchUpdatedCheques.where((element) => element.status == 'Cashed');

                                  if(check.length == watchUpdatedCheques.length){
                                    readChequeCheckNotifier.toggle();
                                  }
                                }
                              }
                            ),
                          ],
                        )
                      ],
                    ),

                    isChecked ? Container(): Column(
                      children: [
                        Text(
                          'Return Reason: ', 
                          style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),
                        ),

                        DropdownButton<String>(
                          alignment: Alignment.centerRight,
                          isExpanded: true,
                          hint: const Text("Select Reason"),
                          value: returnReason,
                          items: <String>[
                            'No funds/insufficient funds', 
                            'Effects not cleared, please represent', 
                            'Cheque post-dated, please represent on due date', 
                            'Out of date', 
                            "Drawer's signature differs ",
                            "Alteration in date/words/figures requires drawer's full signature",
                            "Order cheque requires payee's endorsement",
                            "Endorsement irregular",
                            "Not drawn on us",
                            "Drawer deceased/bankrupt",
                            "Account closed",
                            "Stopped by drawer due to cheque lost, bearer's bankruptcy or a judicial order",
                            "Mutilation requires drawer's/banker's confirmation",
                            "Date/beneficiary name is required",
                            "Presentment cycle expired ",
                            "Already paid",
                            "Requires drawer's signature ",
                            "Transaction timeout",
                            "Cheque information and electronic data mismatch",
                            ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              returnReason = value!;
                            });
                            String reason = value ?? '';

                            readUpdatedChequesNotifier.updateChequeStatusAndCashedDate(widget.cheque, isChecked ? 'Cashed':'Deposited', cashedDate, reason);
                          },
                        ),
                      ],
                    )

                  ],
                ),
              ),

              SizedBox(height: 5,),
            ],
          ),
        )
      )
  );
  }
}