import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/models/invoice.dart';
import 'package:yalapay/providers/customer_provider.dart';
import 'package:yalapay/providers/invoice_provider.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/routes/app_router.dart';

class AddInvoiceScreen extends ConsumerStatefulWidget {
  final bool isAdd;
  final Invoice? invoice;
  const AddInvoiceScreen({super.key, required this.isAdd, this.invoice});

  @override
  ConsumerState<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends ConsumerState<AddInvoiceScreen>{
  int? customerID;
  String? customerName;
  double? amount;
  DateTime date = DateTime.now();
  DateTime dueDate = DateTime.now();


  final TextEditingController customerIDController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String? selectedCustomer;

  @override
  void initState() {
    super.initState();
    if(!widget.isAdd){
        updateFields();
    }
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool logged = await ref.read(loginProviderNotifier.notifier).isLoggedIn();

      if(!logged){
        GoRouter.of(context).go(AppRouter.error.path);
      }
    });
  }

  @override
  void dispose() {
    customerIDController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  void updateFields() {
    customerIDController.text = widget.invoice!.customerId.toString();
    amountController.text = widget.invoice!.amount.toString();
    date = widget.invoice!.invoiceDate;
    dueDate = widget.invoice!.dueDate;

    customerID = widget.invoice!.customerId;
    customerName = widget.invoice!.customerName;
    amount = widget.invoice!.amount;
    date = widget.invoice!.invoiceDate;
    dueDate = widget.invoice!.dueDate;
  }

  @override
  Widget build(BuildContext context) {
    final watchCustomers = ref.watch(customerProviderNotifier);
    final readCustomerNotifier = ref.read(customerProviderNotifier.notifier);
    final readInvoiceNotifier = ref.read(invoiceProviderNotifier.notifier);

    final router = GoRouter.of(context);

    if(!widget.isAdd){
      selectedCustomer = widget.invoice!.customerId.toString();
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
                              widget.isAdd ? const Text(
                                "Add Invoice",
                                style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold,),
                              ) :
                              const Text(
                                "Update Invoice",
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
                                      const Icon(Icons.person_outline_outlined,color: Colors.black,),
                                      const Text(
                                        "CustomerID: ",
                                        style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                      ),
                                    ],
                                  ),
                                  DropdownButton <String> (
                                        hint: const Text('Select a Customer'),
                                        isExpanded: true,
                                        value: selectedCustomer,
                                        items: watchCustomers.map((e) => DropdownMenuItem(
                                          value: e.id.toString(),
                                          child: Text(e.name),
                                        )).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCustomer = value!;
                                            customerID = int.parse(value);
                                          });
                                        },
                                      ),
                                ],
                              ),
                              
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
                if(customerID == null || amount == null){
                  showNotification("Please fill all fields");
                  return;
                }

                customerName = readCustomerNotifier.getCustomerById(customerID!)?.name ?? '';

                if(customerName!.isEmpty){
                  showNotification("Customer not found");
                  return;
                }

                if(widget.isAdd){
                  int id = readInvoiceNotifier.getlastId() + 1;
                  readInvoiceNotifier.addInvoice(Invoice(
                    id,
                    customerID!,
                    customerName!,
                    amount!,
                    date,
                    dueDate,
                  ));
                }else{
                  readInvoiceNotifier.updateInvoice(Invoice(
                    widget.invoice!.id,
                    customerID!,
                    customerName!,
                    amount!,
                    date,
                    dueDate,
                  ));
                }
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