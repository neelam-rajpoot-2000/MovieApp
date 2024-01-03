import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_book_app/model/movie.dart';
import 'package:movie_book_app/ui/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:movie_book_app/view/home/detail_screen.dart';
import '../../ui/auth/login_screen.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/constant.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({super.key});

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  double height = 0.0;
  double width = 0.0;
  late Future<List<Movie>> movieResultList;
  static const _movieListUrl =
      'https://api.themoviedb.org/3/movie/popular?language=en-US&Page=1&api_key=6b692b63427c54c00336888a46c856b5';

  @override
  void initState() {
    movieResultList = getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF260032),
        title: const Center(
          child: Text('Cinema'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Trending Movies',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FutureBuilder(
                future: movieResultList,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Data not found'),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    return tendingMovieListData(snapshot);
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ));
                  }
                },
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Top Rated Movies',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FutureBuilder(
                future: movieResultList,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Data not found'),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    return topRatedMoviesList(snapshot);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              const Color(0xFF260032), // Set the background color to black
        ),
        child: CustomBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            CustomBottomNavigationBar.onItemTapped(context, index);
          },
        ),
      ),
    );
  }

  topRatedMoviesList(AsyncSnapshot snapshot) {
    return SizedBox(
      height: height * 0.4,
      child: ListView.builder(
        itemCount: snapshot.data.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            movie: snapshot.data[index],
                          )));
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              height: height * 0.4,
              width: width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        '${Constant.imagePath}${snapshot.data[index].posterPath}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      height: height * 0.03,
                      child: Text(
                        snapshot.data[index].title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 10,
                      ),
                      Text(
                        '${snapshot.data[index].voteAverage.toStringAsFixed(1)}',
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Text(
                    '${snapshot.data[index].releaseDate}',
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  tendingMovieListData(AsyncSnapshot snapshot) {
    return CarouselSlider.builder(
      itemCount: snapshot.data.length,
      options: CarouselOptions(
          height: height * 0.4,
          autoPlay: true,
          viewportFraction: 0.55,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          enlargeCenterPage: true,
          pageSnapping: true),
      itemBuilder: (context, itemIndex, pageViewIndex) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                          movie: snapshot.data[itemIndex],
                        )));
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                  height: height * 0.4,
                  width: width * 0.6,
                  child: Image.network(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      '${Constant.imagePath}${snapshot.data[itemIndex].posterPath}'))),
        );
      },
    );
  }

  Future<List<Movie>> getMovies() async {
    final response = await http.get(Uri.parse(_movieListUrl));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body)['results'];
      print('result--------->$result');
      var list = result as List;
      var listdata = list.map((e) => Movie.fromJson(e)).toList();
      // movieResultList.addAll(listdata);
      return listdata;
    } else {
      throw Exception('Something want happened');
    }
  }
}
