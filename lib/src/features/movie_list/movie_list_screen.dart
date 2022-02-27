import 'package:flutter/material.dart';
import 'package:movie_showcase/src/features/movie_list/movie_view.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(
              text: "Movies",
            ),
            Tab(
              text: "Series",
            ),
            Tab(
              text: "Show",
            )
          ],
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [SizedBox.expand(), MovieView(), SizedBox.expand()]),
    );
  }


}
