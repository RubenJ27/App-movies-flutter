import 'package:logger/logger.dart';

abstract class BaseRepository {
  final Logger logger = Logger();

  void handleError(dynamic e, StackTrace stackTrace) {
    logger.e('Error: $e', error: e, stackTrace: stackTrace);
  }
}
