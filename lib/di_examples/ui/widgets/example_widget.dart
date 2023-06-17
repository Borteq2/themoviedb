import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/di_examples/factories/di_container.dart';

abstract class ExampleViewModel {
  void onPressMe();
  void onPressMe2();
}

class ExampleWidget extends StatelessWidget {
  // final ExampleViewModel model = ServiceLocator.instance.makeExampleViewModel();

  const ExampleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GetIt.I<ExampleViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: model.onPressMe,
                child: const Text('Жми меня'),
              ),
              ElevatedButton(
                onPressed: model.onPressMe2,
                child: const Text('Жми меня 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
