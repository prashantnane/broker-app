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


/** This is an auto generated class representing the Property type in your schema. */
class Property extends amplify_core.Model {
  static const classType = const _PropertyModelType();
  final String id;
  final String? _title;
  final String? _price;
  final String? _customerName;
  final String? _customerEmail;
  final String? _customerProfile;
  final String? _customerNumber;
  final String? _category;
  final String? _description;
  final String? _address;
  final String? _clientAddress;
  final String? _propertyType;
  final String? _titleImage;
  final String? _postCreated;
  final List<String>? _gallery;
  final String? _state;
  final String? _city;
  final String? _country;
  final int? _addedBy;
  final bool? _isFavourite;
  final bool? _isInterested;
  final List<String>? _assignedOutdoorFacility;
  final String? _latitude;
  final String? _longitude;
  final String? _threeDImage;
  final String? _video;
  final List<String>? _parameters;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  PropertyModelIdentifier get modelIdentifier {
      return PropertyModelIdentifier(
        id: id
      );
  }
  
  String? get title {
    return _title;
  }
  
  String? get price {
    return _price;
  }
  
  String? get customerName {
    return _customerName;
  }
  
  String? get customerEmail {
    return _customerEmail;
  }
  
  String? get customerProfile {
    return _customerProfile;
  }
  
  String? get customerNumber {
    return _customerNumber;
  }
  
  String? get category {
    return _category;
  }
  
  String? get description {
    return _description;
  }
  
  String? get address {
    return _address;
  }
  
  String? get clientAddress {
    return _clientAddress;
  }
  
  String? get propertyType {
    return _propertyType;
  }
  
  String? get titleImage {
    return _titleImage;
  }
  
  String? get postCreated {
    return _postCreated;
  }
  
  List<String>? get gallery {
    return _gallery;
  }
  
  String? get state {
    return _state;
  }
  
  String? get city {
    return _city;
  }
  
  String? get country {
    return _country;
  }
  
  int? get addedBy {
    return _addedBy;
  }
  
  bool? get isFavourite {
    return _isFavourite;
  }
  
  bool? get isInterested {
    return _isInterested;
  }
  
  List<String>? get assignedOutdoorFacility {
    return _assignedOutdoorFacility;
  }
  
  String? get latitude {
    return _latitude;
  }
  
  String? get longitude {
    return _longitude;
  }
  
  String? get threeDImage {
    return _threeDImage;
  }
  
  String? get video {
    return _video;
  }
  
