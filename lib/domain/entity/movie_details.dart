import 'package:json_annotation/json_annotation.dart';

part 'movie_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetails {
  final bool adult;
  final String? backdropPath;
  final String? belongsToCollection;
  final int budget;
  final List<Genres> genres;
  final String homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final int popularity;
  final String? posterPath;
  final List<ProductionCompanies> productionCompanies;
  final List<ProductionCountries> productionCountries;
  final String releaseDate;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguages> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final double voteCount;

  const MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genres {
  final int id;
  final String name;

  Genres({
    required this.id,
    required this.name,
  });

}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompanies {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompanies({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountries {
  @JsonKey(name: 'iso6391')
  final String iso;
  final String name;

  ProductionCountries({required this.iso, required this.name});
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguages {
  @JsonKey(name: 'iso6391')
  final String iso;
  final String name;

  SpokenLanguages({required this.iso, required this.name});
}
