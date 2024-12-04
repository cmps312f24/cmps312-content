// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/data_classes/payment_args.dart';
import 'package:yalapay/models/cheque.dart';
import 'package:yalapay/models/cheque_deposit.dart';
import 'package:yalapay/models/invoice.dart';
import 'package:yalapay/models/payment.dart';
import 'package:yalapay/providers/cheque_deposit_provider.dart';
import 'package:yalapay/providers/cheque_provider.dart';
import 'package:yalapay/providers/invoice_provider.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/providers/payment_provider.dart';
import 'package:yalapay/routes/app_router.dart';
// TODO UNCOMMENT ON PHASE 2
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io' show Platform;

class AddPaymentScreen extends ConsumerStatefulWidget {
  final bool isAdd;
  final Payment? payment;
  final bool isInvoice;
  final int? invoiceNo;
  const AddPaymentScreen({super.key, required this.isAdd, this.payment, required this.isInvoice, this.invoiceNo});

  @override
  ConsumerState<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends ConsumerState<AddPaymentScreen>{
  bool update = false;
  late int selectedOption=0;

  TextEditingController amountController = TextEditingController();
  TextEditingController chequeController = TextEditingController();
  
  DateTime date=DateTime.now();
  DateTime dueDate=DateTime.now();
  double? amount;
  int? chequeNo;
  

  double amountDue = 0;

  String? selectedDrawer;
  String? selectedBank;
  String? selectedCheque;

  List<Invoice> invoices = [];

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    chequeController.dispose();
  }

  @override
  void initState() {
    super.initState();
    final chequeImages = ref.read(chequeProviderNotifier.notifier).chequeImages;
    final readChequeNotifier = ref.read(chequeProviderNotifier.notifier);

    if(!widget.isAdd){
      if(widget.payment?.paymentMode.toLowerCase() == 'Card'.toLowerCase()) {
      selectedOption = 0;
      }
      else if(widget.payment?.paymentMode.toLowerCase() == 'Bank Transfer'.toLowerCase()) {
        selectedOption = 1;
      }
      else if(widget.payment?.paymentMode.toLowerCase() == 'Cheque'.toLowerCase()) {
        selectedOption = 2;
      }

      amount = widget.payment?.amount;
      amountController.text = amount.toString();

      chequeNo = widget.payment?.chequeNo ?? -1;
      
      if(chequeNo! > 0 && !update && widget.payment?.paymentMode == 'Cheque') {
        selectedDrawer = widget.payment?.invoiceNo.toString();
        chequeController.text = chequeNo.toString();

        Cheque? tempCheque = readChequeNotifier.getChequeById(chequeNo ?? 0);

        for(var chequeImage in chequeImages) {
          if(chequeImage.image == tempCheque.chequeImageUri) {
            selectedCheque = chequeImage.image;
          }
        }

        date = tempCheque.receivedDate;
        dueDate = tempCheque.dueDate;
        selectedBank = tempCheque.bankName;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool logged = await ref.read(loginProviderNotifier.notifier).isLoggedIn();

      if(!logged){
        GoRouter.of(context).go(AppRouter.error.path);
      }
    });
  }

  // TODO: On Phase 2 upload image to firebase storage
  // Future<void> pickImage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //   );

  //   if(result != null) {
  //     if(kIsWeb){
  //       imageBytes = result.files.single.bytes;
  //       imagePath = null;
  //     }
  //     else if(Platform.isAndroid || Platform.isIOS) {
  //       imagePath = result.files.single.path;
  //       imageBytes = null;
  //     }
  //     else {
  //       imagePath = result.files.single.path;
  //       imageBytes = null;
  //       print('error');
  //     }
  //     setState(() {});
  //   } else {
  //     print('Cancelled');
  //   }
  // }

  // String? imagePath;
  // Uint8List? imageBytes;

  

