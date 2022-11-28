import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerfiyEmailView extends StatefulWidget {
  const VerfiyEmailView({Key? key}) : super(key: key);

  @override
  State<VerfiyEmailView> createState() => _VerfiyEmailViewState();
}

class _VerfiyEmailViewState extends State<VerfiyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vervication Page')),
      body: Column(
        children: [
          const Text(
            "Please verify your email adreess",
            style: TextStyle(fontSize: 15),
          ),
          TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text(
                'Send email varification',
                style: TextStyle(fontSize: 30),
              ))
        ],
      ),
    );
  }
}
