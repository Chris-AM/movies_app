import 'package:movies_app/domain/entities/entities.dart';
import 'package:movies_app/infrastructure/models/moviedb/moviedb_actors.dart';

class ActorMapper {
  static ActorEntity castToEntity(Cast cast) => ActorEntity(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://png.pngtree.com/element_our/sm/20180516/sm_5afc60f10326b.jpg',
        character: cast.character,
      );
}
