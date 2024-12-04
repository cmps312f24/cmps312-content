import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalapay/models/cheque.dart';
import 'package:yalapay/models/simpleDate.dart';
import 'package:yalapay/providers/cheque_provider.dart';
import 'package:yalapay/providers/selected_cheques_provider.dart';

class AccordianCheques extends ConsumerStatefulWidget {
  final Cheque cheque;
  final bool isAdd;
  const AccordianCheques(this.isAdd, {super.key, required this.cheque,});

  @override
  ConsumerState<AccordianCheques> createState() => _AccordianChequesState();
}

class _AccordianChequesState extends ConsumerState<AccordianCheques> {
  bool isIconUp = false;
  bool isOverDue = false;
  bool isChecked = false;

  void setIsIconUp(bool value) {
    setState(() {
      isIconUp = value;
    }
    );
  }

  void overDue(){

    if(widget.cheque.receivedDate.difference(widget.cheque.dueDate).inDays < 0) {
        setState(() {
          isOverDue = true;
        }
      );
    }
    else {
      setState(() {
        isOverDue = false;
      } 
      );
    }
  }

  void toggleCheck() {
    setState(() {
      isChecked = !isChecked;
  }
    );
  }
  @override
    void initState() {
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    overDue();
    final watchSelectedChequeProvider = ref.watch(selectedChequeProviderNotifier);
    final readChequeNotifier = ref.read(chequeProviderNotifier.notifier);

    for (var cheque in watchSelectedChequeProvider) {
      if (cheque.chequeNo == widget.cheque.chequeNo) {
        isChecked = true;
      }
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          isIconUp = !isIconUp;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                        widget.isAdd? IconButton(
                          icon: Icon(
                            isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                            color: isChecked ? Colors.green : Colors.grey,
                          ),
                          onPressed: (){
                            toggleCheck();
                            if(!isChecked){
                              watchSelectedChequeProvider.remove(widget.cheque);
                            }
                            else{
                              watchSelectedChequeProvider.add(widget.cheque);
                            }
                            
                          },
                        ): Container(),
                      Text(
                        widget.cheque.chequeNo.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: Text('QR ${widget.cheque.amount}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),

                  isOverDue ? Flexible(
                    flex: 3,
                    child: 
                     Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Text(
                        'Overdue',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ) ,
                  ): Container(),
    
                   Flexible(
                    flex: 3,
                     child: Row(  
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color:
                          readChequeNotifier.getChequeById(widget.cheque.chequeNo).status == 'Cashed' ? 
                          Colors.green.withOpacity(0.15) :
                          readChequeNotifier.getChequeById(widget.cheque.chequeNo).status == 'Deposited' ?
                          Colors.amber.shade600.withOpacity(0.15) :
                          readChequeNotifier.getChequeById(widget.cheque.chequeNo).status == 'Returned' ?
                          Colors.red.withOpacity(0.15) : Colors.blue.withOpacity(0.15)
                          ,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          widget.cheque.status,
                          style: TextStyle(
                            color: 
                            readChequeNotifier.getChequeById(widget.cheque.chequeNo).status == 'Cashed' ? 
                            Colors.green :
                            readChequeNotifier.getChequeById(widget.cheque.chequeNo).status == 'Deposited' ?
                            Colors.amber.shade600 :
                            readChequeNotifier.getChequeById(widget.cheque.chequeNo).status == 'Returned' ?
                            Colors.red : Colors.blue,
                            fontWeight: FontWeight.bold, fontSize: 12
                          ),
                        ),
                      ),
                      
                      Icon(
                      isIconUp
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                        ),
                      ],
                    ),
                   ),
                ],
              ),

              if (isIconUp)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Details:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        'Received Date: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 12),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(Icons.date_range, size: 12),
                                    ],
                                  ),
                                  Text(
                                    SimpleDate(
                                            widget.cheque.receivedDate.year,
                                            widget.cheque.receivedDate.month,
                                            widget.cheque.receivedDate.day)
                                        .toString(),
                                    style: TextStyle(fontSize: 12)
                                  ),
                                  const SizedBox(height: 20),
                                  const Row(
                                    children: [
                                      Text(
                                        'Amount: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 12),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(Icons.attach_money, size: 12),
                                    ],
                                  ),
                                  Text('QR ${widget.cheque.amount}',style: TextStyle(fontSize: 12)),
                                  const SizedBox(height: 20),
                                  const Row(
                                    children: [
                                      Text(
                                        'Bank Name: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 12),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(Icons.business, size: 12),
                                    ],
                                  ),
                                  Text(widget.cheque.bankName,style: TextStyle(fontSize: 12)),
                                  const SizedBox(height: 30),
                                  widget.cheque.status == 'Returned' ? Row(
                                    children: [
                                      Text(
                                        'Return Date: ',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(Icons.date_range, size: 12),
                                    ],
                                  ) : Container(),
                                  const Text(''),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      'Due Date: ',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.date_range, size: 12),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: '${SimpleDate(widget.cheque.dueDate.year, widget.cheque.dueDate.month, widget.cheque.dueDate.day)}',
                                    style: const TextStyle(color: Colors.black, fontSize: 12),
                                    children: [
                                      TextSpan(
                                        text: '  (${widget.cheque.dueDate.difference(DateTime.now()).inDays})',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: widget.cheque.dueDate.difference(DateTime.now()).inDays >= 0
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ], 
                                  )
                                ),
                                const SizedBox(height: 15.0),
                                const Row(
                                  children: [
                                    Text(
                                      'Drawer: ',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.bookmark, size: 12),
                                  ],
                                ),
                                Text(widget.cheque.drawer,style: TextStyle(fontSize: 12),),
                                const SizedBox(height: 15.0),
                                const Row(
                                  children: [
                                    Text(
                                      'Cheque Image: ',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.image_outlined, size: 12),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: Image.asset(
                                      'assets/cheques/cheque1.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                widget.cheque.status == 'Returned' ? Row(
                                  children: [
                                    Text(
                                      'Return Reason: ',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.restart_alt_outlined, size: 12),
                                  ],
                                ) : Container(),
                                 widget.cheque.status == 'Returned' ? const Text('empty') : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
