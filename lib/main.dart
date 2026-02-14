import 'package:flutter/material.dart';
import 'package:securitycheck/Pass.dart';

import 'Pass.dart';

void main() {
  runApp(const PasswordCheckerApp());
}

class PasswordCheckerApp extends StatelessWidget {
  const PasswordCheckerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Security Analyzer',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const Pass(),
    );
  }
}

