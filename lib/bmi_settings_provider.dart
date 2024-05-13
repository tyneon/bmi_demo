import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bmi_settings_provider.g.dart';

@Riverpod(keepAlive: true)
class BmiSettings extends _$BmiSettings {
  @override
  BmiValues build() => const BmiValues(true, 180, 70, 25);

  void setIsMale(bool value) {
    state = BmiValues(value, state.height, state.weight, state.age);
  }

  void setHeight(double value) {
    state = BmiValues(state.isMale, value, state.weight, state.age);
  }

  void setWeight(double value) {
    state = BmiValues(state.isMale, state.height, value, state.age);
  }

  void setAge(double value) {
    state = BmiValues(state.isMale, state.height, state.weight, value);
  }
}

class BmiValues {
  final bool isMale;
  final double height;
  final double weight;
  final double age;
  const BmiValues(
    this.isMale,
    this.height,
    this.weight,
    this.age,
  );
}