  @override
  Widget build(BuildContext context) {
    final readPaymentNotifier = ref.read(paymentProviderNotifier.notifier);
    final watchPayment = ref.watch(paymentProviderNotifier);
    final readInvoiceNotifier = ref.read(invoiceProviderNotifier.notifier);
    final watchInvoice = ref.watch(invoiceProviderNotifier);
    final readChequeDepositNotifier = ref.read(chequeDepositProviderNotifier.notifier);
    final watchChequeDeposit = ref.watch(chequeDepositProviderNotifier);
    final readChequeNotifier = ref.read(chequeProviderNotifier.notifier);


    final banks = ref.read(paymentProviderNotifier.notifier).getBanks();
    final chequeImages = ref.read(chequeProviderNotifier.notifier).chequeImages;
    final router = GoRouter.of(context);
    
    invoices.clear();

    // ADDS THE INVOICE TO THE LIST OF INVOICES
    if(widget.isInvoice){
      invoices = [readInvoiceNotifier.getInvoiceById(widget.invoiceNo!)];
    }
    else{
      for(var i in watchInvoice){
        double temp = i.amount;

        for(var p in watchPayment){
          if(p.invoiceNo == i.id){
            if(p.chequeNo > 0){
              Cheque tempCheque = readChequeNotifier.getChequeById(p.chequeNo);
              if(tempCheque.status != 'Returned'){
                temp -= p.amount;
              }
            }
            else{
              temp -= p.amount;
            }
          }
        }

        if(temp >= 0){
          invoices.add(i);
        }
      }
    }

    if(!widget.isAdd) {
      selectedDrawer = widget.payment?.invoiceNo.toString();
    }

    void showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
    }

    // MANAGES THE AMOUNT DUE ON PAYMENT SCREEN ON INVOICE PATH
    if(widget.isInvoice){
      amountDue = readInvoiceNotifier.getInvoiceById(widget.invoiceNo!).amount;

      for(var p in watchPayment){
        if(p.invoiceNo == widget.invoiceNo){
          if(p.chequeNo > 0){
            Cheque temp = readChequeNotifier.getChequeById(p.chequeNo);
            
            if(temp.status != 'Returned'){
              amountDue -= p.amount;
            }

          }
          else{
            amountDue -= p.amount;
          }
        }
      }
    } 
    
