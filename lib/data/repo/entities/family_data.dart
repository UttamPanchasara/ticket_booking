import 'package:booking_app/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class FamilyData {
  @Id()
  int id = 0;

  String? familyName;
  int? totalMembers;
  bool? ticketBooked;
  @Backlink()
  final members = ToMany<Members>();

  FamilyData({this.familyName, this.totalMembers, this.ticketBooked});

  bool isTicketBooked() {
    return ticketBooked ?? false;
  }
}

@Entity()
class Members {
  @Id()
  int id = 0;
  String? seatNo;
  String? name;
  String? phoneNumber;
  final familyData = ToOne<FamilyData>();

  Members({this.name, this.phoneNumber, this.seatNo});
}
