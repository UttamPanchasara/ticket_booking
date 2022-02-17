import 'package:booking_app/ui/seatselection/helper/model/seat_info.dart';

abstract class SeatSelectionEvent {}

class SelectSeatEvent extends SeatSelectionEvent {
  final SeatRows? updatedSeats;

  SelectSeatEvent({required this.updatedSeats});
}

class GetSeatsEvent extends SeatSelectionEvent {
  GetSeatsEvent();
}
