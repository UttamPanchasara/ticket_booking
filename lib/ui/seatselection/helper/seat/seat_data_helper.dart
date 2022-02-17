import 'package:booking_app/common/enums.dart';
import 'package:booking_app/data/repo/entities/family_data.dart';
import 'package:booking_app/ui/seatselection/helper/model/seat_info.dart';
import 'package:booking_app/utils/app_utils.dart';

/// Singleton Helper,
/// Responsible to provide seats data
class SeatDataHelper {
  SeatDataHelper._privateConstructor();

  static final SeatDataHelper instance = SeatDataHelper._privateConstructor();

  // To get the Seat Layout data,
  SeatRows getSeatsStructure() {
    Map<int, List<SeatInfo>> rows = <int, List<SeatInfo>>{};
    for (int i = 1; i < 6; i++) {
      String rowName = _getPrefix(i);
      List<SeatInfo> seatList = [];
      for (int j = 1; j < 6; j++) {
        String seatNo = '$rowName$j';
        seatList.add(SeatInfo(
            seatState: SeatState.available, seatNo: seatNo, rowName: rowName));
      }

      rows[i] = seatList;
    }
    return SeatRows(rows: rows);
  }

  // To get the Seat Layout data with pre-booked(occupied) indication
  SeatRows? prepareSeatsStructure({
    required List<Members> members,
    required SeatRows? seatsRows,
  }) {
    if (members.isEmpty) return seatsRows;

    Map<String?, Members> membersMap = _getBookedMembersMap(members);

    seatsRows?.rows.forEach((key, value) {
      value.map((element) {
        if (membersMap.keys.contains(element.seatNo)) {
          Members? member = membersMap[element.seatNo];
          element
            ..seatState = SeatState.occupied
            ..memberId = member?.id;
        }

        return element;
      }).toList();
    });

    return seatsRows;
  }

  // Helper method to convert list into key, value pair,
  // To perform faster search operation
  Map<String?, Members> _getBookedMembersMap(List<Members> members) {
    Map<String?, Members> membersMap = {};
    for (var element in members) {
      membersMap[element.seatNo] = element;
    }
    return membersMap;
  }

  // To Invalidate Seat Selection,
  // To Perform Seat selection operation based on user Action
  SeatRows validateSeatSelection(
      {required SeatRows seatRows,
      required SeatInfo seat,
      required selectedSeatsList,
      required totalRequiredSeats}) {
    // Clear previous selection
    selectedSeatsList.clear();
    // Holds total available seats count
    int availableSeats = 0;
    // Reset all seats state(Available)
    seatRows.rows.forEach((key, value) {
      value
          .where((element) => element.seatState != SeatState.occupied)
          .map((e) {
        availableSeats += 1;
        return e..seatState = SeatState.available;
      }).toList();
    });

    if (availableSeats < totalRequiredSeats) {
      /// We are here means,
      /// Total required seats are greater than available
      /// Hence, display toast message
      AppUtils.instance.showToast('Required numbers of seats not available');
    } else {
      /// We are here means,
      /// Total required seats are available

      // Current Selected Row Number
      int currRowIndex = _getRowNo(seat.rowName);

      // Current Selected Seat Index
      int selectedSeatIndex = _getSeatIndex(seat.seatNo);
      int currSeatIndex = selectedSeatIndex;

      // Current Select Row
      List<SeatInfo> seatsList = seatRows.rows[currRowIndex] ?? [];

      // Horizontally available Indexes (Columns),
      // This is to remember what indexes we checked/updated
      List<int> columnsIndexes = _getIndexesList();

      // Vertically available Indexes (Rows)
      // This is to remember what indexes we checked/updated
      List<int> rowsIndexes = _getIndexesList();

      do {
        if (currSeatIndex > 0 && seatsList.isNotEmpty) {
          // Attempt to update currentIndex seat in current-row
          int seatIndex = currSeatIndex - 1;
          SeatInfo seatInfo = seatsList[seatIndex];
          if (seatInfo.seatState != SeatState.occupied) {
            var updatedInfo = seatInfo..seatState = SeatState.selected;
            seatsList[seatIndex] = updatedInfo;
            // Decrease total seat counts,
            // As we required to select
            totalRequiredSeats -= 1;
            // Adding selected seat info to List
            selectedSeatsList.add(updatedInfo);
            seatRows.rows[currRowIndex] = seatsList;
          }

          // Check in same row for next index
          int? nextIndex = _getNextIndex(columnsIndexes, currSeatIndex);
          if (nextIndex != null) {
            currSeatIndex = nextIndex;
          } else {
            /// We are here means,
            /// No seats available in same row
            /// Hence, Moving to nearest row

            // Reset seat index
            currSeatIndex = selectedSeatIndex;

            // Check in for next row index
            int? nextIndex = _getNextIndex(rowsIndexes, currRowIndex);
            if (nextIndex != null) {
              currRowIndex = nextIndex;
              // Updating, SeatRow Data with new rowIndex
              seatsList = seatRows.rows[currRowIndex] ?? [];
              // Fill the column indexes for new row
              columnsIndexes = _getIndexesList();
            } else {
              /// We are here means,
              /// No seats available in any rows
              /// Hence, will clear the whatever selection we have
              selectedSeatsList.clear();

              AppUtils.instance
                  .showToast('Required numbers of seats not available');
              break;
            }
          }
          continue;
        }
        break;
      } while (totalRequiredSeats > 0);
    }

    return seatRows;
  }

  // Returns Row Character from Index
  String _getPrefix(int position) {
    //Ansi code alphabet(A)
    int defaultAnsiCode = 65;

    //position - 1; As we're starting list index from 1 instead 0
    return String.fromCharCode(defaultAnsiCode + (position - 1));
  }

  // Returns Row Index from Char
  int _getRowNo(String? rowName) {
    //Ansi code alphabet(A)
    int defaultAnsiCode = 65;
    int? ansiCode = rowName?.codeUnitAt(0);
    return ((ansiCode ?? 0) - defaultAnsiCode) + 1;
  }

  // Returns Seat index from String seat-no
  int _getSeatIndex(String? seatNo) {
    if (seatNo != null) {
      return int.parse(seatNo.substring(1, seatNo.length));
    }
    return 0;
  }

  // Indexes list, to iterate rows/columns in order to select seats
  List<int> _getIndexesList() {
    return [1, 2, 3, 4, 5];
  }

  // Returns, next possible seat/row index to select seats
  int? _getNextIndex(List<int> indexesList, int currIndex) {
    // Remove Updated/Checked Index from list,
    // As we already checked/updated currentIndex
    indexesList.remove(currIndex);

    if (indexesList.isNotEmpty) {
      /// We are here means,
      /// Still we have index left to check/update

      // TempIndex, holds next index from current
      int tempIndex = (currIndex + 1);
      if (indexesList.contains(tempIndex)) {
        // We are here means,
        // We have next index to check/update
        currIndex = tempIndex;
      } else {
        // We are here means,
        // We don't have any greater index than current,
        // Hence, will go left to get last index of list
        currIndex = indexesList.last;
      }

      return currIndex;
    }
    return null;
  }
}
