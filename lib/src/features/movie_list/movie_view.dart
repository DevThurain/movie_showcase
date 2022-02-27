import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_showcase/src/others/constants.dart';

class MovieView extends StatefulWidget {
  const MovieView({Key? key}) : super(key: key);

  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  late PageController _moviePageController;
  late PageController _moviePageDetailController;

  double _movieCardPage = 0.0;
  double _movieDetailPage = 0.0;
  int _movieCardIndex = 0;

  @override
  void initState() {
    super.initState();

    _moviePageController = PageController(viewportFraction: 0.77)
      ..addListener(_movieCardPageListener);
    _moviePageDetailController = PageController()..addListener(_movieDetailListener);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var w = constraints.maxWidth;
      var h = constraints.maxHeight;

      return Column(
        children: [
          Spacer(),
          SizedBox(
            height: h * 0.6,
            child: PageView.builder(
                controller: _moviePageController,
                clipBehavior: Clip.none,
                itemCount: Constants.movies.length,
                itemBuilder: ((context, index) {
                  final movie = Constants.movies[index];
                  final progress = (_movieCardPage - index);
                  final scale = lerpDouble(1, 0.8, progress.abs());
                  final isCurrentPage = index == _movieCardIndex;
                  final isFirstPage = index == 0;

                  return Transform.scale(
                    scale: scale,
                    alignment: Alignment.lerp(
                      Alignment.topLeft, 
                      Alignment.center, 
                        - progress,
                      ),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      transform: Matrix4.identity()..translate(
                        isCurrentPage ? 0.0 : -20.0,
                        isCurrentPage ? 0.0 : 60,
                        
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(movie), fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(70)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 25,
                                  offset: Offset(0, 25))
                            ]),
                      ),
                    ),
                  );
                })),
          ),
          Spacer(),
          SizedBox(
            height: h * 0.25,
          )
        ],
      );
    });
  }

  _movieCardPageListener() {
    setState(() {
      _movieCardPage = _moviePageController.page!;
      _movieCardIndex = _moviePageController.page!.round();
    });
  }

  _movieDetailListener() {
    setState(() {
      _movieDetailPage = _moviePageDetailController.page!;
      _movieCardIndex = _moviePageDetailController.page!.round();
    });
  }
}