    // MANAGES THE AMOUNT DUE ON PAYMENT SCREEN ON PAYMENT PATH
    if(selectedDrawer != null){
      amountDue = readInvoiceNotifier.getInvoiceById(int.parse(selectedDrawer!)).amount;

      for(var p in watchPayment){
        if(p.invoiceNo == int.parse(selectedDrawer!)){
          if(p.chequeNo > 0){
            Cheque temp = readChequeNotifier.getChequeById(p.chequeNo);
            
            if(temp.status != 'Returned'){
              amountDue -= p.amount;
            }

          }
          else{
            amountDue -= p.amount;
          }
        }
      }
    }
    
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child:
          Center(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Container(
                  height: 800,
                  width: MediaQuery.of(context).size.width -75,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(221, 255, 255, 255),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
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
                          widget.isAdd ? const Text(
                            "Add Payments.",
                            style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold,),
                          ) :
                          const Text(
                            "Update Payments.",
                            style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold,),
                          ),
                          const SizedBox(height: 18,),
                          const SizedBox(height: 18,),
                          Row(
                            children: [
                              const Icon(Icons.attach_money_sharp,color: Colors.black,),
                              const Text(
                                "Amount : ",
                                style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: amountController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter> [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                                  ],
                                  decoration: const InputDecoration(
                                    hintText: 'Amount',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: UnderlineInputBorder(),
                                  ),
                                  onChanged:(text) {
                                    amount = double.tryParse(text);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.bookmark_outline_rounded,color: Colors.black,),
                              const Text(
                                "Drawer : ",
                                style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                              ),
                            ],
                          ),
                          invoices.isNotEmpty ? DropdownButton <String> (
                                    hint: const Text('Select an Invoice'),
                                    isExpanded: true,
                                    value: selectedDrawer,
                                    items: invoices.map((e) => DropdownMenuItem(
                                      value: e.id.toString(),
                                      child: Text('Invoice #${e.id}, ${e.customerName}', overflow: TextOverflow.fade,),
                                    )).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedDrawer = value;
                                      });
                                    },
                                  ) : Container(),
                          selectedDrawer != null? Row(children: [
                            SizedBox(width: 80,),
                            Text('Amount Due: $amountDue', style: const TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),),
                          ],): Container(),
                          const SizedBox(height: 30),
                          
                          const Text("Payment Methods", style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: const Text("Card"),
                                leading: Radio(
                                  groupValue: selectedOption,
                                  focusColor: Colors.black,
                                  value: 0,
                                    onChanged:(value) => setState(() {
                                      selectedOption=0;
                                    }),
                                    ),
                              ),
                              ListTile(
                                title: const Text("Bank Transfer"),
                                leading: Radio(
                                  groupValue: selectedOption,
                                  value: 1,
                                    onChanged:(value) => setState(() {
                                      selectedOption=1;
                                    }),
                                    ),
                              ),
                              ListTile(
                                title: const Text("Cheque"),
                                leading: Radio(
                                  groupValue: selectedOption,
                                  value: 2,
                                    onChanged:(value) { setState(() {
                                      selectedOption=2;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          
                          if(selectedOption==2) ...[
                          Row(
                            children: [
                              const Icon(Icons.home_outlined,color: Colors.black,),
                              const Text(
                                "Drawer Bank : ",
                                style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                              ),
                            ],
                          ),
                          DropdownButton <String> (
                                hint: const Text('Select a Drawer Bank'),
                                isExpanded: true,
                                value: selectedBank,
                                items: banks.map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                )).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedBank = value;
                                  });
                                },
                              ),
                          Row(
                            children: [
                              const Icon(Icons.onetwothree, color: Colors.black,),
                              const Text(
                                "Cheque No : ",
                                style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: chequeController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'ID of Cheque',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: UnderlineInputBorder(),
                                  ),
                                  onChanged:(text) {
                                    chequeNo = int.tryParse(text);
                                  },
                                )
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              const Icon(Icons.image_outlined, color: Colors.black,),
                              const Text(
                                "Cheque Image : ",
                                style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                              ),

                              //TODO: On Phase 2 upload image to firebase storage
                              // Expanded(
                              //   child: GestureDetector(
                              //     onTap: pickImage,
                              //     child: Container(
                              //       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                              //       decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         borderRadius: BorderRadius.circular(4),
                              //       ),
                              //       child: Text(
                              //         imagePath ?? 'Select an image',
                              //         style: TextStyle(
                              //           color: imagePath != null ? Colors.black : Colors.grey,
                              //         ),
                              //         overflow: TextOverflow.ellipsis,
                              //       ),
                              //     )
                              //   ),
                              // ),
                              // IconButton(
                              //   icon: const Icon(Icons.camera_alt_outlined),
                              //   onPressed: pickImage,
                              // ),

                              //A DIFFERENT APPROACH
                            ],
                          ),
                          DropdownButton <String> (
                                hint: const Text('Select a cheque'),
                                isExpanded: true,
                                value: selectedCheque,
                                items: chequeImages.map((e) => DropdownMenuItem(
                                  value: e.image.toString(),
                                  child: Row(
                                    children: [
                                      Text(' cheque${(e.id-100)+1}.jpg |'),
                                      const SizedBox(width: 10,),
                                      Image.asset(
                                          'assets/cheques/${e.image}',
                                          width: 100,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                    ],
                                    ),
                                )).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCheque = value;
                                  });
                                },
                              ),

                          Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,                                
                                children: [
                                  Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                  "Date : ",
                                                  style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.calendar_month_rounded),
                                                  onPressed: () {
                                                      showDatePicker(
                                                      context: context,
                                                      initialDate: date,
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime.now(),
                                                      currentDate: DateTime.now(),
                                                      ).then((value) =>setState(() {
                                                        if(value != null){
                                                          date = value;
                                                        }
                                                        }  
                                                      ),
                                                    );
                                                },
                                              ),
                                            ],
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: Colors.white,
                                            ),

                                            child: GestureDetector(
                                              onTap: (){
                                                showDatePicker(
                                                  context: context,
                                                  initialDate: date,
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime.now(),
                                                  currentDate: DateTime.now(),
                                                  ).then((value) =>setState(() {
                                                    if(value != null){
                                                      date = value;
                                                    }
                                                    }  
                                                  ),
                                                );
                                              },
                                              child: Text("${date.day.toString()}/${date.month.toString()}/${date.year.toString()}"),
                                            ) 
                                          ),
                                        ],
                                      ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                                "Due Date : ",
                                                style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.calendar_month_rounded),
                                                onPressed:() {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: dueDate,
                                                    firstDate: date,
                                                    lastDate: DateTime(2300),
                                                    currentDate: DateTime.now(),
                                                    ).then((value) =>setState(() {
                                                      if(value != null){
                                                        dueDate = value;
                                                      }
                                                    }
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: Colors.white,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDatePicker(
                                                context: context,
                                                initialDate: dueDate,
                                                firstDate: date,
                                                lastDate: DateTime(2300),
                                                currentDate: DateTime.now(),
                                                ).then((value) =>setState(() {
                                                  if(value != null){
                                                    dueDate = value;
                                                  }
                                                }
                                              ),
                                            );
                                            },
                                            child: Text("${dueDate.day.toString()}/${dueDate.month.toString()}/${dueDate.year.toString()}"),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                          ],
                          
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
              color: const Color.fromARGB(221, 255, 255, 255),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
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

                    if(!widget.isInvoice){
                      router.go('${AppRouter.payments.path}', extra: PaymentArgs(isAdd: false, payment: widget.payment, invoiceId: widget.invoiceNo!, isInvoice: widget.isInvoice, invoiceNo: widget.invoiceNo));
                    }
                    else{
                      router.pop();
                    }
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
                    String type = '';

                    if(selectedOption == 0) {
                      type = 'Card';
                    }
                    else if(selectedOption == 1) {
                      type = 'Bank Transfer';
                    }
                    else if(selectedOption == 2) {
                      type = 'Cheque';
                    }

                  if(widget.isAdd) {
                    if(amount == null || selectedDrawer == null) {
                        showNotification('Please Fill In All The Fields');
                        return;
                    }

                    if(amount! > amountDue) {
                      showNotification('Amount Exceeds Amount Due');
                      return;
                    }

                    var invoice = readInvoiceNotifier.getInvoiceById(int.parse(selectedDrawer ?? "0"));

                    int id = readPaymentNotifier.getlastId() + 1;
                    
                    if(type.toLowerCase() == 'cheque') {
                      if(selectedBank == null || chequeNo ==null) {
                        showNotification('Please Fill In All The Fields');
                        return;
                      }
                    
                      readChequeNotifier.addCheque(
                          Cheque(
                            chequeNo ?? 0,
                            amount ?? 0,
                            invoice.customerName,
                            selectedBank ?? "0",
                            "Awaiting",
                            date,
                            dueDate,
                            selectedCheque ?? "0",
                            '',
                            DateTime.now()
                          )
                        );
                        
                      readPaymentNotifier.addPayment(
                        Payment(
                          id,
                          int.parse(selectedDrawer ?? "0"),
                          amount ?? 0,
                          DateTime.now(),
                          type,
                          chequeNo ?? 0,
                        )
                      );
                    }
                    else{
                      readPaymentNotifier.addPayment(
                      Payment(
                        id,
                        int.parse(selectedDrawer ?? "0"),
                        amount ?? 0,
                        DateTime.now(),
                        type,
                        chequeNo ?? 0,
                      )
                      );
                    }
    
                  }
                  else{ // Widget is not add
                    if(amount == null || selectedDrawer == null) {
                        showNotification('Please Fill In All The Fields');
                        return;
                    }

                    if(amount! > amountDue + widget.payment!.amount) {
                      showNotification('Amount Exceeds Amount Due');
                      return;
                    }

                    update = true;
                    if(widget.payment?.paymentMode.toLowerCase() == 'cheque' && type.toLowerCase() != 'cheque') {
                      readChequeNotifier.deleteCheque(readChequeNotifier.getChequeById(widget.payment!.chequeNo));
                      readChequeDepositNotifier.updateChequeDepositOnChequeDelete(widget.payment!.chequeNo);
                    }

                    if(type.toLowerCase() == 'Cheque'.toLowerCase()) {
                      if(selectedBank == null || chequeNo ==null) {
                        showNotification('Please Fill In All The Fields');
                        return;
                      }

                      String stat = '';

                      if(widget.payment!.paymentMode.toLowerCase() == 'cheque'){
                         stat = readChequeNotifier.getChequeById(widget.payment!.chequeNo).status;
                      }
                      
                      var invoice = readInvoiceNotifier.getInvoiceById(int.parse(selectedDrawer ?? "0"));

                      if(chequeNo != widget.payment?.chequeNo && widget.payment!.paymentMode.toLowerCase() == 'cheque') {
                        print('first condition');
                        readChequeNotifier.addCheque(
                          Cheque(
                            chequeNo ?? 0,
                            amount ?? 0,
                            invoice.customerName,
                            selectedBank ?? "0",
                            stat,
                            date,
                            dueDate,
                            selectedCheque ?? "0",
                            '',
                            DateTime.now()
                          )
                        );

                        readChequeNotifier.deleteCheque(readChequeNotifier.getChequeById(widget.payment!.chequeNo));
                       
                       

                        readPaymentNotifier.updatePayment(
                          Payment(
                            widget.payment!.id,
                            int.parse(selectedDrawer ?? "0"),
                            amount ?? 0,
                            DateTime.now(),
                            type,
                            chequeNo ?? 0,
                          )
                        );

                        for (var i in watchChequeDeposit){
                          if(i.chequeNos.contains(widget.payment!.chequeNo)){
                            readChequeDepositNotifier.updateChequeDeposit(
                              ChequeDeposit(
                                i.id,
                                i.depositDate,
                                i.bankAccountNo,
                                i.status,
                                i.chequeNos.map((e) => e == widget.payment!.chequeNo ? chequeNo ?? 0 : e).toList()
                              )
                            );
                          }
                        }
                      }
                      else{
                        if(widget.payment!.paymentMode.toLowerCase() == 'cheque'){
                          print('second condition');
                            readChequeNotifier.updateCheque(
                            Cheque(
                              chequeNo ?? 0,
                              amount ?? 0,
                              invoice.customerName,
                              selectedBank ?? "0",
                              stat,
                              date,
                              dueDate,
                              selectedCheque ?? "0",
                              '',
                              DateTime.now()
                            )
                          );
                        }
                        else{
                          print('third condition');
                          readChequeNotifier.addCheque(
                          Cheque(
                              chequeNo ?? 0,
                              amount ?? 0,
                              invoice.customerName,
                              selectedBank ?? "0",
                              "Awaiting",
                              date,
                              dueDate,
                              selectedCheque ?? "0",
                              '',
                              DateTime.now()
                            )
                          );
                        }
                        
                      }
                    }
                    
                    if(widget.payment!.paymentMode.toLowerCase() == 'cheque' && type.toLowerCase() == 'cheque'){
                      readPaymentNotifier.updatePayment(
                        Payment(
                          widget.payment!.id,
                          int.parse(selectedDrawer ?? "0"),
                          amount ?? 0,
                          DateTime.now(),
                          type,
                          chequeNo ?? 0,
                        )
                      );
                    }
                  else if(type.toLowerCase() == 'cheque' && widget.payment!.paymentMode.toLowerCase() != 'cheque') {
                    readPaymentNotifier.updatePayment(
                        Payment(
                          widget.payment!.id,
                          int.parse(selectedDrawer ?? "0"),
                          amount ?? 0,
                          DateTime.now(),
                          type,
                          chequeNo ?? 0,
                        )
                      );
                    }
                    else{
                      readPaymentNotifier.updatePayment(
                          Payment(
                            widget.payment!.id,
                            int.parse(selectedDrawer ?? "0"),
                            amount ?? 0,
                            DateTime.now(),
                            type,
                            0,
                          )
                        );
                      }
                  }

                  selectedDrawer = null;

                  if(!widget.isInvoice){
                    router.go('${AppRouter.payments.path}', extra: PaymentArgs(isAdd: false, payment: widget.payment, invoiceId: widget.invoiceNo!, isInvoice: widget.isInvoice, invoiceNo: widget.invoiceNo));
                  }
                  else{
                    router.pop();
                  }
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