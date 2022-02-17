import 'package:booking_app/data/repo/entities/family_data.dart';
import 'package:booking_app/data/repo/helper/object_store_helper.dart';

class LocalDBRepo {
  List<FamilyData> getAllFamilies() {
    return ObjectStoreHelper.instance.getAllFamily();
  }

  List<FamilyData> getTickedBookedFamilies() {
    return ObjectStoreHelper.instance.getTicketBookedFamily();
  }

  List<Members> getAllMembers() {
    return ObjectStoreHelper.instance.getAllMembers();
  }

  int putFamily(FamilyData familyData) {
    return ObjectStoreHelper.instance.putFamily(familyData);
  }
}
