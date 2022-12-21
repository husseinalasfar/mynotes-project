import 'package:flutter/material.dart';
import 'package:mynotes/utilites/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log out',
    content: 'Are you sure you want to Log out?',
    optionsBuilder: () => {
      'No, cancel': false,
      'Yes, log out': true,
    },
  ).then((value) => value ?? false);
}
