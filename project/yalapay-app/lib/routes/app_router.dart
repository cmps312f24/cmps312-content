import 'package:go_router/go_router.dart';
import 'package:yalapay/data_classes/cheque_deposit_args.dart';
import 'package:yalapay/data_classes/customer_args.dart';
import 'package:yalapay/data_classes/invoice_args.dart';
import 'package:yalapay/data_classes/payment_args.dart';
import 'package:yalapay/screens/addPayment_screen.dart';
import 'package:yalapay/screens/add_Invoice.dart';
import 'package:yalapay/screens/add_cheque_deposit_screen.dart';
import 'package:yalapay/screens/add_customer_screen.dart';
import 'package:yalapay/screens/cheque_report_screen.dart';
import 'package:yalapay/screens/cheques_screen.dart';
import 'package:yalapay/screens/cheques_deposit_screen.dart';
import 'package:yalapay/screens/customer_screen.dart';
import 'package:yalapay/screens/dashboard.dart';
import 'package:yalapay/screens/error_screen.dart';
import 'package:yalapay/screens/invoice_report_screen.dart';
import 'package:yalapay/screens/invoice_screen.dart';
import 'package:yalapay/screens/login_screen.dart';
import 'package:yalapay/screens/payment_screen.dart';
import 'package:yalapay/screens/shell_screen.dart';

class AppRouter {
  static const login = (name: '/', path: '/');
  static const customers = (name: 'customers', path: '/customers');
  static const addcustomer = (name: 'addcustomers', path: '/addcustomers');
  static const payments = (name: 'payments', path: '/payments');
  static const paymentsFromInvoice = (name: 'paymentsFromInvoice', path: '/paymentsFromInvoice');
  static const addPayment = (name: 'addPayment', path: '/addPayment');
  static const addPaymentFromInvoice = (name: 'addPaymentFromInvoice', path: '/addPaymentFromInvoice');
  static const invoice = (name: 'invoice', path: '/invoice');
  static const addInvoice = (name: 'addInvoice', path: '/addInvoice');
  static const chequeDeposit = (name: 'cheque-deposit', path: '/cheque-deposit');
  static const cheque = (name: 'cheque', path: '/cheque');
  static const addChequeDeposit = (name: 'addChequeDeposit', path: '/addChequeDeposit');
  static const dashboard = (name: 'dashboard', path: '/dashboard');
  static const error = (name: 'error', path: '/error');

  static const invoiceReport = (name: 'invoiceReport', path: '/invoiceReport');
  static const chequeReport = (name: 'chequeReport', path: '/chequeReport');

