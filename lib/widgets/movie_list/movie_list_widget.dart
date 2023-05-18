import 'package:flutter/material.dart';
import '../../resources/resources.dart';

class Movie {
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie({
    required this.imageName,
    required this.title,
    required this.time,
    required this.description,
  });
}

class MovieListWidget extends StatefulWidget {

  MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
      imageName: AppImages.man,
      title: 'Бессмертный',
      time: 'May 15, 2023',
      description:
          'Понял, вы хотите узнать, как использовать контекстные действия (context actions) в Android Studio для проекта Flutter. Контекстные действия представляют собой быстры',
    ),
    Movie(
      imageName: AppImages.man,
      title: 'Жухлая яшперица',
      time: 'May 5, 2013',
      description:
          'В приведенном примере класс MyClass имеет два поля: name и age, объявленные с ключевым словом final. Конструктор класса MyClass использует фигурные скобки ',
    ),
    Movie(
      imageName: AppImages.man,
      title: 'Огурцы',
      time: 'May 1, 2003',
      description:
          'Таким образом, использование фигурных скобок и ключевого слова required в конструкторе класса позволяет создать именные и обязательные параметры, которые будут передаваться при создании экземпляра класса.',
    ),
    Movie(
      imageName: AppImages.man,
      title: 'Акулоторнадо',
      time: 'May 9, 1999',
      description:
          'Генерация кода: Вы можете использовать контекстные действия для быстрой генерации кода. Например, если вы находитесь внутри класса и х',
    ),
    Movie(
      imageName: AppImages.man,
      title: 'Плейсхолдер',
      time: 'May 18, 2023',
      description:
          'Вот пример кода, показывающий, как сделать именные и обязательные параметры в конструкторе класса:',
    ),
  ];
  var _filteredMovies = <Movie>[];

  final _searchController = TextEditingController();

  void _searchMovies() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }

  @override
  void initState() {
    _filteredMovies = _movies;
    _searchController.addListener(_searchMovies);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            padding: EdgeInsets.only(top: 70),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: _filteredMovies.length,
            itemExtent: 163,
            itemBuilder: (BuildContext context, int index) {
              final movie = _filteredMovies[index];

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
                          Image(image: AssetImage(movie.imageName)),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                  movie.time,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  movie.description,
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
                        onTap: () {
                          print('11');
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Поиск',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: OutlineInputBorder(),
            ),
          ),
        )
      ],
    );
  }
}
