// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'data/repo/entities/family_data.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 4437565790734368913),
      name: 'FamilyData',
      lastPropertyId: const IdUid(4, 4936011655617489691),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5815649788661955406),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5440581315562614301),
            name: 'familyName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 9207629482686075901),
            name: 'totalMembers',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4936011655617489691),
            name: 'ticketBooked',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'members', srcEntity: 'Members', srcField: '')
      ]),
  ModelEntity(
      id: const IdUid(2, 968858444938183975),
      name: 'Members',
      lastPropertyId: const IdUid(7, 709396561158528375),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1530962228118424606),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6465503722525163722),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8364594980291405225),
            name: 'phoneNumber',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 83341624300779921),
            name: 'familyDataId',
            type: 11,
            flags: 520,
            indexId: const IdUid(8, 2763212896600404424),
            relationTarget: 'FamilyData'),
        ModelProperty(
            id: const IdUid(7, 709396561158528375),
            name: 'seatNo',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 968858444938183975),
      lastIndexId: const IdUid(8, 2763212896600404424),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [
        5889383266133159454,
        5680814266460547624,
        5352156100117420211,
        267810797387452986,
        742947568812442103,
        1757656908324297555,
        6518029935179247692
      ],
      retiredPropertyUids: const [159167823367342186, 2380435754458152355],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    FamilyData: EntityDefinition<FamilyData>(
        model: _entities[0],
        toOneRelations: (FamilyData object) => [],
        toManyRelations: (FamilyData object) => {
              RelInfo<Members>.toOneBacklink(6, object.id,
                  (Members srcObject) => srcObject.familyData): object.members
            },
        getId: (FamilyData object) => object.id,
        setId: (FamilyData object, int id) {
          object.id = id;
        },
        objectToFB: (FamilyData object, fb.Builder fbb) {
          final familyNameOffset = object.familyName == null
              ? null
              : fbb.writeString(object.familyName!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, familyNameOffset);
          fbb.addInt64(2, object.totalMembers);
          fbb.addBool(3, object.ticketBooked);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = FamilyData(
              familyName: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              totalMembers: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              ticketBooked: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 10))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          InternalToManyAccess.setRelInfo(
              object.members,
              store,
              RelInfo<Members>.toOneBacklink(
                  6, object.id, (Members srcObject) => srcObject.familyData),
              store.box<FamilyData>());
          return object;
        }),
    Members: EntityDefinition<Members>(
        model: _entities[1],
        toOneRelations: (Members object) => [object.familyData],
        toManyRelations: (Members object) => {},
        getId: (Members object) => object.id,
        setId: (Members object, int id) {
          object.id = id;
        },
        objectToFB: (Members object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final phoneNumberOffset = object.phoneNumber == null
              ? null
              : fbb.writeString(object.phoneNumber!);
          final seatNoOffset =
              object.seatNo == null ? null : fbb.writeString(object.seatNo!);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, phoneNumberOffset);
          fbb.addInt64(5, object.familyData.targetId);
          fbb.addOffset(6, seatNoOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Members(
              name: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              phoneNumber: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              seatNo: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 16))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          object.familyData.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          object.familyData.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [FamilyData] entity fields to define ObjectBox queries.
class FamilyData_ {
  /// see [FamilyData.id]
  static final id =
      QueryIntegerProperty<FamilyData>(_entities[0].properties[0]);

  /// see [FamilyData.familyName]
  static final familyName =
      QueryStringProperty<FamilyData>(_entities[0].properties[1]);

  /// see [FamilyData.totalMembers]
  static final totalMembers =
      QueryIntegerProperty<FamilyData>(_entities[0].properties[2]);

  /// see [FamilyData.ticketBooked]
  static final ticketBooked =
      QueryBooleanProperty<FamilyData>(_entities[0].properties[3]);
}

/// [Members] entity fields to define ObjectBox queries.
class Members_ {
  /// see [Members.id]
  static final id = QueryIntegerProperty<Members>(_entities[1].properties[0]);

  /// see [Members.name]
  static final name = QueryStringProperty<Members>(_entities[1].properties[1]);

  /// see [Members.phoneNumber]
  static final phoneNumber =
      QueryStringProperty<Members>(_entities[1].properties[2]);

  /// see [Members.familyData]
  static final familyData =
      QueryRelationToOne<Members, FamilyData>(_entities[1].properties[3]);

  /// see [Members.seatNo]
  static final seatNo =
      QueryStringProperty<Members>(_entities[1].properties[4]);
}
