
import 'package:themoviedb/di_examples/factories/di_container.dart';

enum CalculatorServiceOperation{ sum }

class CalculatorService {
  final summator = ServiceLocator.instance.makeSummator();

  CalculatorService();
    int calculate(int a, int b, CalculatorServiceOperation operation) {
      if (operation == CalculatorServiceOperation.sum) {
        return summator.sum(a, b);
      } else {
        return 0;
      }
    }
}