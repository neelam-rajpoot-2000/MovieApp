// booking_model.dart

class Booking {
  String customerName;
  String customerEmail;
  String customerContactNo;
  String movieTitle;
  int numOfTickets;
  DateTime dateTimeSlot;

  Booking({
    required this.customerName,
    required this.customerEmail,
    required this.customerContactNo,
    required this.movieTitle,
    required this.numOfTickets,
    required this.dateTimeSlot,
  });
}
