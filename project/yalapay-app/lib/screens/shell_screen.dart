import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalapay/providers/cheque_deposit_provider.dart';
import 'package:yalapay/providers/cheque_provider.dart';
import 'package:yalapay/providers/customer_provider.dart';
import 'package:yalapay/providers/invoice_provider.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/providers/payment_provider.dart';
import 'package:yalapay/routes/app_router.dart';

class ShellScreen extends ConsumerStatefulWidget{
  final Widget child;
  final bool disableNav;
  const ShellScreen({super.key, required this.child, required this.disableNav});

  @override
  ConsumerState<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends ConsumerState<ShellScreen>{
  int _currentIndex = 0;
  int _currentNavIndex = 0;
  bool _clearSelection = false;

  void _navigationBar(int index){
    ref.read(paymentProviderNotifier.notifier).resetState();
    ref.read(chequeProviderNotifier.notifier).resetState();
    ref.read(customerProviderNotifier.notifier).resetState();
    ref.read(invoiceProviderNotifier.notifier).resetState(); 
    ref.read(chequeDepositProviderNotifier.notifier).resetState();

    final router = GoRouter.of(context);

    setState(() {
      _clearSelection = false;
      _currentNavIndex = index;

      if(_currentNavIndex <= 3){
        _currentIndex = _currentNavIndex;
      }
    });

    switch (index) {
      case 0:
        router.go(AppRouter.dashboard.path);
        break;
      case 1:
        router.go(AppRouter.invoice.path);
        break;
      case 2:
        router.go(AppRouter.payments.path);
        break;
      case 3:
        router.go(AppRouter.chequeDeposit.path);
    }
  }

  void _navigation(int index){
    // SEARCH NAV FIX
    ref.read(paymentProviderNotifier.notifier).resetState();
    ref.read(chequeProviderNotifier.notifier).resetState();
    ref.read(customerProviderNotifier.notifier).resetState();
    ref.read(invoiceProviderNotifier.notifier).resetState(); 
    ref.read(chequeDepositProviderNotifier.notifier).resetState();

    final router = GoRouter.of(context);

    setState(() {
      _clearSelection = false;
      _currentIndex = index;

      if(_currentIndex <= 3){
        _currentNavIndex = _currentIndex;
      }

      if(_currentIndex != _currentNavIndex){
        _clearSelection = true;
      }
    });
    
    switch (index) {
      case 0:
        router.go(AppRouter.dashboard.path);
        break;
      case 1:
        router.go(AppRouter.invoice.path);
        break;
      case 2:
        router.go(AppRouter.payments.path);
        break;
      case 3:
        router.go(AppRouter.chequeDeposit.path);
      case 4:
        router.go(AppRouter.customers.path);
        break;
      case 5:
        router.go(AppRouter.invoiceReport.path);
        break;
      case 6:
        router.go(AppRouter.chequeReport.path);
        break;
    }
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // final watchDisableNav = ref.watch(notDisableNavProvider);
    // final readDisableNavNotifier = ref.read(notDisableNavProvider.notifier);
    final readLoginNotifier = ref.read(loginProviderNotifier.notifier);

    final isWideScreen = MediaQuery.of(context).size.width >= 640;
    final router = GoRouter.of(context);

    return Scaffold(
      drawer: !isWideScreen && !widget.disableNav
      ? Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              height: 75,
              child: const DrawerHeader(
                child: Text(
                  'Quick Navigation.',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.people_outline_outlined,color: Colors.black,),
              title: const Text("Customers."),
              onTap:() {
                setState(() {
                  _clearSelection = true; 
                  _currentIndex = 0;
                });
                router.go(AppRouter.customers.path);
                Navigator.of(context).pop();
              },
            ),
            const Divider(color: Colors.black,),
            ListTile(
              leading: const Icon(Icons.folder_outlined,color: Colors.black,),
              title: const Text("Generate Invoice Report."),
              onTap:() {
                setState(() {
                  _clearSelection = true; 
                  _currentIndex = 0;
                });
                router.go(AppRouter.invoiceReport.path);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder_outlined,color: Colors.black,),
              title: const Text("Generate Cheque Report."),
              onTap:() {
                setState(() {
                  _clearSelection = true; 
                  _currentIndex = 0;
                });
                router.go(AppRouter.chequeReport.path);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ): null,
      
      appBar: !widget.disableNav ?
          AppBar(
            iconTheme: const IconThemeData(
                color: Colors.green,
              ),
            backgroundColor: Colors.white,
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Yala',
                    style: GoogleFonts.yellowtail(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: ' Pay',
                    style: TextStyle(
                      fontFamily: 'Sans', 
                      fontSize: 10,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.account_circle, color: Colors.black),
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  PopupMenuItem(child: const Text("Sign out"), onTap: () async{
                    readLoginNotifier.logout();

                    GoRouter.of(context).go(AppRouter.login.path);
                  },)
                ],
              ),
            ],
          ) : null,
      
      body: Row(
        children: [
          if (isWideScreen && !widget.disableNav)
          NavigationRail(
              backgroundColor: Colors.white,
              labelType: NavigationRailLabelType.all,
              selectedIconTheme:  const IconThemeData(size: 30, color: Colors.green),
              unselectedIconTheme: const IconThemeData(size: 25, color: Colors.black),
              indicatorColor: Colors.grey.shade100,
              selectedIndex: _currentIndex,
              selectedLabelTextStyle: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              destinations:  const [
                NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                label: Text("Home", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.insert_drive_file_outlined),
                  label: Text("Invoices",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.money),
                  label: Text("Payments",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.calendar_view_day_outlined),
                  label: Text("Deposits",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people_outline_outlined),
                  label: Text("Customers",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                NavigationRailDestination(
                  icon:  Icon(Icons.folder_outlined),
                  label: Text("Generate Invoice Report.",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),overflow: TextOverflow.ellipsis,),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.folder_outlined),
                  label: Text("Generate Cheque Report.",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ], 
              onDestinationSelected: _navigation
            ),
          Expanded(child: widget.child,),
        ],
      ),
      
      bottomNavigationBar: (!isWideScreen && !widget.disableNav) ?
      BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentNavIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        selectedLabelStyle: _clearSelection ? const TextStyle(color: Colors.black) : const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        selectedIconTheme: _clearSelection ? const IconThemeData( color: Colors.black) : const IconThemeData(size: 30, color: Colors.green),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file_outlined),
            label: "Invoices",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: "Payments",
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day_outlined),
            label: "Deposits",
          ),
        ],
        onTap: _navigationBar
        ): null,
    );
}
}