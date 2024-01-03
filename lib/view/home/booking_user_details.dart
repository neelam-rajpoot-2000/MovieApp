import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_book_app/model/movie_search_model.dart';

import '../../model/booking_model.dart';
import '../../model/movie.dart';
import '../../widgets/round_button.dart';
import 'movie_list.dart';

class UserDetails extends StatefulWidget {
  final Movie movie;

  const UserDetails({super.key, required this.movie});
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  List<Booking> bookings = [];
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final noController = TextEditingController();
  final idController = TextEditingController();
  final titleController = TextEditingController();
  late TextEditingController dateController = TextEditingController();
  final _formField = GlobalKey<FormState>();

  void initState() {
    super.initState();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  void _showDuplicateWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text(
              'Another user has already booked tickets for the same date/time slot.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MoviesList()));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessfullyBooking() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Booked'),
          actions: [
            TextButton(
              onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MoviesList()));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _processBooking() {
    // Check for duplicate bookings
    DateTime selectedDateTime = DateTime.parse(dateController.text).toLocal();

    bool hasDuplicate = bookings.any(
        (booking) => booking.dateTimeSlot.isAtSameMomentAs(selectedDateTime));

    if (hasDuplicate) {
      // Show a warning popup
      _showDuplicateWarning();
    } else {
      // Save booking to the database
      Booking newBooking = Booking(
        customerName: nameController.text, // Get data from form fields
        customerEmail: emailController.text,
        customerContactNo: noController.text,
        movieTitle: widget.movie.title,
        numOfTickets: 0, // Get data from form fields
        dateTimeSlot: selectedDateTime,
      );

      bookings.add(newBooking);
      _showSuccessfullyBooking();
      
      // Optionally, you can navigate to a confirmation page or show a success message.
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
      
        backgroundColor: const Color(0xFF260032),
        title: const Center(
          child: Text('User Details       '),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
          child: Column(
            children: [
              Form(
                key: _formField,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: const InputDecoration(
                          hintText: 'Name', prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: idController,
                      decoration: const InputDecoration(
                          hintText: 'Id',
                          prefixIcon: Icon(Icons.person_pin_circle)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: noController,
                      decoration: const InputDecoration(
                          hintText: 'Mobile Number',
                          prefixIcon: Icon(Icons.phone)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Mobile Number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    widget.movie.title == null
                        ? TextFormField(
                            keyboardType: TextInputType.number,
                            controller: titleController,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.movie_creation_outlined)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "${widget.movie.title}";
                              }
                              return null;
                            },
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.movie_creation_outlined),
                                    Text(
                                      "   ${widget.movie.title}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.black45,
                                thickness: 1,
                              )
                            ],
                          ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                          hintText: 'Date/Time Slot',
                          prefixIcon: Icon(Icons.lock_clock)),
                      controller: dateController,
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
        
                        if (picked != null) {
                          TimeOfDay? timePicked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
        
                          if (timePicked != null) {
                            DateTime selectedDateTime = DateTime(
                              picked.year,
                              picked.month,
                              picked.day,
                              timePicked.hour,
                              timePicked.minute,
                            );
                            dateController.text =
                                selectedDateTime.toLocal().toString();
                          }
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a date/time slot';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
          SizedBox(height: 30,),
              RoundButton(
                title: 'Done',
                onTap: () {
                  if (_formField.currentState!.validate()) {
                    // Validate successful, process the booking
                    _processBooking();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
