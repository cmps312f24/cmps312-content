import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/components/accordian_invoice.dart';
import 'package:yalapay/providers/invoice_provider.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/routes/app_router.dart';


class InvoiceReportScreen extends ConsumerStatefulWidget {
  const InvoiceReportScreen({super.key});

  @override
  ConsumerState<InvoiceReportScreen> createState() => _InvoiceReportScreenState();
}

class _InvoiceReportScreenState extends ConsumerState<InvoiceReportScreen> {
  late String selectedOption= 'All';
  DateTime date=DateTime.now();
  DateTime toDate=DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool logged = await ref.read(loginProviderNotifier.notifier).isLoggedIn();

      if(!logged){
        GoRouter.of(context).go(AppRouter.error.path);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final readInvoiceNotifier = ref.read(invoiceProviderNotifier.notifier);
    final (invoices, invoiceLength, invoiceAmount) = ref.read(invoiceProviderNotifier.notifier).filterInvoices(date, toDate, selectedOption);
    final (pending, pendingLength, pendingAmount) = ref.read(invoiceProviderNotifier.notifier).filterInvoices(date, toDate, 'Pending');
    final (partial, partialLength, partialAmount) = ref.read(invoiceProviderNotifier.notifier).filterInvoices(date, toDate, 'Partially Paid');
    final (paid, paidLength, paidAmount) = ref.read(invoiceProviderNotifier.notifier).filterInvoices(date, toDate, 'Paid');
 
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            child: const Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Invoices Report.',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

            const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(color: Colors.black),
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "From Date : ",
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_month_rounded),
                          onPressed: () {
                              showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                              ).then((value) => setState(() {
                                date = value??date;
                                readInvoiceNotifier.getByInvoiceDate(date, toDate);
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
                            child: Text("${date.day.toString()}-${date.month.toString()}-${date.year.toString()}")),
                        ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "To Date : ",
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold,),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_month_rounded),
                          onPressed:() {
                            showDatePicker(
                              context: context,
                              initialDate: toDate,
                              firstDate: date,
                              lastDate: DateTime(2300),
                              ).then((value) =>setState(() {
                                toDate = value??toDate;
                                readInvoiceNotifier.getByInvoiceDate(date, toDate);
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
                          child: Text("${toDate.day.toString()}-${toDate.month.toString()}-${toDate.year.toString()}"),
                        ),
                  ],
                ),
              ],
            ),
            Row(
                children: [
                  const SizedBox(width: 16,),
                  const Text("Invoice Status :",
                          style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                          const SizedBox(width: 16,),
                          Expanded(
                    child: DropdownMenu(
                      onSelected: (value) {
                        setState(() {
                          selectedOption=value.toString();
                        });
                      },
                      initialSelection: 0,
                      width: double.maxFinite,
                      hintText: "Select",
                      inputDecorationTheme: const InputDecorationTheme(fillColor:  Colors.white,filled: true,border: InputBorder.none),
                      menuStyle: const MenuStyle(backgroundColor: WidgetStatePropertyAll( Colors.white)),
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                          value: "All", 
                          label: "All",
                          ),
                        DropdownMenuEntry(
                          value: "Pending", 
                          label: "Pending",
                          ),
                        DropdownMenuEntry(
                          value: "Partially Paid", 
                          label: "Partially Paid",
                          ),
                        DropdownMenuEntry(
                          value: "Paid", 
                          label: "Paid",
                          )
                      ],
                    ),
                  ),
                ],
              ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(color: Colors.black),
          ),
          
          if (selectedOption.toLowerCase() == 'pending'|| selectedOption.toLowerCase() == 'all')...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16,),
              Expanded(child: Text("Pending Total Amount: \$$pendingAmount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),  
              Text("Count: $pendingLength",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              SizedBox(width: 50,),
            ],
          )
          ], 
          if(selectedOption.toLowerCase() == 'partially paid'|| selectedOption.toLowerCase() == 'all')...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16,),
              Expanded(child: Text("Partially Paid Total Amount: \$$partialAmount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
              Text("Count: $partialLength",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              SizedBox(width: 50,),
            ],
          )
          ],
          if (selectedOption.toLowerCase() == 'paid'|| selectedOption.toLowerCase() == 'all')...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16,),
              Expanded(child: Text("Paid Total Amount: \$$paidAmount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
              Text("Count: $paidLength",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              SizedBox(width: 50,),
            ],
          ),
          ],

          if(selectedOption.toLowerCase() == 'all')...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16,),
              Expanded(
                child: Text("Grand Total: \$$invoiceAmount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              ),
              Text("Count: $invoiceLength",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              SizedBox(width: 50,),
            ],
          )
          ],

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(color: Colors.black),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: invoiceLength,
                itemBuilder: (context, index) {
                  return AccordianInvoice(invoice: invoices[index]);
                },
              ),
            ),
          ),
        ]
      )
    );
  }

}

