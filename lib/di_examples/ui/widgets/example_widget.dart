import 'package:flutter/material.dart';
import 'package:themoviedb/di_examples/ui/widgets/example_view_model.dart';

class ExampleWidget extends StatelessWidget {
  final model = const ExampleViewModel();
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: model.onPressMe,
            child: const Text('Жми меня'),
          ),
        ),
      ),
    );
  }
}
