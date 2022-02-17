import 'package:booking_app/data/repo/entities/family_data.dart';

abstract class AddFamilyEvent {}

class CreateFamilyEvent extends AddFamilyEvent {
  final FamilyData familyData;

  CreateFamilyEvent({required this.familyData});
}
