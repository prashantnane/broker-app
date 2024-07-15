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


/** This is an auto generated class representing the Broker type in your schema. */
class Broker extends amplify_core.Model {
  static const classType = const _BrokerModelType();
  final String id;
  final String? _name;
  final String? _email;
  final String? _mobile;
  final String? _address;
  final int? _isActive;
  final bool? _isProfileCompleted;
  final int? _notification;
  final String? _profile;
  final String? _RERA;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  BrokerModelIdentifier get modelIdentifier {
      return BrokerModelIdentifier(
        id: id
      );
  }
  
  String? get name {
    return _name;
  }
  
  String? get email {
    return _email;
  }
  
  String? get mobile {
    return _mobile;
  }
  
  String? get address {
    return _address;
  }
  
  int? get isActive {
    return _isActive;
  }
  
  bool? get isProfileCompleted {
    return _isProfileCompleted;
  }
  
  int? get notification {
    return _notification;
  }
  
  String? get profile {
    return _profile;
  }
  
  String? get RERA {
    return _RERA;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Broker._internal({required this.id, name, email, mobile, address, isActive, isProfileCompleted, notification, profile, RERA, createdAt, updatedAt}): _name = name, _email = email, _mobile = mobile, _address = address, _isActive = isActive, _isProfileCompleted = isProfileCompleted, _notification = notification, _profile = profile, _RERA = RERA, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Broker({String? id, String? name, String? email, String? mobile, String? address, int? isActive, bool? isProfileCompleted, int? notification, String? profile, String? RERA}) {
    return Broker._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      email: email,
      mobile: mobile,
      address: address,
      isActive: isActive,
      isProfileCompleted: isProfileCompleted,
      notification: notification,
      profile: profile,
      RERA: RERA);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Broker &&
      id == other.id &&
      _name == other._name &&
      _email == other._email &&
      _mobile == other._mobile &&
      _address == other._address &&
      _isActive == other._isActive &&
      _isProfileCompleted == other._isProfileCompleted &&
      _notification == other._notification &&
      _profile == other._profile &&
      _RERA == other._RERA;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Broker {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("mobile=" + "$_mobile" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("isActive=" + (_isActive != null ? _isActive!.toString() : "null") + ", ");
    buffer.write("isProfileCompleted=" + (_isProfileCompleted != null ? _isProfileCompleted!.toString() : "null") + ", ");
    buffer.write("notification=" + (_notification != null ? _notification!.toString() : "null") + ", ");
    buffer.write("profile=" + "$_profile" + ", ");
    buffer.write("RERA=" + "$_RERA" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Broker copyWith({String? name, String? email, String? mobile, String? address, int? isActive, bool? isProfileCompleted, int? notification, String? profile, String? RERA}) {
    return Broker._internal(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      notification: notification ?? this.notification,
      profile: profile ?? this.profile,
      RERA: RERA ?? this.RERA);
  }
  
  Broker copyWithModelFieldValues({
    ModelFieldValue<String?>? name,
    ModelFieldValue<String?>? email,
    ModelFieldValue<String?>? mobile,
    ModelFieldValue<String?>? address,
    ModelFieldValue<int?>? isActive,
    ModelFieldValue<bool?>? isProfileCompleted,
    ModelFieldValue<int?>? notification,
    ModelFieldValue<String?>? profile,
    ModelFieldValue<String?>? RERA
  }) {
    return Broker._internal(
      id: id,
      name: name == null ? this.name : name.value,
      email: email == null ? this.email : email.value,
      mobile: mobile == null ? this.mobile : mobile.value,
      address: address == null ? this.address : address.value,
      isActive: isActive == null ? this.isActive : isActive.value,
      isProfileCompleted: isProfileCompleted == null ? this.isProfileCompleted : isProfileCompleted.value,
      notification: notification == null ? this.notification : notification.value,
      profile: profile == null ? this.profile : profile.value,
      RERA: RERA == null ? this.RERA : RERA.value
    );
  }
  
  Broker.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _email = json['email'],
      _mobile = json['mobile'],
      _address = json['address'],
      _isActive = (json['isActive'] as num?)?.toInt(),
      _isProfileCompleted = json['isProfileCompleted'],
      _notification = (json['notification'] as num?)?.toInt(),
      _profile = json['profile'],
      _RERA = json['RERA'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'email': _email, 'mobile': _mobile, 'address': _address, 'isActive': _isActive, 'isProfileCompleted': _isProfileCompleted, 'notification': _notification, 'profile': _profile, 'RERA': _RERA, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'email': _email,
    'mobile': _mobile,
    'address': _address,
    'isActive': _isActive,
    'isProfileCompleted': _isProfileCompleted,
    'notification': _notification,
    'profile': _profile,
    'RERA': _RERA,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<BrokerModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<BrokerModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final EMAIL = amplify_core.QueryField(fieldName: "email");
  static final MOBILE = amplify_core.QueryField(fieldName: "mobile");
  static final ADDRESS = amplify_core.QueryField(fieldName: "address");
  static final ISACTIVE = amplify_core.QueryField(fieldName: "isActive");
  static final ISPROFILECOMPLETED = amplify_core.QueryField(fieldName: "isProfileCompleted");
  static final NOTIFICATION = amplify_core.QueryField(fieldName: "notification");
  static final PROFILE = amplify_core.QueryField(fieldName: "profile");
  static final RERA = amplify_core.QueryField(fieldName: "RERA");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Broker";
    modelSchemaDefinition.pluralName = "Brokers";
    
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
      key: Broker.NAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Broker.EMAIL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Broker.MOBILE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Broker.ADDRESS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Broker.ISACTIVE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Broker.ISPROFILECOMPLETED,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Broker.NOTIFICATION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Broker.PROFILE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Broker.RERA,
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

class _BrokerModelType extends amplify_core.ModelType<Broker> {
  const _BrokerModelType();
  
  @override
  Broker fromJson(Map<String, dynamic> jsonData) {
    return Broker.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Broker';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Broker] in your schema.
 */
class BrokerModelIdentifier implements amplify_core.ModelIdentifier<Broker> {
  final String id;

  /** Create an instance of BrokerModelIdentifier using [id] the primary key. */
  const BrokerModelIdentifier({
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
  String toString() => 'BrokerModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is BrokerModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}