  static final GoRouter router = GoRouter(
    initialLocation: login.path,
    routes:[
      ShellRoute(
        routes: [
          GoRoute(
            name: login.name,
            path: login.path,
            builder: (context, state) {
              return const LoginScreen();
            },
            routes: [
              GoRoute(
                name: error.name,
                path: error.path,
                builder: (context, state) {
                  return const ErrorScreen();
                }
              ),

              GoRoute(
              name: customers.name,
              path: customers.path,
              builder: (context, state) {
                return const CustomerScreen();
              },
              routes: [
                GoRoute(
                  name: addcustomer.name,
                  path: addcustomer.path,
                  builder: (context, state) {
                    final args = state.extra as CustomerArgs?;
                    return AddCustomerScreen(customer: args?.customer, isAdd: args?.isAdd ?? true,);
                  },
                )
              ]),

              GoRoute(
                name: payments.name,
                path: payments.path,
                builder: (context, state) {
                  final args = state.extra as PaymentArgs?;
                  return PaymentsScreen(isInvoice: args?.isInvoice ?? false, invoiceId: args?.invoiceNo,);
                },
                routes: [
                  GoRoute(
                    name: addPayment.name,
                    path: addPayment.path,
                    builder: (context, state) {
                      final args = state.extra as PaymentArgs?;
                      return AddPaymentScreen(isAdd: args?.isAdd ?? true, payment: args?.payment, isInvoice: args?.isInvoice ?? false, invoiceNo: args?.invoiceNo ?? 0);
                    },
                  )
                ]
              ),

              GoRoute(
                name: invoice.name,
                path: invoice.path,
                builder: (context, state) {
                  return const InvoiceScreen();
                },
                routes: [
                  GoRoute(
                    name: addInvoice.name,
                    path: addInvoice.path,
                    builder: (context, state) {
                      final args = state.extra as InvoiceArgs?;
                      return AddInvoiceScreen(invoice: args?.invoice, isAdd: args?.isAdd ?? true);
                    }
                  ),
                  GoRoute(
                    name: paymentsFromInvoice.name,
                    path: paymentsFromInvoice.path,
                    builder: (context, state) {
                      final args = state.extra as PaymentArgs?;
                      return PaymentsScreen(isInvoice: args?.isInvoice ?? false, invoiceId: args?.invoiceNo,);
                    },
                    routes: [
                      GoRoute(
                        name: addPaymentFromInvoice.name,
                        path: addPaymentFromInvoice.path,
                        builder: (context, state) {
                          final args = state.extra as PaymentArgs?;
                          return AddPaymentScreen(isAdd: args?.isAdd ?? true, payment: args?.payment, isInvoice: args?.isInvoice ?? false, invoiceNo: args?.invoiceNo ?? 0);
                        },
                      )
                    ]
                  )
                ]
                  
              ),

              GoRoute(
                name: chequeDeposit.name,
                path: chequeDeposit.path,
                builder: (context, state) {
                  return const ChequeDepositScreen();
                },
                routes: [
                  GoRoute(
                    name: addChequeDeposit.name,
                    path: addChequeDeposit.path,
                    builder: (context, state) {
                      final args = state.extra as ChequeDepositArgs?;
                      return AddChequeDepositScreen(chequeDeposit: args?.chequeDeposit, isAdd: args?.isAdd ?? true);
                    
                    },
                    routes: [
                      GoRoute(
                        name: cheque.name,
                        path: cheque.path,
                        builder: (context, state) {
                          final args = state.extra as ChequeDepositArgs?;
                          return ChequesScreen(cheques: args?.chequeArgs?.cheques, isAdd: args?.isAdd ?? true);
                        },
                      )
                    ]
                  )
                ]
              ),

              GoRoute(
                name: dashboard.name,
                path: dashboard.path,
                builder: (context, state) {
                  return const DashboardScreen();
                }
              ),

              GoRoute(
                name: invoiceReport.name,
                path: invoiceReport.path,
                builder: (context, state) {
                  return const InvoiceReportScreen();
                }
              ),

              GoRoute(
                name: chequeReport.name,
                path: chequeReport.path,
                builder: (context, state) {
                  return const ChequeReportScreen();
                }
              ),

            ]
          ),
          
        ],
        builder: (context, state, child) {    
          bool disableNav = false;
          if(
            state.fullPath == login.path || 
            state.fullPath == '${error.path}' ||
            state.fullPath == '${customers.path}${addcustomer.path}' ||
            state.fullPath == '${payments.path}${addPayment.path}' ||
            state.fullPath == '${customers.path}${addcustomer.path}' ||
            state.fullPath == '${invoice.path}${addInvoice.path}' ||
            state.fullPath == '${invoice.path}${paymentsFromInvoice.path}' ||
            state.fullPath == '${invoice.path}${paymentsFromInvoice.path}${addPaymentFromInvoice.path}' ||
            state.fullPath == '${chequeDeposit.path}${addChequeDeposit.path}' ||
            state.fullPath == '${chequeDeposit.path}${addChequeDeposit.path}${cheque.path}'
            ){
            disableNav = true;
          }
          return ShellScreen(
            disableNav: disableNav,
            child: child,
          );
        } 
      )
    ]
  );
}