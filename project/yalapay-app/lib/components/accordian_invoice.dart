import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/data_classes/invoice_args.dart';
import 'package:yalapay/data_classes/payment_args.dart';
import 'package:yalapay/models/cheque.dart';
import 'package:yalapay/models/invoice.dart';
import 'package:yalapay/models/simpleDate.dart';
import 'package:yalapay/providers/cheque_deposit_provider.dart';
import 'package:yalapay/providers/cheque_provider.dart';
import 'package:yalapay/providers/customer_provider.dart';
import 'package:yalapay/providers/invoice_provider.dart';
import 'package:yalapay/providers/payment_provider.dart';
import 'package:yalapay/routes/app_router.dart';

class AccordianInvoice extends ConsumerStatefulWidget {
  final Invoice invoice;
  const AccordianInvoice({super.key, required this.invoice});

  @override
  ConsumerState<AccordianInvoice> createState() => _AccordianInvoiceState();
}

class _AccordianInvoiceState extends ConsumerState<AccordianInvoice> {
  bool isIconUp = false;
  double amountDue = 0.0;
  bool containsAwaitingPayments = false;

  void setIsIconUp(bool value) {
    setState(() {
      isIconUp = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final readChequeNotifier = ref.read(chequeProviderNotifier.notifier);
    final readCustomerNotifier = ref.read(customerProviderNotifier.notifier);
    final watchPayment = ref.watch(paymentProviderNotifier);
    final readPaymentNotifier = ref.read(paymentProviderNotifier.notifier);
    final readInvoiceNotifier = ref.read(invoiceProviderNotifier.notifier);
    final readChequeDepositNotifier = ref.read(chequeDepositProviderNotifier.notifier);

    final router = GoRouter.of(context);

    amountDue = widget.invoice.amount;
    containsAwaitingPayments = false;

    for(var p in watchPayment){
      if(p.invoiceNo == widget.invoice.id){
        if(p.chequeNo > 0){
          Cheque temp = readChequeNotifier.getChequeById(p.chequeNo);
          
          if(temp.status != 'Returned'){
            amountDue -= p.amount;
          }
          if(temp.status == 'Awaiting' || temp.status == 'Deposited'){
            containsAwaitingPayments = true;
          }

        }
        else{
          amountDue -= p.amount;
        }
      }
    }
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
                Flexible(
                  flex:1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: amountDue > 0
                          ? Colors.red.withOpacity(0.15)
                          : containsAwaitingPayments
                              ? Colors.amber.withOpacity(0.15)
                              : Colors.green.withOpacity(0.15), 
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      amountDue > 0
                          ? 'Due: QR ${amountDue.toString()}.'
                          : containsAwaitingPayments
                              ? 'Awaiting Payments.'
                              : 'Fully Paid.',
                      style: TextStyle(
                        color: amountDue > 0
                            ? Colors.red
                            : containsAwaitingPayments
                                ? Colors.amber.shade600
                                : Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),
                    ),
                  ),
                ),
                
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(readCustomerNotifier.getCustomerById(widget.invoice.customerId)?.name ?? 'error', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
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
                    const Text('Invoice Details:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
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
                                    Text('Amount: ',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,),
                                    ),
                                    SizedBox(width: 4), 
                                    Icon(Icons.attach_money, size: 12),
                                   
                                  ],
                                ),
                                Text(
                                  'QR ${widget.invoice.amount.toString()}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 8.0), 
                                const Row(
                                  children: [
                                    Text('Due Date: ',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,),
                                    ),
                                    SizedBox(width: 4), 
                                    Icon(Icons.date_range, size: 12),
                                  ],
                                ),
                                Text(
                                  SimpleDate(widget.invoice.dueDate.year, widget.invoice.dueDate.month, widget.invoice.dueDate.day).toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
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
                                    'Date: ',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,),
                                  ),
                                  SizedBox(height: 0, width: 10,),
                                  Icon(Icons.date_range, size: 12), 
                                ],
                              ),

                              Text(
                                SimpleDate(widget.invoice.invoiceDate.year, widget.invoice.invoiceDate.month, widget.invoice.invoiceDate.day).toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 8.0), 
                              
                              SizedBox(
                                width: 140,
                                height: 30,
                                child: ElevatedButton(                  
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ),
                                  onPressed: () {
                                    router.go(
                                      '${AppRouter.invoice.path}${AppRouter.paymentsFromInvoice.path}',
                                      extra: PaymentArgs(isAdd: false, invoiceId: widget.invoice.id, isInvoice: true, invoiceNo: widget.invoice.id),
                                    );
                                  },
                                  child: const Text(
                                      'Payment Details',
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Text('Customer Details:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),

                  Padding(
                    padding: const EdgeInsets.all(2.0),
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
                                    Text('ID: ',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,),
                                    ),
                                    SizedBox(width: 4), 
                                    Icon(Icons.account_box_outlined, size: 12),
                                  ],
                                ),
                                Text(
                                  widget.invoice.customerId.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Row(
                                  children: [
                                    Text('Mobile: ',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(Icons.phone_android, size: 12),
                                  ],
                                ),
                                Text(
                                  readCustomerNotifier.getCustomerById(widget.invoice.customerId)?.contactDetails.mobile ?? 'error',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
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
                                    'Full name: ',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,),
                                  ),
                                  SizedBox(height: 0, width: 10,),
                                  Icon(Icons.person_outline, size: 12),
                                ],
                              ),
                              Text(
                                readCustomerNotifier.getCustomerById(widget.invoice.customerId)?.name ?? 'error',
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              const Row(
                                children: [
                                  Text(
                                    'Email: ',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,),
                                  ),
                                  SizedBox(height: 0, width: 10,),
                                  Icon(Icons.email_outlined, size: 12), 
                                ],
                              ),
                              Text(
                                readCustomerNotifier.getCustomerById(widget.invoice.customerId)?.contactDetails.email ?? 'error',
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          router.go(
                            '${AppRouter.invoice.path}${AppRouter.addInvoice.path}',
                            extra: InvoiceArgs(isAdd: false, invoice: widget.invoice),
                          );
                          
                        },
                        icon: const Icon(Icons.edit, size: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (context) {
                                return AlertDialog(
                                title: const Text('Delete Invoice', style: TextStyle(fontWeight: FontWeight.bold),),
                                content: const Text('Are you sure you want to delete this Invoice? \nThis cannot be undone. \nAll related payments and cheque deposits will be deleted / updated as well.'),
                                actions: [
                                    TextButton(
                                    onPressed: () {
                                        Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                    ),
                                    TextButton(
                                    onPressed: () {
                                        for(var p in watchPayment){
                                          if(p.invoiceNo == widget.invoice.id){
                                            if(p.paymentMode == 'Cheque'){
                                              readChequeNotifier.deleteCheque(readChequeNotifier.getChequeById(p.chequeNo));

                                              readChequeDepositNotifier.updateChequeDepositOnChequeDelete(p.chequeNo);
                                            }

                                            readPaymentNotifier.deletePayment(p);
                                          }
                                        }

                                        readInvoiceNotifier.deleteInvoice(widget.invoice);

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
                )
              ],
            ),
          ],
        ),        
      ),
    );
  }
}