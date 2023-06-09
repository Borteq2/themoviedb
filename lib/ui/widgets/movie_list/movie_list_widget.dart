import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_cubit.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<MovieListCubit>().setupLocale(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [_MovieListWidget(), _SearchWidget()],
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MovieListCubit>();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: cubit.searchMovie,
        decoration: InputDecoration(
          labelText: 'Поиск',
          filled: true,
          fillColor: Colors.white.withAlpha(235),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _MovieListWidget extends StatelessWidget {
  const _MovieListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MovieListCubit>();

    return ListView.builder(
      padding: const EdgeInsets.only(top: 70),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: cubit.state.movies.length,
      itemExtent: 163,
      itemBuilder: (BuildContext context, int index) {
        cubit.showMovieAtIndex(index);
        return _MovieListRow(index: index);
      },
    );
  }
}

class _MovieListRow extends StatelessWidget {
  final int index;

  const _MovieListRow({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MovieListCubit>();
    final movie = cubit.state.movies[index];
    final posterPath = movie.posterPath;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black.withOpacity(0.2),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2))
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                if (posterPath != null)
                  Image.network(
                    ImageDownloader.imageUrlList(posterPath),
                    width: 95,
                  ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        movie.releaseDate,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        movie.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              onTap: () => _onMovieTap(context, movie.id),
            ),
          ),
        ],
      ),
    );
  }

  void _onMovieTap(BuildContext context, int movieId) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: movieId,
    );
  }
}
