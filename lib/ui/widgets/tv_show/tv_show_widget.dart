import 'package:flutter/material.dart';

class TvShowWidget extends StatelessWidget {
  const TvShowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('tv_show widget'),
              ElevatedButton(
                onPressed: () {},
                child: const Text('tv_show button'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
