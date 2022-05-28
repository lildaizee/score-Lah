class Booking {
  final String userid;
  Booking({this.userid});
}

class BookingData {
  final String userid;
  final String selectedBookingdate;
  final String selectedHall;
  final String selectedCourt;
  final String selectedField;
  final String selectedSlot;

  BookingData(
      {this.userid,
      this.selectedBookingdate,
      this.selectedHall,
      this.selectedCourt,
      this.selectedField,
      this.selectedSlot});
}
