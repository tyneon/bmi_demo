import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bmi_demo/bmi_settings_provider.dart';

import 'package:bmi_demo/rectangles.dart';

const double sidePadding = 28;
const double middlePadding = 28;

class BmiCalculatorPage extends StatelessWidget {
  final Function() callback;
  const BmiCalculatorPage(this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: sidePadding, vertical: middlePadding),
      child: Column(
        children: [
          const SexSelectors(),
          const SizedBox(height: middlePadding),
          Rectangle(
            width: double.infinity,
            child: HeightSelector(),
          ),
          const SizedBox(height: middlePadding),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WeightSelector(),
              AgeSelector(),
            ],
          ),
          const SizedBox(height: middlePadding),
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
                "CALCULATE",
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

class SexSelectors extends ConsumerWidget {
  const SexSelectors({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMale = ref.watch(bmiSettingsProvider).isMale;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SexSelector(
          "Male",
          isSelected: isMale,
          callback: () {
            ref.read(bmiSettingsProvider.notifier).setIsMale(true);
          },
        ),
        SexSelector(
          "Female",
          isSelected: !isMale,
          callback: () {
            ref.read(bmiSettingsProvider.notifier).setIsMale(false);
          },
        ),
      ],
    );
  }
}

class SexSelector extends StatelessWidget {
  final bool isSelected;
  final String word;
  final Function() callback;
  const SexSelector(
    this.word, {
    required this.callback,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Square(
        height: (MediaQuery.of(context).size.width -
                sidePadding * 2 -
                middlePadding) /
            2,
        color: isSelected
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.onPrimary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              word[0],
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(word),
          ],
        ),
      ),
    );
  }
}

class HeightSelector extends ConsumerWidget {
  const HeightSelector({super.key});

  static const int minValue = 110;
  static int maxValue = 230;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double sliderValue = ref.watch(bmiSettingsProvider).height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const Text("HEIGHT"),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: sliderValue.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const TextSpan(
                  text: "cm",
                ),
              ],
            ),
          ),
          Slider(
            value: sliderValue,
            min: minValue.toDouble(),
            max: maxValue.toDouble(),
            divisions: maxValue - minValue,
            label: sliderValue.round().toString(),
            onChanged: (double value) {
              ref.read(bmiSettingsProvider.notifier).setHeight(value);
            },
          ),
        ],
      ),
    );
  }
}

class WeightSelector extends ConsumerWidget {
  const WeightSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weight = ref.watch(bmiSettingsProvider).weight;
    final height =
        (MediaQuery.of(context).size.width - sidePadding * 2 - middlePadding) /
            2;
    return Square(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text("WEIGHT"),
          Expanded(
            child: WheelSelector(
              height: height,
              initialValue: weight,
              startValue: 35,
              endValue: 200,
              newValueCallback: (double value) {
                ref.read(bmiSettingsProvider.notifier).setWeight(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AgeSelector extends ConsumerWidget {
  const AgeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final age = ref.watch(bmiSettingsProvider).age;
    final height =
        (MediaQuery.of(context).size.width - sidePadding * 2 - middlePadding) /
            2;
    return Square(
      height: (MediaQuery.of(context).size.width -
              sidePadding * 2 -
              middlePadding) /
          2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text("AGE"),
          Expanded(
            child: WheelSelector(
              height: height,
              startValue: 16,
              endValue: 115,
              initialValue: age,
              newValueCallback: (double value) {
                ref.read(bmiSettingsProvider.notifier).setAge(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WheelSelector extends StatefulWidget {
  final double initialValue;
  final double height;
  final double startValue;
  final double endValue;
  final double step;
  final int precision;
  final Function(double value) newValueCallback;
  const WheelSelector({
    required this.height,
    required this.startValue,
    required this.endValue,
    required this.initialValue,
    this.step = 1,
    this.precision = 0,
    required this.newValueCallback,
    super.key,
  });

  @override
  State<WheelSelector> createState() => _WheelSelectorState();
}

class _WheelSelectorState extends State<WheelSelector> {
  int selectedIndex = 0;
  late int itemCount;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    itemCount =
        ((widget.endValue - widget.startValue) / widget.step).floor().toInt() +
            1;
    selectedIndex = ((widget.initialValue - widget.startValue) / widget.step)
        .floor()
        .toInt();
    controller = ScrollController(
        initialScrollOffset: widget.height / 3.5 * selectedIndex);
    controller.addListener(() {
      final index = ((controller.offset * itemCount) /
              controller.position.maxScrollExtent)
          .floor()
          .toInt();
      if (index != selectedIndex) {
        selectedIndex = index;
        widget
            .newValueCallback(widget.startValue + widget.step * selectedIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      diameterRatio: 0.9,
      itemExtent: widget.height / 3.5,
      squeeze: 1.4,
      perspective: 0.009,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: itemCount,
        builder: (context, index) => Text(
          (widget.startValue + index * widget.step)
              .toStringAsFixed(widget.precision),
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            // color: index == selectedIndex ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
