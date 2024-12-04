import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/models/address.dart';
import 'package:yalapay/models/contact_details.dart';
import 'package:yalapay/models/customer.dart';
import 'package:yalapay/providers/customer_provider.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/routes/app_router.dart';

class AddCustomerScreen extends ConsumerStatefulWidget {
  final bool isAdd;
  final Customer? customer;
  const AddCustomerScreen({super.key, this.customer, required this.isAdd});

  @override
  ConsumerState<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends ConsumerState<AddCustomerScreen>{
  String? companyName;
  String? city;
  String? country;
  String? street;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;

  final TextEditingController _controllerCompanyName = TextEditingController();
  final TextEditingController _controllerCity = TextEditingController();
  final TextEditingController _controllerCountry = TextEditingController();
  final TextEditingController _controllerStreet = TextEditingController();
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

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
    super.dispose();
    _controllerCompanyName.dispose();
    _controllerCity.dispose();
    _controllerCountry.dispose();
    _controllerStreet.dispose();
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    _controllerMobile.dispose();
    _controllerEmail.dispose();
  }


  void showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  void updateFields() {
      _controllerCompanyName.text = widget.customer!.name;
      _controllerCity.text = widget.customer!.address.city;
      _controllerCountry.text = widget.customer!.address.country;
      _controllerStreet.text = widget.customer!.address.street;
      _controllerFirstName.text = widget.customer!.contactDetails.firstName;
      _controllerLastName.text = widget.customer!.contactDetails.lastName;
      _controllerMobile.text = widget.customer!.contactDetails.mobile;
      _controllerEmail.text = widget.customer!.contactDetails.email;

      companyName = widget.customer!.name;
      city = widget.customer!.address.city;
      country = widget.customer!.address.country;
      street = widget.customer!.address.street;
      firstName = widget.customer!.contactDetails.firstName;
      lastName = widget.customer!.contactDetails.lastName;
      mobile = widget.customer!.contactDetails.mobile;
      email = widget.customer!.contactDetails.email;
  }

  @override
  Widget build(BuildContext context) {
    final readCustomerNotifier = ref.read(customerProviderNotifier.notifier);

    final router = GoRouter.of(context);
   
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child:
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    Container(
                      height: 650,
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
                              "Add Customers",
                              style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold,),
                            ) :
                            const Text(
                              "Update Customers",
                              style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold,),
                            ),
                            const SizedBox(height: 18,),
                            Row(
                              children: [
                                const Icon(Icons.other_houses_outlined,color: Colors.black,),
                                SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  "Company Name : ",
                                  style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _controllerCompanyName,
                                    decoration: const InputDecoration(
                                      hintText: 'Company Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: UnderlineInputBorder(), 
                                    ),
                                    onChanged:(text) {
                                      setState(() {
                                        companyName = text;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 16),
                            const Text("Address:", style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                            Row(
                              children: [
                                const Icon(Icons.emoji_transportation, color: Colors.black,),
                                SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  "Street : ",
                                  style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _controllerStreet,
                                    decoration: const InputDecoration(
                                      hintText: 'Street',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: UnderlineInputBorder(),
                                    ),
                                    onChanged:(text) {
                                      setState(() {
                                        street = text;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                const Icon(Icons.home_work_outlined, color: Colors.black,),
                                SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  "City : ",
                                  style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _controllerCity,
                                    decoration: const InputDecoration(
                                      hintText: 'City',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: UnderlineInputBorder(),
                                    ),
                                    onChanged:(text) {
                                      setState(() {
                                        city = text;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.public,color: Colors.black,),
                                SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  "Country : ",
                                  style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _controllerCountry,
                                    decoration: const InputDecoration(
                                      hintText: 'Country',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: UnderlineInputBorder(),
                                    ),
                                    onChanged:(text) {
                                      setState(() {
                                        country = text;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text("Contact Details:",
                                    style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                            Row(
                              children: [
                                const Icon(Icons.person_4_outlined,color: Colors.black,),
                                SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  "First Name : ",
                                  style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _controllerFirstName,
                                    decoration: const InputDecoration(
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: UnderlineInputBorder(),
                                    ),
                                    onChanged:(text) {
                                      setState(() {
                                        firstName = text;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.person_4_outlined,color: Colors.black,),
                                SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  "Last Name : ",
                                  style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _controllerLastName,
                                    decoration: const InputDecoration(
                                      hintText: 'Last Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: UnderlineInputBorder(),
                                    ),
                                    onChanged:(text) {
                                      setState(() {
                                        lastName = text;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.phone_android_outlined,color: Colors.black,),
                                SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  "Mobile : ",
                                  style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _controllerMobile,
                                    decoration: const InputDecoration(
                                      hintText: 'Mobile',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: UnderlineInputBorder(),
                                    ),
                                    onChanged:(text) {
                                      setState(() {
                                        mobile = text;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.mail_outline,color: Colors.black,),
                                SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  "Email : ",
                                  style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _controllerEmail,
                                    decoration: const InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: UnderlineInputBorder(),
                                    ),
                                    onChanged:(text) {
                                      setState(() {
                                        email = text;
                                      });
                                    },
                                  ),
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
              backgroundColor: Colors.black,
              heroTag: null,
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
              backgroundColor: Colors.green,
              heroTag: null,
              onPressed:() {
                setState(() {
                  String name = companyName ?? '';
                  String st = street ?? '';
                  String ci = city ?? '';
                  String co = country ?? '';
                  String fn = firstName ?? '';
                  String ln = lastName ?? '';
                  String mob = mobile ?? '';
                  String em = email ?? '';

                  if(name == '' || st == '' || ci == '' || co == '' || fn == '' || ln == '' || mob == '' || em == '') {
                    showNotification('Please Fill In All The Fields');
                  }
                  else{
                    if(widget.isAdd){
                      int id = readCustomerNotifier.getlastId() + 1;

                      readCustomerNotifier.addCustomer(
                        Customer(id, name, Address(st, ci, co),ContactDetails(fn, ln, mob, em)
                        )
                      );
                    }
                    else{
                      readCustomerNotifier.updateCustomer(
                        Customer(widget.customer!.id, name, Address(st, ci, co),ContactDetails(fn, ln, mob, em)
                        )
                      );
                    }
                    router.pop();
                  }    
                });
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