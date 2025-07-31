import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const PayslipApp());
}

class PayslipApp extends StatelessWidget {
  const PayslipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payslip Generator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}
