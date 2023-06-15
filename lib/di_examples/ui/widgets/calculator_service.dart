
import 'package:themoviedb/di_examples/ui/widgets/summator.dart';

enum CalculatorServiceOperation{
  sum
}

class CalculatorService {
  final summator = const Summator();
  const CalculatorService();
    int calculate(int a, int b, CalculatorServiceOperation operation) {
      if (operation == CalculatorServiceOperation.sum) {
        return a + b;
      } else {
        return 0;
      }
    }
}