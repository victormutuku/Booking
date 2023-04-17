import 'package:booking/screens/admin.dart';

import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Authscreen extends StatefulWidget {
  static const routeName = "/authscreen";

  Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
}

class _AuthscreenState extends State<Authscreen> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  String authErrorResponse = "";

  bool signup = false;
  bool checkPassword = false;
  bool checkConfirmPassword = false;
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });
    if (widget._formKey.currentState!.validate() == true) {
      if (signup == false) {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
          _redirect();
        } on FirebaseAuthException catch (e) {
          setState(() {
            _isLoading = false;
          });
          if (e.code == "wrong-password") {
            setState(() {
              authErrorResponse = "Incorrect Password";
            });
          } else if (e.code == "user-not-found") {
            setState(() {
              authErrorResponse = "User does not exist";
            });
          } else if (e.code == "invalid-email") {
            setState(() {
              authErrorResponse = "Invalid Email";
            });
          } else {
            // Add network-request-failed
            authErrorResponse = e.code;
          }
        }
      } else {
        try {
          final userDbRef = database.ref().child("/users_credentials");
          UserCredential result =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
          User user = result.user!;
          user.updateDisplayName(nameController.text.trim());
          userDbRef.push().set({
            "Name": nameController.text.trim(),
            "Uid": FirebaseAuth.instance.currentUser!.uid,
            "Email": emailController.text.trim(),
          });
          _redirect();
        } on FirebaseAuthException catch (e) {
          setState(() {
            _isLoading = false;
          });
          if (e.code == "email-already-in-use") {
            setState(() {
              authErrorResponse = "Email already in use";
            });
          } else {
            authErrorResponse = e.code;
          }
        }
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _redirect() {
    Navigator.of(context).pushReplacementNamed(Home.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: signup == false ? 220 : 180,
                  ),
                  Text(
                    signup == false ? 'Login' : 'Signup',
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.w500),
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
                          signup == true
                              ? TextFormField(
                                  controller: nameController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    hintText: 'Full Name',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email required';
                                    }
                                    return null;
                                  },
                                )
                              : const SizedBox(),
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
                          SizedBox(
                            height: signup == true ? 20 : 0,
                          ),
                          signup == true
                              ? TextFormField(
                                  controller: cPasswordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: 'Confirm Password',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          checkConfirmPassword =
                                              !checkConfirmPassword;
                                        });
                                      },
                                      icon: Icon(
                                        checkConfirmPassword == true
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  obscureText: checkConfirmPassword == true
                                      ? false
                                      : true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Confirm Password required';
                                    } else if (value !=
                                        passwordController.text) {
                                      return "Passwords do not match";
                                    } else if (value.length < 6) {
                                      return 'Enter a password with more than 6 characters';
                                    }
                                    return null;
                                  },
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 80,
                          ),
                          _isLoading == false
                              ? ElevatedButton(
                                  onPressed: _signIn,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: Text(
                                      signup == false ? 'Login' : 'Signup'),
                                )
                              : Container(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: const CircularProgressIndicator(),
                                ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                signup = !signup;
                              });
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            child: Text(signup == false
                                ? 'Don\'t have an account? Signup'
                                : 'Have an account? Login'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacementNamed(Admin.routeName),
                            child: const Text('Login in as Admin'),
                          ),
                          const SizedBox(
                            height: 10,
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
