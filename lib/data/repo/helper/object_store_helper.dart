import 'package:booking_app/data/repo/entities/family_data.dart';
import 'package:booking_app/main.dart';

import '../../../objectbox.g.dart';

/// Concrete implementation for local data provider
class ObjectStoreHelper {
  ObjectStoreHelper._privateConstructor();

  static final ObjectStoreHelper instance =
      ObjectStoreHelper._privateConstructor();

  /// Open and return box
  Future<Box> _getBox(int boxId) async {
    final box = objectBox.store.box();
    return box.get(boxId);
  }

  Future insertObject(
    int boxId,
    dynamic value,
  ) async {
    var box = await _getBox(boxId);
    box.put(value);
  }

  Future<Box> readObject(int boxId) async {
    return await _getBox(boxId);
  }

  Future updateObject(
    int boxId,
    dynamic value,
  ) async {
    var box = await _getBox(boxId);
    box.put(value);
  }

  Future deleteObject(
    int boxId,
  ) async {
    var box = await _getBox(boxId);

    box.remove(boxId);
  }

  List<FamilyData> getAllFamily() {
    Box<FamilyData> box = objectBox.store.box<FamilyData>();
    return box.getAll();
  }

  List<FamilyData> getTicketBookedFamily() {
    Box<FamilyData> box = objectBox.store.box<FamilyData>();
    return box.query(FamilyData_.ticketBooked.equals(true)).build().find();
  }

  List<Members> getAllMembers() {
    final box = objectBox.store.box<Members>();
    return box.getAll();
  }

  int putFamily(FamilyData familyData) {
    final box = objectBox.store.box<FamilyData>();
    return box.put(familyData);
  }
}