  List<String>? get parameters {
    return _parameters;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Property._internal({required this.id, title, price, customerName, customerEmail, customerProfile, customerNumber, category, description, address, clientAddress, propertyType, titleImage, postCreated, gallery, state, city, country, addedBy, isFavourite, isInterested, assignedOutdoorFacility, latitude, longitude, threeDImage, video, parameters, createdAt, updatedAt}): _title = title, _price = price, _customerName = customerName, _customerEmail = customerEmail, _customerProfile = customerProfile, _customerNumber = customerNumber, _category = category, _description = description, _address = address, _clientAddress = clientAddress, _propertyType = propertyType, _titleImage = titleImage, _postCreated = postCreated, _gallery = gallery, _state = state, _city = city, _country = country, _addedBy = addedBy, _isFavourite = isFavourite, _isInterested = isInterested, _assignedOutdoorFacility = assignedOutdoorFacility, _latitude = latitude, _longitude = longitude, _threeDImage = threeDImage, _video = video, _parameters = parameters, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Property({String? id, String? title, String? price, String? customerName, String? customerEmail, String? customerProfile, String? customerNumber, String? category, String? description, String? address, String? clientAddress, String? propertyType, String? titleImage, String? postCreated, List<String>? gallery, String? state, String? city, String? country, int? addedBy, bool? isFavourite, bool? isInterested, List<String>? assignedOutdoorFacility, String? latitude, String? longitude, String? threeDImage, String? video, List<String>? parameters}) {
    return Property._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      title: title,
      price: price,
      customerName: customerName,
      customerEmail: customerEmail,
      customerProfile: customerProfile,
      customerNumber: customerNumber,
      category: category,
      description: description,
      address: address,
      clientAddress: clientAddress,
      propertyType: propertyType,
      titleImage: titleImage,
      postCreated: postCreated,
      gallery: gallery != null ? List<String>.unmodifiable(gallery) : gallery,
      state: state,
      city: city,
      country: country,
      addedBy: addedBy,
      isFavourite: isFavourite,
      isInterested: isInterested,
      assignedOutdoorFacility: assignedOutdoorFacility != null ? List<String>.unmodifiable(assignedOutdoorFacility) : assignedOutdoorFacility,
      latitude: latitude,
      longitude: longitude,
      threeDImage: threeDImage,
      video: video,
      parameters: parameters != null ? List<String>.unmodifiable(parameters) : parameters);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Property &&
      id == other.id &&
      _title == other._title &&
      _price == other._price &&
      _customerName == other._customerName &&
      _customerEmail == other._customerEmail &&
      _customerProfile == other._customerProfile &&
      _customerNumber == other._customerNumber &&
      _category == other._category &&
      _description == other._description &&
      _address == other._address &&
      _clientAddress == other._clientAddress &&
      _propertyType == other._propertyType &&
      _titleImage == other._titleImage &&
      _postCreated == other._postCreated &&
      DeepCollectionEquality().equals(_gallery, other._gallery) &&
      _state == other._state &&
      _city == other._city &&
      _country == other._country &&
      _addedBy == other._addedBy &&
      _isFavourite == other._isFavourite &&
      _isInterested == other._isInterested &&
      DeepCollectionEquality().equals(_assignedOutdoorFacility, other._assignedOutdoorFacility) &&
      _latitude == other._latitude &&
      _longitude == other._longitude &&
      _threeDImage == other._threeDImage &&
      _video == other._video &&
      DeepCollectionEquality().equals(_parameters, other._parameters);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Property {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("price=" + "$_price" + ", ");
    buffer.write("customerName=" + "$_customerName" + ", ");
    buffer.write("customerEmail=" + "$_customerEmail" + ", ");
    buffer.write("customerProfile=" + "$_customerProfile" + ", ");
    buffer.write("customerNumber=" + "$_customerNumber" + ", ");
    buffer.write("category=" + "$_category" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("clientAddress=" + "$_clientAddress" + ", ");
    buffer.write("propertyType=" + "$_propertyType" + ", ");
    buffer.write("titleImage=" + "$_titleImage" + ", ");
    buffer.write("postCreated=" + "$_postCreated" + ", ");
    buffer.write("gallery=" + (_gallery != null ? _gallery!.toString() : "null") + ", ");
    buffer.write("state=" + "$_state" + ", ");
    buffer.write("city=" + "$_city" + ", ");
    buffer.write("country=" + "$_country" + ", ");
    buffer.write("addedBy=" + (_addedBy != null ? _addedBy!.toString() : "null") + ", ");
    buffer.write("isFavourite=" + (_isFavourite != null ? _isFavourite!.toString() : "null") + ", ");
    buffer.write("isInterested=" + (_isInterested != null ? _isInterested!.toString() : "null") + ", ");
    buffer.write("assignedOutdoorFacility=" + (_assignedOutdoorFacility != null ? _assignedOutdoorFacility!.toString() : "null") + ", ");
    buffer.write("latitude=" + "$_latitude" + ", ");
    buffer.write("longitude=" + "$_longitude" + ", ");
    buffer.write("threeDImage=" + "$_threeDImage" + ", ");
    buffer.write("video=" + "$_video" + ", ");
    buffer.write("parameters=" + (_parameters != null ? _parameters!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Property copyWith({String? title, String? price, String? customerName, String? customerEmail, String? customerProfile, String? customerNumber, String? category, String? description, String? address, String? clientAddress, String? propertyType, String? titleImage, String? postCreated, List<String>? gallery, String? state, String? city, String? country, int? addedBy, bool? isFavourite, bool? isInterested, List<String>? assignedOutdoorFacility, String? latitude, String? longitude, String? threeDImage, String? video, List<String>? parameters}) {
    return Property._internal(
      id: id,
      title: title ?? this.title,
      price: price ?? this.price,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerProfile: customerProfile ?? this.customerProfile,
      customerNumber: customerNumber ?? this.customerNumber,
      category: category ?? this.category,
      description: description ?? this.description,
      address: address ?? this.address,
      clientAddress: clientAddress ?? this.clientAddress,
      propertyType: propertyType ?? this.propertyType,
      titleImage: titleImage ?? this.titleImage,
      postCreated: postCreated ?? this.postCreated,
      gallery: gallery ?? this.gallery,
      state: state ?? this.state,
      city: city ?? this.city,
      country: country ?? this.country,
      addedBy: addedBy ?? this.addedBy,
      isFavourite: isFavourite ?? this.isFavourite,
      isInterested: isInterested ?? this.isInterested,
      assignedOutdoorFacility: assignedOutdoorFacility ?? this.assignedOutdoorFacility,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      threeDImage: threeDImage ?? this.threeDImage,
      video: video ?? this.video,
      parameters: parameters ?? this.parameters);
  }
  
  Property copyWithModelFieldValues({
    ModelFieldValue<String?>? title,
    ModelFieldValue<String?>? price,
    ModelFieldValue<String?>? customerName,
    ModelFieldValue<String?>? customerEmail,
    ModelFieldValue<String?>? customerProfile,
    ModelFieldValue<String?>? customerNumber,
    ModelFieldValue<String?>? category,
    ModelFieldValue<String?>? description,
    ModelFieldValue<String?>? address,
    ModelFieldValue<String?>? clientAddress,
    ModelFieldValue<String?>? propertyType,
    ModelFieldValue<String?>? titleImage,
    ModelFieldValue<String?>? postCreated,
    ModelFieldValue<List<String>?>? gallery,
    ModelFieldValue<String?>? state,
    ModelFieldValue<String?>? city,
    ModelFieldValue<String?>? country,
    ModelFieldValue<int?>? addedBy,
    ModelFieldValue<bool?>? isFavourite,
    ModelFieldValue<bool?>? isInterested,
    ModelFieldValue<List<String>?>? assignedOutdoorFacility,
    ModelFieldValue<String?>? latitude,
    ModelFieldValue<String?>? longitude,
    ModelFieldValue<String?>? threeDImage,
    ModelFieldValue<String?>? video,
    ModelFieldValue<List<String>?>? parameters
  }) {
    return Property._internal(
      id: id,
      title: title == null ? this.title : title.value,
      price: price == null ? this.price : price.value,
      customerName: customerName == null ? this.customerName : customerName.value,
      customerEmail: customerEmail == null ? this.customerEmail : customerEmail.value,
      customerProfile: customerProfile == null ? this.customerProfile : customerProfile.value,
      customerNumber: customerNumber == null ? this.customerNumber : customerNumber.value,
      category: category == null ? this.category : category.value,
      description: description == null ? this.description : description.value,
      address: address == null ? this.address : address.value,
      clientAddress: clientAddress == null ? this.clientAddress : clientAddress.value,
      propertyType: propertyType == null ? this.propertyType : propertyType.value,
      titleImage: titleImage == null ? this.titleImage : titleImage.value,
      postCreated: postCreated == null ? this.postCreated : postCreated.value,
      gallery: gallery == null ? this.gallery : gallery.value,
      state: state == null ? this.state : state.value,
      city: city == null ? this.city : city.value,
      country: country == null ? this.country : country.value,
      addedBy: addedBy == null ? this.addedBy : addedBy.value,
      isFavourite: isFavourite == null ? this.isFavourite : isFavourite.value,
      isInterested: isInterested == null ? this.isInterested : isInterested.value,
      assignedOutdoorFacility: assignedOutdoorFacility == null ? this.assignedOutdoorFacility : assignedOutdoorFacility.value,
      latitude: latitude == null ? this.latitude : latitude.value,
      longitude: longitude == null ? this.longitude : longitude.value,
      threeDImage: threeDImage == null ? this.threeDImage : threeDImage.value,
      video: video == null ? this.video : video.value,
      parameters: parameters == null ? this.parameters : parameters.value
    );
  }
  
  Property.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _price = json['price'],
      _customerName = json['customerName'],
      _customerEmail = json['customerEmail'],
      _customerProfile = json['customerProfile'],
      _customerNumber = json['customerNumber'],
      _category = json['category'],
      _description = json['description'],
      _address = json['address'],
      _clientAddress = json['clientAddress'],
      _propertyType = json['propertyType'],
      _titleImage = json['titleImage'],
      _postCreated = json['postCreated'],
      _gallery = json['gallery']?.cast<String>(),
      _state = json['state'],
      _city = json['city'],
      _country = json['country'],
      _addedBy = (json['addedBy'] as num?)?.toInt(),
      _isFavourite = json['isFavourite'],
      _isInterested = json['isInterested'],
      _assignedOutdoorFacility = json['assignedOutdoorFacility']?.cast<String>(),
      _latitude = json['latitude'],
      _longitude = json['longitude'],
      _threeDImage = json['threeDImage'],
      _video = json['video'],
      _parameters = json['parameters']?.cast<String>(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'price': _price, 'customerName': _customerName, 'customerEmail': _customerEmail, 'customerProfile': _customerProfile, 'customerNumber': _customerNumber, 'category': _category, 'description': _description, 'address': _address, 'clientAddress': _clientAddress, 'propertyType': _propertyType, 'titleImage': _titleImage, 'postCreated': _postCreated, 'gallery': _gallery, 'state': _state, 'city': _city, 'country': _country, 'addedBy': _addedBy, 'isFavourite': _isFavourite, 'isInterested': _isInterested, 'assignedOutdoorFacility': _assignedOutdoorFacility, 'latitude': _latitude, 'longitude': _longitude, 'threeDImage': _threeDImage, 'video': _video, 'parameters': _parameters, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'title': _title,
    'price': _price,
    'customerName': _customerName,
    'customerEmail': _customerEmail,
    'customerProfile': _customerProfile,
    'customerNumber': _customerNumber,
    'category': _category,
    'description': _description,
    'address': _address,
    'clientAddress': _clientAddress,
    'propertyType': _propertyType,
    'titleImage': _titleImage,
    'postCreated': _postCreated,
    'gallery': _gallery,
    'state': _state,
    'city': _city,
    'country': _country,
    'addedBy': _addedBy,
    'isFavourite': _isFavourite,
    'isInterested': _isInterested,
    'assignedOutdoorFacility': _assignedOutdoorFacility,
    'latitude': _latitude,
    'longitude': _longitude,
    'threeDImage': _threeDImage,
    'video': _video,
    'parameters': _parameters,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<PropertyModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<PropertyModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TITLE = amplify_core.QueryField(fieldName: "title");
  static final PRICE = amplify_core.QueryField(fieldName: "price");
  static final CUSTOMERNAME = amplify_core.QueryField(fieldName: "customerName");
  static final CUSTOMEREMAIL = amplify_core.QueryField(fieldName: "customerEmail");
  static final CUSTOMERPROFILE = amplify_core.QueryField(fieldName: "customerProfile");
  static final CUSTOMERNUMBER = amplify_core.QueryField(fieldName: "customerNumber");
  static final CATEGORY = amplify_core.QueryField(fieldName: "category");
  static final DESCRIPTION = amplify_core.QueryField(fieldName: "description");
  static final ADDRESS = amplify_core.QueryField(fieldName: "address");
  static final CLIENTADDRESS = amplify_core.QueryField(fieldName: "clientAddress");
  static final PROPERTYTYPE = amplify_core.QueryField(fieldName: "propertyType");
  static final TITLEIMAGE = amplify_core.QueryField(fieldName: "titleImage");
  static final POSTCREATED = amplify_core.QueryField(fieldName: "postCreated");
  static final GALLERY = amplify_core.QueryField(fieldName: "gallery");
  static final STATE = amplify_core.QueryField(fieldName: "state");
  static final CITY = amplify_core.QueryField(fieldName: "city");
  static final COUNTRY = amplify_core.QueryField(fieldName: "country");
  static final ADDEDBY = amplify_core.QueryField(fieldName: "addedBy");
  static final ISFAVOURITE = amplify_core.QueryField(fieldName: "isFavourite");
  static final ISINTERESTED = amplify_core.QueryField(fieldName: "isInterested");
  static final ASSIGNEDOUTDOORFACILITY = amplify_core.QueryField(fieldName: "assignedOutdoorFacility");
  static final LATITUDE = amplify_core.QueryField(fieldName: "latitude");
  static final LONGITUDE = amplify_core.QueryField(fieldName: "longitude");
  static final THREEDIMAGE = amplify_core.QueryField(fieldName: "threeDImage");
  static final VIDEO = amplify_core.QueryField(fieldName: "video");
  static final PARAMETERS = amplify_core.QueryField(fieldName: "parameters");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Property";
    modelSchemaDefinition.pluralName = "Properties";
    
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
      key: Property.TITLE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.PRICE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.CUSTOMERNAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.CUSTOMEREMAIL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.CUSTOMERPROFILE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.CUSTOMERNUMBER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.CATEGORY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.DESCRIPTION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.ADDRESS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.CLIENTADDRESS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.PROPERTYTYPE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.TITLEIMAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.POSTCREATED,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.GALLERY,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.STATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.CITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.COUNTRY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.ADDEDBY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.ISFAVOURITE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.ISINTERESTED,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.ASSIGNEDOUTDOORFACILITY,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.LATITUDE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.LONGITUDE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.THREEDIMAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.VIDEO,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Property.PARAMETERS,
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

class _PropertyModelType extends amplify_core.ModelType<Property> {
  const _PropertyModelType();
  
  @override
  Property fromJson(Map<String, dynamic> jsonData) {
    return Property.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Property';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Property] in your schema.
 */
class PropertyModelIdentifier implements amplify_core.ModelIdentifier<Property> {
  final String id;

  /** Create an instance of PropertyModelIdentifier using [id] the primary key. */
  const PropertyModelIdentifier({
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
  String toString() => 'PropertyModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is PropertyModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}