enum SeatState {
  available,
  occupied,
  selected,
}

extension SeatStateExtension on SeatState {
  String get name {
    return [
      'Available',
      'Occupied',
      'Selected',
    ][index];
  }
}
