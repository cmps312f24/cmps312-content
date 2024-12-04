import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/components/accordian_cheques.dart';
import 'package:yalapay/providers/cheque_provider.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/routes/app_router.dart';
class ChequeReportScreen extends ConsumerStatefulWidget {
  const ChequeReportScreen({super.key});

  @override
  ConsumerState<ChequeReportScreen> createState() => _ChequeReportScreenState();
}

class _ChequeReportScreenState extends ConsumerState<ChequeReportScreen> {
  bool isIconUp = false;

  void setIsIconUp(bool value) {
    setState(() {
      isIconUp = value;
    });
  }

  late String selectedOption= "All" ;
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
    final readChequeNotifier = ref.read(chequeProviderNotifier.notifier);
    final  (cheques, length, total) = ref.read(chequeProviderNotifier.notifier).filterChequeReport(date, toDate, selectedOption);
    final (chequesAwaiting, lengthAwaiting, totalAwaiting) = ref.read(chequeProviderNotifier.notifier).filterChequeReport(date, toDate, 'Awaiting');
    final (chequesDeposited, lengthDeposited, totalDeposited) = ref.read(chequeProviderNotifier.notifier).filterChequeReport(date, toDate, 'Deposited');
    final (chequesCashed, lengthCashed, totalCashed) = ref.read(chequeProviderNotifier.notifier).filterChequeReport(date, toDate, 'Cashed');
    final (chequesReturned, lengthReturned, totalReturned) = ref.read(chequeProviderNotifier.notifier).filterChequeReport(date, toDate, 'Returned');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            child: const Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Cheques Report.',
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              ).then((value) =>setState(() {
                                date = value??date;
                                readChequeNotifier.getByDate(date, toDate);
                                }  ),);
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                readChequeNotifier.getByDate(date, toDate);
                                }  ),);
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
                          value: "Awaiting", 
                          label: "Awaiting",
                          ),
                        DropdownMenuEntry(
                          value: "Deposited", 
                          label: "Deposited",
                          ),
                        DropdownMenuEntry(
                          value: "Cashed", 
                          label: "Cashed",
                          ),
                          DropdownMenuEntry(
                          value: "Returned", 
                          label: "Returned",
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
          
          if (selectedOption=="Awaiting"|| selectedOption=="All")...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 16,),
              Expanded(child: Text("Awaiting Total Amount: $totalAwaiting",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
              Text("Count: $lengthAwaiting",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              const SizedBox(width: 50,),
              ],
            )
          ],

          if(selectedOption=="Deposited"|| selectedOption=="All")...[
           Row(
            
            children: [
              const SizedBox(width: 16,),
              Expanded(child: Text("Deposited Total Amount: $totalDeposited",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
              Text("Count: $lengthDeposited",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              const SizedBox(width: 50,),
              ],
            )
          ],

          if (selectedOption=="Cashed"|| selectedOption=="All")...[
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 16,),
              Expanded(child: Text("Cashed Total Amount: $totalCashed",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
              Text("Count: $lengthCashed",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              const SizedBox(width: 50,),
              ],
            ),
          ],

          if (selectedOption=="Returned"|| selectedOption=="All")...[
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 16,),
              Expanded(child: Text("Returned Total ammount: $totalReturned",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
              Text("Count: $lengthReturned",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              const SizedBox(width: 50,),
              ],
            ),
          ],

          if(selectedOption=="All")...[
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 16,),
              Expanded(child: Text("Grand Total : $total",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
              Text("Count: $length",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              const SizedBox(width: 50,),
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
                  itemCount: length,
                  itemBuilder: (context, index) {
                    return AccordianCheques(cheque: cheques[index], false);
                  },
                ),
              ),
            ),
        ]
      )
    );
  }
}

