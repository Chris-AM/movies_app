import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PushToMovieHelper {
  static void pushToMovie(BuildContext context, {required String movieId}) {
    context.push('/home/0/movie/$movieId');
  }
}
