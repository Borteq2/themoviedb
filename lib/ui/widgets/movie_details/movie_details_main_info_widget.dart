import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/navigation/main_navigation_route_names.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/user_rate_widget.dart';


class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopPosterWidget(),
        Padding(
          padding: EdgeInsets.all(30.0),
          child: _MovieNameWidget(),
        ),
        _ScoreWidget(),
        _SummaryWidget(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: _OverviewWidget(),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: _DescriptionWidget(),
        ),
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: _PeopleWidget(),
        ),
      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final overview =
        context.select((MovieDetailsModel model) => model.data.overview);

    return Text(
      overview,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Overview',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = context.select((MovieDetailsModel model) => model.data.nameData);

    return Center(
      child: RichText(
        maxLines: 3,
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: data.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
          TextSpan(
            text: data.year,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 17,
            ),
          ),
        ]),
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scoreData =
        context.select((MovieDetailsModel model) => model.data.scoreData);
    final trailerKey = scoreData.trailerKey;

    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Row(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: RadialPercentWidget(
              percent: scoreData.voteAverage / 100,
              fillColor: const Color.fromARGB(255, 10, 23, 25),
              lineColor: const Color.fromARGB(255, 37, 203, 103),
              freeColor: const Color.fromARGB(255, 25, 54, 31),
              lineWidth: 3,
              child: Text(
                scoreData.voteAverage.toStringAsFixed(0),
                style: const TextStyle(
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
            ),
          ),
        ],
      ),
      Container(
        width: 1,
        height: 15,
        color: Colors.grey,
      ),
      if (trailerKey != null)
        TextButton(
          onPressed: () {},
          child: Row(children: [
            const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(
                MainNavigationRouteNames.movieTrailerWidget,
                arguments: trailerKey,
              ),
              child: const Text(
                'Play Trailer',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ]),
        ),
    ]);
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieDetailsModel>();
    var posterData =
        context.select((MovieDetailsModel model) => model.data.posterData);
    final backdropPath = posterData.backdropPath;
    final posterPath = posterData.posterPath;

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          if (backdropPath != null)
            Image.network(ImageDownloader.imageUrlBackdrop(backdropPath)),
          if (posterPath != null)
            Positioned(
              top: 20,
              left: 20,
              bottom: 20,
              child: Image.network(ImageDownloader.imageUrlPoster(posterPath)),
            ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () => model.toggleFavorite(context),
              icon: Icon(posterData.favoriteIcon),
            ),
          )
        ],
      ),
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final summary =
        context.select((MovieDetailsModel model) => model.data.summary);

    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          summary,
          maxLines: 3,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
      ),
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var crew =
        context.select((MovieDetailsModel model) => model.data.peopleData);
    if (crew.isEmpty) return SizedBox.shrink();
    return Column(
        children: crew
            .map(
              (chunk) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _PeopleWidgetRow(employes: chunk),
              ),
            )
            .toList());
  }
}

class _PeopleWidgetRow extends StatelessWidget {
  final List<MovieDetailsMoviePeopleData> employes;

  const _PeopleWidgetRow({
    Key? key,
    required this.employes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: employes
          .map((employee) => _PeopleWidgetsRowItem(employee: employee))
          .toList(),
    );
  }
}

class _PeopleWidgetsRowItem extends StatelessWidget {
  final MovieDetailsMoviePeopleData employee;

  const _PeopleWidgetsRowItem({
    Key? key,
    required this.employee,
  }) : super(key: key);

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

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(employee.name, style: nameStyle),
          Text(employee.job, style: jobTitleStyle),
        ],
      ),
    );
  }
}
