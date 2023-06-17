

import 'package:get_it/get_it.dart';
import 'package:themoviedb/di_examples/ui/widgets/summator.dart';

enum CalculatorServiceOperation{ sum }

class CalculatorService {
  final summator = GetIt.I<Summator>();

  CalculatorService();
    int calculate(int a, int b, CalculatorServiceOperation operation) {
      if (operation == CalculatorServiceOperation.sum) {
        return summator.sum(a, b);
      } else {
        return 0;
      }
    }
}