import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/Property.dart';
import '../../utils/api.dart';
import '../../utils/constant.dart';
import '../../utils/hive_utils.dart';
import '../model/data_output.dart';
import '../model/property_model.dart';

enum PropertyType {
  sell("0"),
  rent("1");

  final String value;

  const PropertyType(this.value);
}

class PropertyRepository {
  ///This method will add property
  Future createProperty({required Map<String, dynamic> parameters}) async {
    var api = Api.apiPostProperty;
    if (parameters['action_type'] == "0") {
      api = Api.apiUpdateProperty;

      if (parameters.containsKey("gallery_images")) {
        if ((parameters['gallery_images'] as List).isEmpty) {
          parameters.remove("gallery_images");
        }
      }

      if (parameters['title_image'] == null ||
          parameters['title_image'] == "") {
        parameters.remove("title_image");
      }
    }

    return await Api.post(url: api, parameter: parameters);
  }

  /// it will get all proerpties
  Future<DataOutput<PropertyModel>> fetchProperty({required int offset}) async {
    Map<String, dynamic> parameters = {
      Api.offset: offset,
      Api.limit: Constant.loadLimit,
      "current_user": HiveUtils.getUserId()
    };

    Map<String, dynamic> response =
        await Api.get(url: Api.apiGetProprty, queryParameters: parameters);

    List<PropertyModel> modelList = (response['data'] as List)
        .map((e) => PropertyModel.fromMap(e))
        .toList();

    return DataOutput(total: response['total'] ?? 0, modelList: modelList);
  }

  Future<DataOutput<PropertyModel>> fetchRecentProperties(
      {required int offset}) async {
    Map<String, dynamic> parameters = {
      Api.offset: offset,
      Api.limit: Constant.loadLimit,
      "current_user": HiveUtils.getUserId()
    };

    Map<String, dynamic> response =
        await Api.get(url: Api.apiGetProprty, queryParameters: parameters);

    List<PropertyModel> modelList = (response['data'] as List)
        .map((e) => PropertyModel.fromMap(e))
        .toList();

    return DataOutput(total: response['total'] ?? 0, modelList: modelList);
  }

  Future<DataOutput<Property>> fetchAllProperties({required int offset}) async {
    Map<String, dynamic> parameters = {
      Api.offset: offset,
      Api.limit: Constant.loadLimit,
      "current_user": HiveUtils.getUserId()
    };
    List<Property> modelList = [];

    print('listening to fetchProperties');
    try {
      final request = GraphQLRequest<String>(
        document: '''
          query GetProperties {
            listProperties {
              items {
                id
                title
                price
                brokerName
                brokerEmail
                brokerProfile
                brokerNumber
                category
                description
                address
                clientAddress
                propertyType
                titleImage
                postCreated
                gallery
                state
                city
                country
                addedBy
                isFavourite
                isInterested
                assignedOutdoorFacility
                video
                parameters
               }
            }
          }
        ''',
      );

      // final request = ModelQueries.list(
      //   Property.classType,
      // );

      final response = await Amplify.API.query(request: request).response;
      print('this is response from property repo: ${response}');

      if (response.data != null) {
        Map<String, dynamic> data = json.decode(response.data!);

        final List<dynamic> propertyList = data['listProperties']['items'];

        print('this data from property repo: ${propertyList}');
        //
        List<Property> modelList = propertyList.map(
          (e) {
            return Property.fromJson(e);
          },
        ).toList();

        print('this is modelList from property repository: $modelList');

        return DataOutput(total: 0, modelList: modelList);
      } else {
        throw Exception('Failed to fetch property repo');
      }
    } catch (e) {
      throw e;
    }

    Map<String, dynamic> response =
        await Api.get(url: Api.apiGetProprty, queryParameters: parameters);

    // CollectionReference users =
    //     FirebaseFirestore.instance.collection('all_properties');

    // try {
    //   // QuerySnapshot firestoreSnapshot = await users.get();
    //
    //   // Iterate over Firestore documents and add them to the modelList
    //   // for (var firestoreDoc in firestoreSnapshot.docs) {
    //   //   PropertyModel firestoreModel =
    //   //       PropertyModel.fromMap(firestoreDoc.data() as Map<String, dynamic>);
    //   //   modelList.add(firestoreModel);
    //   // }
    //   print('this is modelList: $modelList');
    //
    //   // Add data from the other API to the modelList
    //   // List<PropertyModel> apiModelList =
    //   // (response['data']).map((e) => PropertyModel.fromMap(e)).toList();
    //   // modelList.addAll(apiModelList);
    //
    //   return DataOutput(total: response['total'] ?? 0, modelList: modelList);
    // } catch (e) {
    //   print('Error fetching Firestore data: $e');
    // }

    // If there's an error fetching Firestore data, return the API data
    return DataOutput(total: response['total'] ?? 0, modelList: modelList);
  }

