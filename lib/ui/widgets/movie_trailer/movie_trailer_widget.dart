import 'package:flutter/material.dart';

class MovieTrailerWidget extends StatefulWidget {
  final String youTubeKey;

  const MovieTrailerWidget({
    Key? key,
    required this.youTubeKey,
  }) : super(key: key);

  @override
  State<MovieTrailerWidget> createState() => _MovieTrailerWidgetState();
}

class _MovieTrailerWidgetState extends State<MovieTrailerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
