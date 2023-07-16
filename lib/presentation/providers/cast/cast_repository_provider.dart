import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/infrastructure/infrastructure.dart';

final castRepositoryProvider = Provider((ref) {
  return MovieDBCastRepositoryImpl(MovieDBActorsDataSource());
});
