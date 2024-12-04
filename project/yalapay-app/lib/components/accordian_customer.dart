import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/data_classes/customer_args.dart';
import 'package:yalapay/models/customer.dart';
import 'package:yalapay/providers/customer_provider.dart';
import 'package:yalapay/providers/invoice_provider.dart';
import 'package:yalapay/routes/app_router.dart';

class AccordianCustomer extends ConsumerStatefulWidget {
  final Customer customer;
  const AccordianCustomer({super.key, required this.customer});

  @override
  ConsumerState<AccordianCustomer> createState() => _AccordianCustomerState();

}

class _AccordianCustomerState extends ConsumerState<AccordianCustomer> {
  bool isIconUp = false;

  void setIsIconUp(bool value) {
    setState(() {
      isIconUp = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final readCustomerNotifier = ref.read(customerProviderNotifier.notifier);
    final readInvoiceNotifier = ref.read(invoiceProviderNotifier.notifier);
    final readInvoice = ref.read(invoiceProviderNotifier);

    final router = GoRouter.of(context);
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
                  flex: 4,
                  child: Text(widget.customer.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                

                Flexible(
                  flex: 2,
                  child: Text('${widget.customer.contactDetails.firstName} ${widget.customer.contactDetails.lastName}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),

                Flexible(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Text(widget.customer.contactDetails.mobile, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                      ),
                      Flexible(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isIconUp ? setIsIconUp(false): setIsIconUp(true);
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
                )
              ],

            ),
            if (isIconUp)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text('Address:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
                                Text('Street: ',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.emoji_transportation, size: 12),
                              ],
                            ),
                            Text(
                              '${widget.customer.address.street} ',
                              style: TextStyle(fontSize: 12)
                            ),
                            const SizedBox(height: 8.0), 
                            const Row(
                              children: [
                                Text('Country: ',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.public, size: 12),
                              ],
                            ),
                            Text(
                              widget.customer.address.country,
                              style: TextStyle(fontSize: 12)
                            )
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
                                'City: ',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              SizedBox(height: 0, width: 10,),
                              Icon(Icons.home_work_outlined, size: 12),
                            ],
                          ),
                          Text(
                            widget.customer.address.city,
                            style: TextStyle(fontSize: 12)
                          ), 
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Text('Contract Details:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),

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
                                Text('Name: ',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.person_outline, size: 12),
                              ],
                            ),
                            Text(
                              '${widget.customer.contactDetails.firstName} ${widget.customer.contactDetails.lastName}',
                              style: TextStyle(fontSize: 12)
                            ),
                            const SizedBox(height: 8.0),
                            const Row(
                              children: [
                                Text('Email: ',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.email_outlined, size: 12),
                              ],
                            ),
                            Text(
                              widget.customer.contactDetails.email,
                              style: TextStyle(fontSize: 12)
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
                                'Mobile: ',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              SizedBox(height: 0, width: 10,),
                              Icon(Icons.phone_android_outlined, size: 12),
                            ],
                          ),
                          Text(
                            widget.customer.contactDetails.mobile,
                            style: TextStyle(fontSize: 12)
                          ),
                          const SizedBox(height: 8.0),
                          
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
                          router.push(
                          '${AppRouter.customers.path}${AppRouter.addcustomer.path}',
                          extra: CustomerArgs(isAdd: false, customer: widget.customer),
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
                                title: const Text('Delete Customer', style: TextStyle(fontWeight: FontWeight.bold),),
                                content: const Text('Are you sure you want to delete this customer? \nThis cannot be undone. \nAll related invoices will be deleted as well.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      readCustomerNotifier.deleteCustomer(widget.customer);

                                      for(var invoice in readInvoice){
                                        if(invoice.customerId == widget.customer.id){
                                          readInvoiceNotifier.deleteInvoice(invoice);
                                        }
                                      }

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