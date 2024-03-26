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


/** This is an auto generated class representing the Category type in your schema. */
class Category extends amplify_core.Model {
  static const classType = const _CategoryModelType();
  final String id;
  final String? _category;
  final String? _image;
  final List<String>? _parameterTypes;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  CategoryModelIdentifier get modelIdentifier {
      return CategoryModelIdentifier(
        id: id
      );
  }
  
  String? get category {
    return _category;
  }
  
  String? get image {
    return _image;
  }
  
  List<String>? get parameterTypes {
    return _parameterTypes;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Category._internal({required this.id, category, image, parameterTypes, createdAt, updatedAt}): _category = category, _image = image, _parameterTypes = parameterTypes, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Category({String? id, String? category, String? image, List<String>? parameterTypes}) {
    return Category._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      category: category,
      image: image,
      parameterTypes: parameterTypes != null ? List<String>.unmodifiable(parameterTypes) : parameterTypes);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Category &&
      id == other.id &&
      _category == other._category &&
      _image == other._image &&
      DeepCollectionEquality().equals(_parameterTypes, other._parameterTypes);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Category {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("category=" + "$_category" + ", ");
    buffer.write("image=" + "$_image" + ", ");
    buffer.write("parameterTypes=" + (_parameterTypes != null ? _parameterTypes!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Category copyWith({String? category, String? image, List<String>? parameterTypes}) {
    return Category._internal(
      id: id,
      category: category ?? this.category,
      image: image ?? this.image,
      parameterTypes: parameterTypes ?? this.parameterTypes);
  }
  
  Category copyWithModelFieldValues({
    ModelFieldValue<String?>? category,
    ModelFieldValue<String?>? image,
    ModelFieldValue<List<String>?>? parameterTypes
  }) {
    return Category._internal(
      id: id,
      category: category == null ? this.category : category.value,
      image: image == null ? this.image : image.value,
      parameterTypes: parameterTypes == null ? this.parameterTypes : parameterTypes.value
    );
  }
  
  Category.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _category = json['category'],
      _image = json['image'],
      _parameterTypes = json['parameterTypes']?.cast<String>(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'category': _category, 'image': _image, 'parameterTypes': _parameterTypes, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'category': _category,
    'image': _image,
    'parameterTypes': _parameterTypes,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<CategoryModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<CategoryModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final CATEGORY = amplify_core.QueryField(fieldName: "category");
  static final IMAGE = amplify_core.QueryField(fieldName: "image");
  static final PARAMETERTYPES = amplify_core.QueryField(fieldName: "parameterTypes");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Category";
    modelSchemaDefinition.pluralName = "Categories";
    
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
      key: Category.CATEGORY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Category.IMAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Category.PARAMETERTYPES,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
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

class _CategoryModelType extends amplify_core.ModelType<Category> {
  const _CategoryModelType();
  
  @override
  Category fromJson(Map<String, dynamic> jsonData) {
    return Category.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Category';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Category] in your schema.
 */
class CategoryModelIdentifier implements amplify_core.ModelIdentifier<Category> {
  final String id;

  /** Create an instance of CategoryModelIdentifier using [id] the primary key. */
  const CategoryModelIdentifier({
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
  String toString() => 'CategoryModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is CategoryModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}