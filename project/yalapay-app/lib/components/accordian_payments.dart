import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/data_classes/payment_args.dart';
import 'package:yalapay/models/payment.dart';
import 'package:yalapay/models/simpleDate.dart';
import 'package:yalapay/providers/cheque_deposit_provider.dart';
import 'package:yalapay/providers/cheque_provider.dart';
import 'package:yalapay/providers/invoice_provider.dart';
import 'package:yalapay/providers/payment_provider.dart';
import 'package:yalapay/routes/app_router.dart';

class AccordianPayment extends ConsumerStatefulWidget {
  final Payment payment;
  final bool isInvoice;
  const AccordianPayment({super.key, required this.payment, required this.isInvoice});

  @override
  ConsumerState<AccordianPayment> createState() => _AccordianPaymentState();
}

class _AccordianPaymentState extends ConsumerState<AccordianPayment> {
  bool isIconUp = false;

  void setIsIconUp(bool value) {
    setState(() {
      isIconUp = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final readInvoiceNotifier = ref.read(invoiceProviderNotifier.notifier);
    final readChequeNotifier = ref.read(chequeProviderNotifier.notifier);

    final cheque = widget.payment.paymentMode.toLowerCase() == 'cheque'.toLowerCase()
        ? readChequeNotifier.getChequeById(widget.payment.chequeNo)
        : null;
    final invoice = readInvoiceNotifier.getInvoiceById(widget.payment.invoiceNo);

    return GestureDetector(
      onTap: () {
        setState(() {
          isIconUp = !isIconUp;
        });
      },
      child: ListTile(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
    
                widget.payment.paymentMode.toLowerCase() == 'cheque'.toLowerCase()
                  ? cheque != null
                      ? Flexible(
                        flex: 3,
                        child: Container(
                            margin: EdgeInsets.only(right: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: 
                              cheque.status == 'Cashed' ? 
                              Colors.green.withOpacity(0.15) : cheque.status == 'Deposited' ? 
                              Colors.amber.withOpacity(0.15) : cheque.status == 'Returned' ? 
                              Colors.red.withOpacity(0.15) : Colors.blue.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              cheque.status,
                              style: TextStyle(
                                fontSize: 12,
                                color: 
                                cheque.status == 'Cashed' ?
                                Colors.green : 
                                cheque.status == 'Deposited' ?
                                Colors.amber.shade600 : 
                                cheque.status == 'Returned' ?
                                Colors.red : Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        )
                      : const Text('')
                  : Flexible(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text('${widget.payment.paymentMode}.', style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold, fontSize: 12,)),
                    ),
                    ),

                Flexible(
                  flex: 2,
                  child: Text(
                    'QR ${widget.payment.amount.toString()}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),

                Flexible(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          readInvoiceNotifier.getInvoiceById(widget.payment.invoiceNo).customerName,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      
                      Flexible(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isIconUp ? setIsIconUp(false) : setIsIconUp(true);
                            });
                          },
                          icon: Icon(
                            isIconUp
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            if (isIconUp)
              widget.payment.paymentMode.toLowerCase() == 'cheque'.toLowerCase() 
                ? cheque != null
                  ? buildChequeDetails(cheque, invoice)
                  : const Text('Cheque details not available.')
                : buildNonChequeDetails(),
        ],
      ),
    ),
  );
}

Widget buildChequeDetails(cheque, invoice) {
  final readChequeNotifier = ref.read(chequeProviderNotifier.notifier);
  final readInvoiceNotifier = ref.read(invoiceProviderNotifier.notifier);
  final readChequeDepositNotifier = ref.read(chequeDepositProviderNotifier.notifier);
  final readPaymentNotifier = ref.read(paymentProviderNotifier.notifier);


  final router = GoRouter.of(context);
  return Column(
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
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Amount: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        SizedBox(height: 8.0),
                        Icon(Icons.attach_money, size: 12),
                      ],
                    ),
                    Text(
                      'QR ${widget.payment.amount.toString()}',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text('Status:',
                                style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold, fontSize: 12)),
                            SizedBox(height: 8.0),
                            Icon(Icons
                                .check_circle_outline_rounded, size: 12),
                          ],
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: 
                                  cheque.status == 'Cashed' ? 
                                  Colors.green.withOpacity(0.15) :
                                  cheque.status == 'Deposited' ?
                                  Colors.amber.shade600.withOpacity(0.15) :
                                  cheque.status == 'Returned' ?
                                  Colors.red.withOpacity(0.15) : Colors.blue.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: readChequeNotifier.getChequeById(widget.payment.chequeNo).status.isNotEmpty
                                    ? Text(
                                      readChequeNotifier.getChequeById(widget.payment.chequeNo).status
                                      ,
                                      style: TextStyle(
                                      color: 
                                      readChequeNotifier.getChequeById(widget.payment.chequeNo).status == 'Cashed' ?
                                      Colors.green :
                                      readChequeNotifier.getChequeById(widget.payment.chequeNo).status == 'Deposited' ?
                                      Colors.amber.shade600 :
                                      readChequeNotifier.getChequeById(widget.payment.chequeNo).status == 'Returned' ?
                                      Colors.red : Colors.blue,
                                      fontWeight: FontWeight.bold, fontSize: 12),
                                  )
                                : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Text(
                              'Due Date: ',
                              style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, fontSize: 12),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.date_range, size: 12),
                          ],
                        ),
                        Text(
                          '${SimpleDate(cheque!.dueDate.year, cheque!.dueDate.month, cheque!.dueDate.day)}',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Text(
                              'Drawer: ',
                              style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, fontSize: 12),
                            ),
                            SizedBox(height: 0, width: 10),
                            Icon(Icons.bookmark, size: 12),
                          ],
                        ),
                        Text(readInvoiceNotifier.getInvoiceById(widget.payment.invoiceNo).customerName,
                        style: TextStyle(fontSize: 12),),
                        const SizedBox(height: 8.0),
                      ],
                    ),
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
                        'Drawer Bank: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      SizedBox(height: 0, width: 10),
                      Icon(Icons.bookmark, size: 12),
                    ],
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[900]?.withOpacity(0.15),
                            borderRadius:
                                BorderRadius.circular(5.0),
                          ),
                          child: readChequeNotifier.getChequeById(widget.payment.chequeNo).status.isNotEmpty
                              ? Text(
                                  readChequeNotifier.getChequeById(widget.payment.chequeNo).bankName,
                                  style: TextStyle(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                                  ),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Row(
                    children: [
                      Text(
                        'Received Date: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      SizedBox(height: 0, width: 10),
                      Icon(Icons.date_range, size: 12),
                    ],
                  ),
                  Text(
                    SimpleDate(
                            cheque!.receivedDate.year,
                            cheque!.receivedDate.month,
                            cheque!.receivedDate.day)
                        .toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 25),
                  const Row(
                    children: [
                      Text(
                        'Cheque Image: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      SizedBox(height: 0, width: 10),
                      Icon(Icons.image_outlined, size: 12),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        width: 100,
                        child: Image.asset(
                          'assets/cheques/${cheque!.chequeImageUri}',
                          fit: BoxFit.cover,
                        ),
                      )),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                if(!widget.isInvoice){
                  router.go('${AppRouter.payments.path}${AppRouter.addPayment.path}', extra: PaymentArgs(isAdd: false, payment: widget.payment, invoiceId: widget.payment.invoiceNo, isInvoice: widget.isInvoice, invoiceNo: widget.payment.invoiceNo));
                }
                else{
                  router.go('${AppRouter.invoice.path}${AppRouter.paymentsFromInvoice.path}${AppRouter.addPaymentFromInvoice.path}', extra: PaymentArgs(isAdd: true, isInvoice: widget.isInvoice, invoiceNo: widget.payment.invoiceNo, invoiceId: widget.payment.invoiceNo));
                }
                
              },
              icon: const Icon(Icons.edit, size: 16),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context) {
                      return AlertDialog(
                      title: const Text('Delete Payment', style: TextStyle(fontWeight: FontWeight.bold),),
                      content: const Text('Are you sure you want to delete this Payment? \nThis cannot be undone. \nAll related cheques and cheque deposits will be deleted / updated as well.'),
                      actions: [
                          TextButton(
                          onPressed: () {
                              Navigator.of(context).pop();
                          },
                          child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                          TextButton(
                          onPressed: () {
                              if(widget.payment.paymentMode.toLowerCase() == 'cheque'.toLowerCase()) {
                                  readChequeNotifier.deleteCheque(readChequeNotifier.getChequeById(widget.payment.chequeNo));

                                  readChequeDepositNotifier.updateChequeDepositOnChequeDelete(widget.payment.chequeNo);
                              }

                              readPaymentNotifier.deletePayment(widget.payment);

                              Navigator.of(context).pop();
                          },
                          child: const Text('Delete', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                          ),
                      ],
                      );
                  }
              );
                
              },
              icon: const Icon(Icons.delete_outline, size: 16),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildNonChequeDetails() { 
  final readPaymentNotifier = ref.read(paymentProviderNotifier.notifier);

  final router = GoRouter.of(context); 
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Details:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Amount: ',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(height: 8.0),
                Icon(Icons.attach_money, size: 12),
              ],
            ),
            Text(
              'QR ${widget.payment.amount.toString()}',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Date: ',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(height: 8.0),
                Icon(Icons.date_range, size: 12),
              ],
            ),
            Text(
              '${SimpleDate(widget.payment.paymentDate.year, widget.payment.paymentDate.month, widget.payment.paymentDate.day)}',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Payment Mode: ',
                  style:
                      TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              widget.payment.paymentMode,
            ),
            const SizedBox(height: 8.0),
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                   router.go('${AppRouter.payments.path}${AppRouter.addPayment.path}', extra: PaymentArgs(isAdd: false, payment: widget.payment, invoiceId: widget.payment.invoiceNo, isInvoice: widget.isInvoice, invoiceNo: widget.payment.invoiceNo));
                  },
                  icon: const Icon(Icons.edit, size: 16),
                ),
                IconButton(
                  onPressed: () {
                      readPaymentNotifier.deletePayment(widget.payment);
                  },
                  icon: const Icon(Icons.delete_outline, size: 16),
                ),
              ],
            ),
          ),
          ],
          
        ),
      ],
    );
  }
}    
            
