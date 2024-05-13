import 'package:bmi_demo/bmi_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultPage extends ConsumerWidget {
  final Function() callback;
  const ResultPage(this.callback, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bmiSettings = ref.watch(bmiSettingsProvider);
    final bmi =
        bmiSettings.weight / (bmiSettings.height * bmiSettings.height / 10000);
    return Placeholder(
      child: Column(
        children: [
          Text(bmi.toStringAsFixed(2)),
          FilledButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                Theme.of(context).colorScheme.secondary,
              ),
            ),
            onPressed: callback,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                "RECALCULATE",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
