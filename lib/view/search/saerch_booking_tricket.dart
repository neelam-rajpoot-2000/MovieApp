import 'package:flutter/material.dart';
import 'package:movie_book_app/model/movie_search_model.dart';
import 'package:movie_book_app/widgets/seat_Widgets.dart';
import 'search_booking_user_details.dart';

class SearchBookingTicket extends StatelessWidget {
  final MovieSearch movieSearch;
  SearchBookingTicket({super.key, required this.movieSearch});

  final selectedSeat = ValueNotifier<List<String>>([]);

  final selectedDate = ValueNotifier<DateTime>(DateTime.now());

  final selectedTime = ValueNotifier<TimeOfDay?>(null);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF260032),
        title: const Center(
          child: Text(
            'Select Seat',
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ValueListenableBuilder<List<String>>(
          valueListenable: selectedSeat,
          builder: (context, value, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  width: width * 0.8,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: const Text(
                    'Screen',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                for (int i = 1; i <= 6; i++) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int j = 1; j <= 8; j++) ...[
                        SeatWidget(
                          seatNumber: '${String.fromCharCode(i + 64)}$j',
                          isAvailable: i != 6,
                          isSelected: value
                              .contains('${String.fromCharCode(i + 64)}$j'),
                          onTap: () {
                            if (value
                                .contains('${String.fromCharCode(i + 64)}$j')) {
                              selectedSeat.value = List.from(value)
                                ..remove('${String.fromCharCode(i + 64)}$j');
                            } else {
                              selectedSeat.value = List.from(value)
                                ..add('${String.fromCharCode(i + 64)}$j');
                            }
                          },
                        ),
                        if (i != 8)
                          SizedBox(
                            width: j == 4 ? 16 : 4,
                          )
                      ]
                    ],
                  ),
                  if (i != 6)
                    const SizedBox(
                      height: 6,
                    ),
                ],
                SizedBox(
                  height: height * 0.05,
                ),
                const SeatInfoWidget(),
                const Expanded(
                  child: SizedBox(),
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(48)),
                      color: Colors.black12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 48, horizontal: 24),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Price",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const SizedBox(height: 16),
                                    ValueListenableBuilder<List<String>>(
                                      valueListenable: selectedSeat,
                                      builder: (context, value, _) {
                                        return Text(
                                          "\$${value.length * 100}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchUserDetails(
                                                  movieSearch: movieSearch,
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Book Now",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
