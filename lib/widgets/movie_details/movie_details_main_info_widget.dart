import 'package:flutter/material.dart';
import 'package:themoviedb/resources/resources.dart';

import '../user_rate_widget.dart';

class MovieDetailsMainInfo extends StatelessWidget {
  const MovieDetailsMainInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _TopPosterWidget(),
        Padding(
          padding: EdgeInsets.all(30.0),
          child: _MovieNameWidget(),
        ),
        _ScoreWidget(),
        _SummaryWidget(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: _OverwierWidget(),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: _DesctiptionWidget(),
        ),
        SizedBox(height: 30),
        _PeopleWidget(),
      ],
    );
  }
}

class _DesctiptionWidget extends StatelessWidget {
  const _DesctiptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Коллеги и жена Джона Келли убиты. Чудом оставшийся в живых мужчина'
      ' решает найти преступников и отомстить.',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class _OverwierWidget extends StatelessWidget {
  const _OverwierWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Обзор',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const nameStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );

    const jobTitleStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Stefano Sollima', style: nameStyle),
                  Text('Director', style: jobTitleStyle),
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Taylor Sheridan', style: nameStyle),
                  Text('Screenplay', style: jobTitleStyle),
                ]),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Tom Clancy', style: nameStyle),
                  Text('Novel', style: jobTitleStyle),
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Will Staples', style: nameStyle),
                  Text('Screenplay', style: jobTitleStyle),
                ]),
          ],
        ),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      textAlign: TextAlign.center,
      text: const TextSpan(children: [
        TextSpan(
          text: 'Tom Clancy`s Without Remorse',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
        TextSpan(
          text: ' (2021)',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 17,
          ),
        ),
      ]),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 40,
              child: RadialPercentWidget(
                percent: 0.7,
                fillColor: Color.fromARGB(255, 10, 23, 25),
                lineColor: Color.fromARGB(255, 37, 203, 103),
                freeColor: Color.fromARGB(255, 25, 54, 31),
                lineWidth: 3,
                child: Text(
                  '70%',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Рейтинг',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ],
        ),
        Container(
          width: 1,
          height: 15,
          color: Colors.grey,
        ),
        Row(
          children: [
            const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Трейлер',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Image(image: AssetImage(AppImages.topHeader)),
        Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: Image(image: AssetImage(AppImages.topheaderSubImage))),
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: Text(
          'R 29/04/2021 (US) 1ч49м приключения, боевик, триллер, военный',
          maxLines: 3,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
      ),
    );
  }
}