  Future<DataOutput<PropertyModel>> fetchPropertyFromPropertyId(
      dynamic id) async {
    Map<String, dynamic> parameters = {
      Api.id: id,
      "current_user": HiveUtils.getUserId()
    };

    Map<String, dynamic> response =
        await Api.get(url: Api.apiGetProprty, queryParameters: parameters);

    List<PropertyModel> modelList = (response['data'] as List)
        .map((e) => PropertyModel.fromMap(e))
        .toList();

    return DataOutput(total: response['total'] ?? 0, modelList: modelList);
  }

  Future<void> deleteProperty(int id) async {
    await Api.post(
        url: Api.apiUpdateProperty,
        parameter: {Api.id: id, Api.actionType: "1"});
  }

  Future<DataOutput<PropertyModel>> fetchTopRatedProperty() async {
    Map<String, dynamic> parameters = {
      Api.topRated: "1",
      "current_user": HiveUtils.getUserId()
    };

    Map<String, dynamic> response =
        await Api.get(url: Api.apiGetProprty, queryParameters: parameters);

    List<PropertyModel> modelList = (response['data'] as List)
        .map((e) => PropertyModel.fromMap(e))
        .toList();

    return DataOutput(total: response['total'] ?? 0, modelList: modelList);
  }

  ///fetch most viewed properties
  Future<DataOutput<PropertyModel>> fetchMostViewedProperty(
      {required int offset, required bool sendCityName}) async {
    Map<String, dynamic> parameters = {
      Api.topRated: "1",
      Api.offset: offset,
      Api.limit: Constant.loadLimit,
      "current_user": HiveUtils.getUserId()
    };

    if (sendCityName) {
      // if (HiveUtils.getCityName() != null) {
      //   if (!Constant.isDemoModeOn) {
      //     parameters['city'] = HiveUtils.getCityName();
      //   }
      // }
    }

    Map<String, dynamic> response = await Api.get(
      url: Api.apiGetProprty,
      queryParameters: parameters,
    );

    List<PropertyModel> modelList = (response['data'] as List)
        .map((e) => PropertyModel.fromMap(e))
        .toList();
    return DataOutput(
      total: response['total'] ?? 0,
      modelList: modelList,
    );
  }

  ///fetch advertised properties
  Future<DataOutput<PropertyModel>> fetchPromotedProperty(
      {required int offset, required bool sendCityName}) async {
    ///
    Map<String, dynamic> parameters = {
      Api.promoted: true,
      Api.offset: offset,
      Api.limit: Constant.loadLimit,
      "current_user": HiveUtils.getUserId()
    };

    Map<String, dynamic> response = await Api.get(
      url: Api.apiGetProprty,
      queryParameters: parameters,
    );

    List<PropertyModel> modelList = (response['data'] as List)
        .map((e) => PropertyModel.fromMap(e))
        .toList();

    return DataOutput(
      total: response['total'] ?? 0,
      modelList: modelList,
    );
  }

