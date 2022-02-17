import 'package:booking_app/data/repo/entities/family_data.dart';

abstract class AddMemberEvent {}

class AddMembersEvent extends AddMemberEvent {
  final FamilyData familyData;
  final List<Members> members;

  AddMembersEvent({required this.familyData, required this.members});
}
