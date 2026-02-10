import 'dart:convert';
import 'package:flutter/material.dart';
import '../calc_engine.dart';
import 'package:flutter/services.dart' show rootBundle;

class CalculatorForm extends StatefulWidget {
  const CalculatorForm({super.key});

  @override
  State<CalculatorForm> createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {
  List<Map<String, String>> fields = [];
  List<Map<String, String>> results = [];
  final Map<String, TextEditingController> controllers = {};
  Map<String, double> resultValues = {};
  bool isLoading = true;
  String? loadError;

  @override
  void initState() {
    super.initState();
    loadConfig();
  }

  Future<void> loadConfig() async {
    try {
      final jsonString =
          await rootBundle.loadString('lib/config/breakeven_config.json');
      final jsonData = json.decode(jsonString);
      setState(() {
        fields = List<Map<String, String>>.from(jsonData['fields']);
        results = List<Map<String, String>>.from(jsonData['results']);
        for (var f in fields) {
          controllers[f['key']!] = TextEditingController();
        }
        isLoading = false;
        loadError = null;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        loadError = 'Failed to load calculator config.';
      });
    }
  }

  void calculate() {
    final inputMap = {
      for (var f in fields)
        f['key']!: double.tryParse(controllers[f['key']!]!.text) ?? 0
    };
    resultValues = CalcEngine.calculate(inputMap);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (loadError != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(loadError!),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  loadError = null;
                });
                loadConfig();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        ...fields.map((f) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: TextField(
                controller: controllers[f['key']!],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: f['label'],
                  border: const OutlineInputBorder(),
                ),
              ),
            )),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: calculate,
          child: const Text('Calculate'),
        ),
        const SizedBox(height: 16),
        ...results.map((r) {
          final val = resultValues[r['key']!] ?? 0;
          return Text(
            '${r['label']}: ${val.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          );
        })
      ],
    );
  }
}
