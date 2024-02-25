import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_book_app/view/search/search_deatail_screeen.dart';
import '../../model/movie_search_model.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/constant.dart';

class ScreenScreen extends StatefulWidget {
  const ScreenScreen({super.key});

  @override
  State<ScreenScreen> createState() => _ScreenScreenState();
}

class _ScreenScreenState extends State<ScreenScreen> {
  late Future<List<MovieSearch>> movieSearchList;
  static List<MovieSearch> listdata = [];
  List<MovieSearch> displayList = List.from(listdata);

  static const _movieSearchListUrl =
      'https://api.themoviedb.org/3/search/movie?api_key=6b692b63427c54c00336888a46c856b5&language=en-US&query=Friends%3A%20The%20Reunion&page=1';

  @override
  void initState() {
    
    movieSearchList = getSearchMovies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF260032),
        title: const Center(
          child: Text('Search        '),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search for a Movie',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) => _runFilter(value),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurple,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  hintText: "eg: The Dark knight",
                  prefixIcon: const Icon(Icons.search)),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child:
                 displayList.isEmpty
                    ? const Text(
                        'Data not found',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    : 
                    ListView.builder(
                        itemCount: displayList.length,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchDetailScreen(
                            movieSearch: displayList[index],
                          )));
            },
                            child: ListTile(
                              title: Text(
                                displayList[index].title!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                displayList[index].releaseDate!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Row(
                                 mainAxisSize: MainAxisSize.min,
                                children: [
                                   const Icon(Icons.star,color: Colors.amber,
                            ),
                                  Text(
                                    displayList[index]
                                        .voteAverage!
                                        .toStringAsFixed(1),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              leading: SizedBox(
                                  height: 55,
                                  width: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.fill,
                                        '${Constant.imagePath}${displayList[index].posterPath}'),
                                  )),
                            ),
                          );
                        }))
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              const Color(0xFF260032), // Set the background color to black
        ),
        child: CustomBottomNavigationBar(
          currentIndex: 1,
          onTap: (index) {
            CustomBottomNavigationBar.onItemTapped(context, index);
          },
        ),
      ),
    );
  }

  _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      displayList = listdata;
    } else {
    setState(() {
      displayList = listdata
          .where((element) => element.title!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    });
   }
  }

  Future<List<MovieSearch>> getSearchMovies() async {
    final response = await http.get(Uri.parse(_movieSearchListUrl));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body)['results'];
  print('result search--------->$result');
      var list = result as List;
      listdata = list.map((e) => MovieSearch.fromJson(e)).toList();
      print('result search--------->$listdata');
      // movieResultList.addAll(listdata);
      return listdata;
    } else {
      throw Exception('Something want happened');
    }
  }
}