  Future<DataOutput<PropertyModel>> fetchNearByProperty(
      {required int offset}) async {
    try {
      if (HiveUtils.getCityName() == null) {
        return Future.value(DataOutput(
          total: 0,
          modelList: [],
        ));
      }
      Map<String, dynamic> result = await Api.get(
        url: Api.apiGetProprty,
        queryParameters: {
          "city": HiveUtils.getCityName(),
          Api.offset: offset,
          "limit": Constant.loadLimit,
          "current_user": HiveUtils.getUserId()
        },
      );

      List<PropertyModel> dataList = (result['data'] as List).map((e) {
        return PropertyModel.fromMap(e);
      }).toList();

      return DataOutput<PropertyModel>(
        total: result['total'] ?? 0,
        modelList: dataList,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<DataOutput<PropertyModel>> fetchMostLikeProperty({
    required int offset,
    required bool sendCityName,
  }) async {
    Map<String, dynamic> parameters = {
      "most_liked": 1,
      "limit": Constant.loadLimit,
      "offset": offset,
      "current_user": HiveUtils.getUserId()
    };
    if (sendCityName) {
      // if (HiveUtils.getCityName() != null) {
      //   if (!Constant.isDemoModeOn) {
      //     parameters['city'] = HiveUtils.getCityName();
      //   }
      // }
    }
    Map<String, dynamic> response =
        await Api.get(url: Api.apiGetProprty, queryParameters: parameters);

    List<PropertyModel> modelList = (response['data'] as List).map((e) {
      return PropertyModel.fromMap(e);
    }).toList();
    return DataOutput(total: response['total'] ?? 0, modelList: modelList);
  }

  Future<DataOutput<PropertyModel>> fetchMyPromotedProeprties(
      {required int offset}) async {
    Map<String, dynamic> parameters = {
      "users_promoted": 1,
      Api.offset: offset,
      Api.limit: Constant.loadLimit,
      "current_user": HiveUtils.getUserId()
    };

    Map<String, dynamic> response =
        await Api.get(url: Api.apiGetProprty, queryParameters: parameters);
    List<PropertyModel> modelList = (response['data'] as List)
        .map((e) => PropertyModel.fromMap(e))
        .toList();

    return DataOutput(total: response['total'] ?? 0, modelList: modelList);
  }

  ///Search proeprty
  Future<DataOutput<PropertyModel>> searchProperty(String searchQuery,
      {required int offset}) async {
    Map<String, dynamic> parameters = {
      Api.search: searchQuery,
      Api.offset: offset,
      Api.limit: Constant.loadLimit,
      "current_user": HiveUtils.getUserId()
    };

    if (Constant.propertyFilter != null) {
      parameters.addAll(Constant.propertyFilter!.toMap());
    }

    Map<String, dynamic> response =
        await Api.get(url: Api.apiGetProprty, queryParameters: parameters);

    List<PropertyModel> modelList = (response['data'] as List)
        .map((e) => PropertyModel.fromMap(e))
        .toList();

    return DataOutput(total: response['total'] ?? 0, modelList: modelList);
  }

  ///to get my properties which i had added to sell or rent
  Future<DataOutput<PropertyModel>> fetchMyProperties(
      {required int offset, required String type}) async {
    String? propertyType = _findPropertyType(type.toLowerCase());

    Map<String, dynamic> parameters = {
      Api.offset: offset,
      Api.limit: Constant.loadLimit,
      Api.userid: HiveUtils.getUserId(),
      Api.propertyType: propertyType,
      "current_user": HiveUtils.getUserId()
    };
    Map<String, dynamic> response =
        await Api.get(url: Api.apiGetProprty, queryParameters: parameters);
    List<PropertyModel> modelList = (response['data'] as List)
        .map((e) => PropertyModel.fromMap(e))
        .toList();

    return DataOutput(total: response['total'] ?? 0, modelList: modelList);
  }

  String? _findPropertyType(String type) {
    if (type == "sell") {
      return "0";
    } else if (type == "rent") {
      return "1";
    }
    return null;
  }

  Future<DataOutput<PropertyModel>> fetchProperyFromCategoryId(
      {required int id, required int offset, bool? showPropertyType}) async {
    Map<String, dynamic> parameters = {
      Api.categoryId: id,
      Api.offset: offset,
      Api.limit: Constant.loadLimit,
      "current_user": HiveUtils.getUserId()
    };

    if (Constant.propertyFilter != null) {
      parameters.addAll(Constant.propertyFilter!.toMap());

      if (Constant.propertyFilter?.categoryId == "") {
        if (showPropertyType ?? true) {
          parameters.remove(Api.categoryId);
        } else {
          parameters[Api.categoryId] = id;
        }
      }
    }

    Map<String, dynamic> response =
        await Api.get(url: Api.apiGetProprty, queryParameters: parameters);

    List<PropertyModel> modelList = (response['data'] as List)
        .map((e) => PropertyModel.fromMap(e))
        .toList();
    return DataOutput(total: response['total'] ?? 0, modelList: modelList);
  }

  ///this method will set if we are interested in any category when we click intereseted
  Future<void> setInterest(
      {required String propertyId, required String interest}) async {
    await Api.post(url: Api.interestedUsers, parameter: {
      Api.type: interest,
      Api.propertyId: propertyId,
    });
  }

  Future<void> setProeprtyView(String propertyId) async {
    await Api.post(
        url: Api.setPropertyView, parameter: {Api.propertyId: propertyId});
  }

  Future updatePropertyStatus(
      {required dynamic propertyId, required dynamic status}) async {
    await Api.post(
        url: Api.updatePropertyStatus,
        parameter: {"status": status, "property_id": propertyId});
  }

  Future<DataOutput<PropertyModel>> fetchPropertiesFromCityName(
    String cityName, {
    required int offset,
  }) async {
    Map<String, dynamic> response =
        await Api.get(url: Api.apiGetProprty, queryParameters: {
      "city": cityName,
      Api.limit: Constant.loadLimit,
      Api.offset: offset,
      "current_user": HiveUtils.getUserId()
    });

    List<PropertyModel> modelList = (response['data'] as List)
        .map((e) => PropertyModel.fromMap(e))
        .toList();
    return DataOutput(total: response['total'] ?? 0, modelList: modelList);
  }
}
