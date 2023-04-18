import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'admin_home.dart';

class AdminAuth extends StatefulWidget {
  static const routeName = "/adminauth";

  AdminAuth({super.key});

  @override
  State<AdminAuth> createState() => _AdminAuthState();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
}

class _AdminAuthState extends State<AdminAuth> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String authErrorResponse = "";

  bool checkPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (widget._formKey.currentState!.validate() == true) {
      if (emailController.text.trim() == "admin@admin.com" &&
          passwordController.text.trim() == "Admin123") {
        _redirect();
      } else {
        setState(() {
          authErrorResponse = "Incorrect email or password";
        });
      }
    }
  }

  _redirect() {
    Navigator.of(context).pushReplacementNamed(AdminHomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Text(
                    'Admin',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Form(
                      key: widget._formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    checkPassword = !checkPassword;
                                  });
                                },
                                icon: Icon(
                                  checkPassword == true
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            obscureText: checkPassword == true ? false : true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password required';
                              } else if (value.length < 6) {
                                return 'Enter a password with more than 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          ElevatedButton(
                            onPressed: _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 12,
                              ),
                            ),
                            child: const Text('Login'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            authErrorResponse,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
