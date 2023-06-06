import 'package:themoviedb/configuration/configuration.dart';

class ImageDownloader {
  static String imageUrlBackdrop(String path) =>
      Configuration.imageUrlBackdrop + path;

  static String imageUrlPoster(String path) =>
      Configuration.imageUrlPoster + path;

  static String imageUrlList(String path) => Configuration.imageUrlList + path;

  static String imageUrlProfile(String path) =>
      Configuration.imageUrlProfile + path;
}
