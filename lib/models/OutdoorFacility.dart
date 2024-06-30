/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the OutdoorFacility type in your schema. */
class OutdoorFacility extends amplify_core.Model {
  static const classType = const _OutdoorFacilityModelType();
  final String id;
  final String? _name;
  final String? _image;
  final int? _facilityId;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  OutdoorFacilityModelIdentifier get modelIdentifier {
      return OutdoorFacilityModelIdentifier(
        id: id
      );
  }
  
  String? get name {
    return _name;
  }
  
  String? get image {
    return _image;
  }
  
  int? get facilityId {
    return _facilityId;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const OutdoorFacility._internal({required this.id, name, image, facilityId, createdAt, updatedAt}): _name = name, _image = image, _facilityId = facilityId, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory OutdoorFacility({String? id, String? name, String? image, int? facilityId}) {
    return OutdoorFacility._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      image: image,
      facilityId: facilityId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OutdoorFacility &&
      id == other.id &&
      _name == other._name &&
      _image == other._image &&
      _facilityId == other._facilityId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("OutdoorFacility {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("image=" + "$_image" + ", ");
    buffer.write("facilityId=" + (_facilityId != null ? _facilityId!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  OutdoorFacility copyWith({String? name, String? image, int? facilityId}) {
    return OutdoorFacility._internal(
      id: id,
      name: name ?? this.name,
      image: image ?? this.image,
      facilityId: facilityId ?? this.facilityId);
  }
  
  OutdoorFacility copyWithModelFieldValues({
    ModelFieldValue<String?>? name,
    ModelFieldValue<String?>? image,
    ModelFieldValue<int?>? facilityId
  }) {
    return OutdoorFacility._internal(
      id: id,
      name: name == null ? this.name : name.value,
      image: image == null ? this.image : image.value,
      facilityId: facilityId == null ? this.facilityId : facilityId.value
    );
  }
  
  OutdoorFacility.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _image = json['image'],
      _facilityId = (json['facilityId'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'image': _image, 'facilityId': _facilityId, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'image': _image,
    'facilityId': _facilityId,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<OutdoorFacilityModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<OutdoorFacilityModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final IMAGE = amplify_core.QueryField(fieldName: "image");
  static final FACILITYID = amplify_core.QueryField(fieldName: "facilityId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "OutdoorFacility";
    modelSchemaDefinition.pluralName = "OutdoorFacilities";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: OutdoorFacility.NAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: OutdoorFacility.IMAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: OutdoorFacility.FACILITYID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _OutdoorFacilityModelType extends amplify_core.ModelType<OutdoorFacility> {
  const _OutdoorFacilityModelType();
  
  @override
  OutdoorFacility fromJson(Map<String, dynamic> jsonData) {
    return OutdoorFacility.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'OutdoorFacility';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [OutdoorFacility] in your schema.
 */
class OutdoorFacilityModelIdentifier implements amplify_core.ModelIdentifier<OutdoorFacility> {
  final String id;

  /** Create an instance of OutdoorFacilityModelIdentifier using [id] the primary key. */
  const OutdoorFacilityModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'OutdoorFacilityModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is OutdoorFacilityModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}