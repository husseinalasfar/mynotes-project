import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController? _email;
  TextEditingController? _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email!.dispose();
    _password!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Login Page",
      )),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                    child: TextFormField(
                      controller: _email,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Enter your email here",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                    child: TextFormField(
                      controller: _password,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                          hintText: "Enter your password here",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        try {
                          var userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email!.text,
                                  password: _password!.text);
                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print("USER NOT FOUND");
                          } else if (e.code == 'wrong-password') {
                            print('WRONG PASWORD');
                          }
                        }
                      },
                      child: const Text("LOGIN")),
                ],
              );
            default:
              return const Text('loading...');
          }
        },
      ),
    );
  }
}
