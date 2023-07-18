import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/infrastructure/infrastructure.dart';

class ActorMapper {
  static ActorEntity castToEntity(Cast cast) => ActorEntity(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh6kEMrF08V-ZxVYAP6fbG9_ox5beQA4SeOUK3jnEie420BDbkq7xgXOj2V44NtkxT4fk&usqp=CAU',
        character: cast.character,
      );
}
