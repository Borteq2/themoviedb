import 'package:themoviedb/di_examples/ui/widgets/calculator_service.dart';

class ExampleViewModel {
  final calculatorService = const CalculatorService();

  const ExampleViewModel();

  void onPressMe() {
    final result = calculatorService.calculate(
      1,
      2,
      CalculatorServiceOperation.sum,
    );
    print(result);
  }
}
