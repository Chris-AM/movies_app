import 'package:movies_app/domain/domain.dart';

import '../infrastructure.dart';

class VideoMapper {

  static moviedbVideoToEntity( Result moviedbVideo ) => VideoEntity(
    id: moviedbVideo.id, 
    name: moviedbVideo.name, 
    youTubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt
  );


}