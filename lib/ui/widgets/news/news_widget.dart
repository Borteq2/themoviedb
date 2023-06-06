import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('news widget'),
              ElevatedButton(
                onPressed: () {},
                child: const Text('news button'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
