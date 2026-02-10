import 'package:flutter/material.dart';
import 'ui/calculator_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breakeven Calculator',
      home: Scaffold(
        appBar: AppBar(title: const Text('Breakeven Calculator')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: CalculatorForm(),
        ),
      ),
    );
  }
}
