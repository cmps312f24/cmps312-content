import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/routes/app_router.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>{

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
    double iconByScreen= MediaQuery.of(context).size.width<=778?MediaQuery.of(context).size.width*0.06:46;
    double textByScreen= MediaQuery.of(context).size.width<=778?MediaQuery.of(context).size.width*0.035:27;
    double SizedBoxByScreen= MediaQuery.of(context).size.width<=778?MediaQuery.of(context).size.width*0.4:312;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Dashboard.",style: TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold,),),
              const SizedBox(height: 20,),
              const Text("Invoices",style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold,)),
              const Divider(color: Colors.black,),
              SizedBox(
                height: SizedBoxByScreen,
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, 
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1,
                    ), 
                      children: [
                        GestureDetector( 
                        onTap: () {
                          //TODO PHASE 2
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            decoration: BoxDecoration(
                            color:  const Color.fromARGB(255, 234, 234, 234),
                            borderRadius: BorderRadius.circular(10),
                            ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.watch_later_outlined,color: Colors.black,size: iconByScreen,),
                                  Text("QR 99.99",style: TextStyle(fontSize: textByScreen, color: Colors.green, fontWeight: FontWeight.bold,)),
                                  const Text("Invoice Due All", style: TextStyle(fontSize: 10, color: Colors.black))
                                ],
                              ),
                            ),
                        ),
                      ),
                  
                      GestureDetector(
                        onTap: () {
                          //TODO PHASE 2
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            decoration: BoxDecoration(
                            color:  const Color.fromARGB(255, 234, 234, 234),
                            borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Icon(Icons.watch_later_outlined,color: Colors.black,size: iconByScreen,),
                                Text("QR 60.99",style: TextStyle(fontSize: textByScreen, color: Colors.orange[300], fontWeight: FontWeight.bold,)),
                                const Text("Invoice Due 60 Days", style: TextStyle(fontSize: 10, color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                      ),
                  
                      GestureDetector(
                        onTap: () {
                          //TODO PHASE 2
                        },
                        child: Card(
                          elevation:4,
                          child: Container(
                            decoration: BoxDecoration(
                            color:  const Color.fromARGB(255, 234, 234, 234),
                            borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Icon(Icons.watch_later_outlined,color: Colors.black,size: iconByScreen,),
                                Text("QR 30.00",style: TextStyle(fontSize: textByScreen, color: Colors.red, fontWeight: FontWeight.bold,)),
                                const Text("Invoice Due 30 Days", style: TextStyle(fontSize: 10, color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                      ),
                      ],
                     
                  ),
                ),
              ),
              const Text("Cheques",style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold,)),
              const Divider(color: Colors.black,),
              SizedBox(
                width: 600,
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, 
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1,
                      mainAxisExtent: null
                    ), 
                      children: [
                        GestureDetector( 
                        onTap: () {
                          //TODO PHASE 2
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 234, 234, 234),
                            borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.watch_later_outlined, color: Colors.black, size: iconByScreen),
                              Text("QR 99.99", style: TextStyle(fontSize: textByScreen, color: Colors.orange[300], fontWeight: FontWeight.bold)),
                              const Text("Awaiting Cheques", style: TextStyle(fontSize: 10, color: Colors.black)),
                            ],
                            ),
                          ),
                          ),
                        ),
                      GestureDetector(
                        onTap: () {
                          //TODO PHASE 2
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            decoration: BoxDecoration(
                            color:  const Color.fromARGB(255, 234, 234, 234),
                            borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Icon(Icons.watch_later_outlined,color: Colors.black,size: iconByScreen,),
                                Text("QR 22.22",style: TextStyle(fontSize: textByScreen, color: Colors.blue[800], fontWeight: FontWeight.bold,)),
                                const Text("Deposited", style: TextStyle(fontSize: 10, color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          //TODO Phase 2
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            decoration: BoxDecoration(
                            color:  const Color.fromARGB(255, 234, 234, 234),
                            borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Icon(Icons.watch_later_outlined,color: Colors.black,size: iconByScreen,),
                                Text("QR 44.44",style: TextStyle(fontSize: textByScreen, color: Colors.green, fontWeight: FontWeight.bold,)),
                                const Text("Cashed", style: TextStyle(fontSize: 10, color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                            //TODO PHASE 2
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            decoration: BoxDecoration(
                            color:  const Color.fromARGB(255, 234, 234, 234),
                            borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Icon(Icons.watch_later_outlined,color: Colors.black,size: iconByScreen,),
                                Text("QR 11.11",style: TextStyle(fontSize: textByScreen, color: Colors.red, fontWeight: FontWeight.bold,)),
                                const Text("Returned", style: TextStyle(fontSize: 10, color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}