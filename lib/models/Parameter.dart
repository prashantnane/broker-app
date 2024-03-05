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

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Parameter type in your schema. */
class Parameter extends amplify_core.Model {
  static const classType = const _ParameterModelType();
  final String id;
  final String? _name;
  final String? _parameterId;
  final String? _typeOfParamter;
  final List<String>? _typeValues;
  final String? _image;
  final String? _value;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ParameterModelIdentifier get modelIdentifier {
      return ParameterModelIdentifier(
        id: id
      );
  }
  
  String? get name {
    return _name;
  }
  
  String? get parameterId {
    return _parameterId;
  }
  
  String? get typeOfParamter {
    return _typeOfParamter;
  }
  
  List<String>? get typeValues {
    return _typeValues;
  }
  
  String? get image {
    return _image;
  }
  
  String? get value {
    return _value;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Parameter._internal({required this.id, name, parameterId, typeOfParamter, typeValues, image, value, createdAt, updatedAt}): _name = name, _parameterId = parameterId, _typeOfParamter = typeOfParamter, _typeValues = typeValues, _image = image, _value = value, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Parameter({String? id, String? name, String? parameterId, String? typeOfParamter, List<String>? typeValues, String? image, String? value}) {
    return Parameter._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      parameterId: parameterId,
      typeOfParamter: typeOfParamter,
      typeValues: typeValues != null ? List<String>.unmodifiable(typeValues) : typeValues,
      image: image,
      value: value);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Parameter &&
      id == other.id &&
      _name == other._name &&
      _parameterId == other._parameterId &&
      _typeOfParamter == other._typeOfParamter &&
      DeepCollectionEquality().equals(_typeValues, other._typeValues) &&
      _image == other._image &&
      _value == other._value;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Parameter {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("parameterId=" + "$_parameterId" + ", ");
    buffer.write("typeOfParamter=" + "$_typeOfParamter" + ", ");
    buffer.write("typeValues=" + (_typeValues != null ? _typeValues!.toString() : "null") + ", ");
    buffer.write("image=" + "$_image" + ", ");
    buffer.write("value=" + "$_value" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Parameter copyWith({String? name, String? parameterId, String? typeOfParamter, List<String>? typeValues, String? image, String? value}) {
    return Parameter._internal(
      id: id,
      name: name ?? this.name,
      parameterId: parameterId ?? this.parameterId,
      typeOfParamter: typeOfParamter ?? this.typeOfParamter,
      typeValues: typeValues ?? this.typeValues,
      image: image ?? this.image,
      value: value ?? this.value);
  }
  
  Parameter copyWithModelFieldValues({
    ModelFieldValue<String?>? name,
    ModelFieldValue<String?>? parameterId,
    ModelFieldValue<String?>? typeOfParamter,
    ModelFieldValue<List<String>?>? typeValues,
    ModelFieldValue<String?>? image,
    ModelFieldValue<String?>? value
  }) {
    return Parameter._internal(
      id: id,
      name: name == null ? this.name : name.value,
      parameterId: parameterId == null ? this.parameterId : parameterId.value,
      typeOfParamter: typeOfParamter == null ? this.typeOfParamter : typeOfParamter.value,
      typeValues: typeValues == null ? this.typeValues : typeValues.value,
      image: image == null ? this.image : image.value,
      value: value == null ? this.value : value.value
    );
  }
  
  Parameter.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _parameterId = json['parameterId'],
      _typeOfParamter = json['typeOfParamter'],
      _typeValues = json['typeValues']?.cast<String>(),
      _image = json['image'],
      _value = json['value'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'parameterId': _parameterId, 'typeOfParamter': _typeOfParamter, 'typeValues': _typeValues, 'image': _image, 'value': _value, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'parameterId': _parameterId,
    'typeOfParamter': _typeOfParamter,
    'typeValues': _typeValues,
    'image': _image,
    'value': _value,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<ParameterModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<ParameterModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final PARAMETERID = amplify_core.QueryField(fieldName: "parameterId");
  static final TYPEOFPARAMTER = amplify_core.QueryField(fieldName: "typeOfParamter");
  static final TYPEVALUES = amplify_core.QueryField(fieldName: "typeValues");
  static final IMAGE = amplify_core.QueryField(fieldName: "image");
  static final VALUE = amplify_core.QueryField(fieldName: "value");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Parameter";
    modelSchemaDefinition.pluralName = "Parameters";
    
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
      key: Parameter.NAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Parameter.PARAMETERID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Parameter.TYPEOFPARAMTER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Parameter.TYPEVALUES,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Parameter.IMAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Parameter.VALUE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
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

class _ParameterModelType extends amplify_core.ModelType<Parameter> {
  const _ParameterModelType();
  
  @override
  Parameter fromJson(Map<String, dynamic> jsonData) {
    return Parameter.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Parameter';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Parameter] in your schema.
 */
class ParameterModelIdentifier implements amplify_core.ModelIdentifier<Parameter> {
  final String id;

  /** Create an instance of ParameterModelIdentifier using [id] the primary key. */
  const ParameterModelIdentifier({
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
  String toString() => 'ParameterModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ParameterModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}