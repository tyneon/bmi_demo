import 'package:flutter/material.dart';

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
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SexSelectors extends StatefulWidget {
  const SexSelectors({super.key});

  @override
  State<SexSelectors> createState() => _SexSelectorsState();
}

class _SexSelectorsState extends State<SexSelectors> {
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SexSelector(
          "Male",
          isSelected: isMale,
          callback: () {
            setState(() {
              isMale = true;
            });
          },
        ),
        SexSelector(
          "Female",
          isSelected: !isMale,
          callback: () {
            setState(() {
              isMale = false;
            });
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

class HeightSelector extends StatefulWidget {
  const HeightSelector({super.key});

  @override
  State<HeightSelector> createState() => _HeightSelectorState();
}

class _HeightSelectorState extends State<HeightSelector> {
  static const int minValue = 110;
  static int maxValue = 230;
  double sliderValue = 180;
  @override
  Widget build(BuildContext context) {
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
              setState(() {
                sliderValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class WeightSelector extends StatefulWidget {
  const WeightSelector({super.key});

  @override
  State<WeightSelector> createState() => _WeightSelectorState();
}

class _WeightSelectorState extends State<WeightSelector> {
  int specialIndex = 0;
  @override
  Widget build(BuildContext context) {
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
            child: ListWheelScrollView.useDelegate(
              diameterRatio: 0.9,
              itemExtent: height / 3.5,
              squeeze: 1.4,
              perspective: 0.009,
              onSelectedItemChanged: (index) {
                setState(() {
                  specialIndex = index;
                });
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: 200 - 35,
                builder: (context, index) => Text(
                  (index + 35).toString(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: index == specialIndex ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AgeSelector extends StatelessWidget {
  const AgeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Square(
      height: (MediaQuery.of(context).size.width -
              sidePadding * 2 -
              middlePadding) /
          2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "AGE",
          ),
          Text("Picker"),
        ],
      ),
    );
  }
}
