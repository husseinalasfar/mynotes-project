import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constans/routes.dart';

class VerfiyEmailView extends StatefulWidget {
  const VerfiyEmailView({Key? key}) : super(key: key);

  @override
  State<VerfiyEmailView> createState() => _VerfiyEmailViewState();
}

class _VerfiyEmailViewState extends State<VerfiyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification Page')),
      body: Center(
        child: Column(
          children: [
            const Text(
              "Please verify your email adreess",
              style: TextStyle(fontSize: 25),
            ),
            TextButton(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                },
                child: const Text(
                  'Send email varification again',
                  style: TextStyle(fontSize: 15),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },
                child: const Text('Restart'))
          ],
        ),
      ),
    );
  }
}
