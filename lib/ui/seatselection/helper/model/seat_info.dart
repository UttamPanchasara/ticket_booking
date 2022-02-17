import 'package:booking_app/common/enums.dart';

class SeatRows {
  Map<int, List<SeatInfo>> rows;

  SeatRows({required this.rows});
}

class SeatInfo {
  String? seatNo;
  String? rowName;
  int? memberId;
  SeatState? seatState;

  SeatInfo({
    this.seatState,
    this.seatNo,
    this.rowName,
    this.memberId,
  });

  bool isBooked() {
    return seatState == SeatState.occupied;
  }

  bool isAvailable() {
    return seatState == SeatState.available;
  }
}
