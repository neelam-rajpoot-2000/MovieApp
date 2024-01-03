import 'package:flutter/material.dart';
import 'package:movie_book_app/model/movie_search_model.dart';

import '../../model/movie.dart';
import '../../widgets/constant.dart';
import '../../widgets/round_button.dart';
import 'saerch_booking_tricket.dart';

class SearchDetailScreen extends StatelessWidget {
  final MovieSearch movieSearch;
  const SearchDetailScreen({super.key, required this.movieSearch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar.large(
          leading: Container(
            height: 70,
            width: 70,
            margin: const EdgeInsets.only(top: 8, left: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          expandedHeight: 550,
          pinned: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
            title: Text(
              movieSearch.title!,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            background: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
              child: Image.network(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                  '${Constant.imagePath}${movieSearch.backdropPath}'),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Text(
                  'Overview',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  movieSearch.overview!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Release date: ',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            movieSearch.releaseDate!,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Rating: ',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.star,color: Colors.amber,size: 20,
                          ),
                          Text(
                            '${movieSearch.voteAverage!.toStringAsFixed(1)}/10',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                   const SizedBox(height: 15,),
                RoundButton(
                title: 'Booking',
               
                onTap: () {
                    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>SearchBookingTicket( movieSearch: movieSearch,) ));
                },
              ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
