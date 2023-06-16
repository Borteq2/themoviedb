import 'package:themoviedb/di_examples/factories/di_container.dart';
import 'package:themoviedb/di_examples/ui/widgets/calculator_service.dart';
import 'package:themoviedb/di_examples/ui/widgets/example_widget.dart';

class ExampleCalcViewModel implements ExampleViewModel {
  final calculatorService = ServiceLocator.instance.makeCalculatorService();
  ExampleCalcViewModel();


  @override
  void onPressMe() {
    final result = calculatorService.calculate(
      1,
      2,
      CalculatorServiceOperation.sum,
    );
    print(result);
  }

  @override
  void onPressMe2() {
    final result = calculatorService.calculate(
      1,
      2,
      CalculatorServiceOperation.sum,
    );
    print('5');
  }
}

class ExamplePetViewModel implements ExampleViewModel {
  const ExamplePetViewModel();

  @override
  void onPressMe() {
    print('гав гав');
  }

  @override
  void onPressMe2() {
    print('мяу мяу');
  }
}
