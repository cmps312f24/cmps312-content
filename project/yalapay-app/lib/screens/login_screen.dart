import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/routes/app_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>{
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  String username = '';
  String password = ''; 

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool logged = await ref.read(loginProviderNotifier.notifier).isLoggedIn();

      if(logged){
        GoRouter.of(context).go(AppRouter.dashboard.path);
      }
      else{
        GoRouter.of(context).go(AppRouter.login.path);
      }
    });
  }

  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  void updateUsername(String username) {
    setState(() {
      this.username = username.split('@')[0].toLowerCase();
    });
  }

  void updatePassword(String password) {
    setState(() {
      this.password = password;
    });
  }

  void showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }
  @override
  Widget build(BuildContext context) {
    final readLoginNotifier = ref.read(loginProviderNotifier.notifier);

    final router = GoRouter.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/YalapayLogo.png',height: 300, width: 400,),
                Container(
                  height: 500,
                  width: 400,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Login",
                            style: TextStyle(fontSize: 36, color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 24,),
                          Row(
                            children: [
                              const Text(
                                "Username : ",
                                style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _controllerUsername,
                                  decoration: const InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: UnderlineInputBorder(),
                                  ),
                                  onChanged:(a) {
                                    updateUsername(a.toLowerCase());
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text(
                                "Password : ",
                                style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _controllerPassword,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: UnderlineInputBorder(),
                                  ),
                                  onChanged:(a) {
                                    updatePassword(a);
                                  },
                                  onSubmitted: (a) async {
                                    bool validate = await readLoginNotifier.login(username.toLowerCase(), password);
                              
                                    setState(() {
                                      if(!validate){
                                        showNotification('Invalid Username or Password');
                                      }else{
                                        updatePassword('');
                                        updateUsername('');
                                        _controllerUsername.clear();
                                        _controllerPassword.clear();
                                        router.go(AppRouter.dashboard.path);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
            
                      Positioned(
                        bottom: 140,
                        right: 16,
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                          child: FloatingActionButton(
                            backgroundColor: Colors.green,
                            onPressed:() async {
                              bool validate = await readLoginNotifier.login(username.toLowerCase(), password);
                              
                              setState(() {
                                if(!validate){
                                  showNotification('Invalid Username or Password');
                                }else{
                                  updatePassword('');
                                  updateUsername('');
                                  _controllerUsername.clear();
                                  _controllerPassword.clear();
                                  router.go(AppRouter.dashboard.path);
                                }
                              });
                            },
                          child: const Text("Login", style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}