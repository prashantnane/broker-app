import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebroker/data/model/propery_filter_model.dart';

import '../../models/Favorites.dart';
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

  Future<DataOutput<Property?>> fetchAllProperties({required int offset}) async {
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

      // final request = ModelQueries.list(Property.classType);

      final response = await Amplify.API.query(request: request).response;
      print('this is response from property repo: ${response}');

      if (response.data != null) {
        Map<String, dynamic>? data = json.decode(response.data!);

        final List<dynamic> propertyList = data?['listProperties']['items'];
        // final List<Property?> propertyList = response.data!.items;

        print('this data from property lenght: ${propertyList.length}');

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

  Future<DataOutput<Property?>> fetchByFilterQuery({required PropertyFilterModel filterQuery}) async {
    List<Property> modelList = [];

    print('listening to fetchProperties');
    try {
      QueryPredicate queryPredicate = QueryPredicate.all;
      if(filterQuery.state!="" )
         queryPredicate = Property.STATE.eq(filterQuery.state);

      final request = ModelQueries.list(
        Property.classType,
        where: queryPredicate
      );

      final response = await Amplify.API.query(request: request).response;
      print('this is response from fetchbyFilterQuery : ${response.data?.items}');
      return DataOutput(total: response.data?.items.length ?? 0, modelList: response.data?.items?? []) ;
      // if (response.data != null) {
      //   Map<String, dynamic>? data = json.decode(response.data.items!);
      //
      //   final List<dynamic> propertyList = data?['listProperties']['items'];
      //   // final List<Property?> propertyList = response.data!.items;
      //
      //   print('this data from property lenght: ${propertyList.length}');
      //
      //   List<Property> modelList = propertyList.map(
      //         (e) {
      //       return Property.fromJson(e);
      //     },
      //   ).toList();
      //
      //   print('this is modelList from property repository: $modelList');
      //
      //   return DataOutput(total: 0, modelList: modelList);
      // } else {
      //   throw Exception('Failed to fetch property repo');
      // }
    } catch (e) {
      throw e;
    }

  }

  Future<DataOutput<Property>> fetchByLocation({required String queryLocation}) async {
    List<Property> modelList = [];

    print('listening to fetchProperties');
    try {
      QueryPredicate queryPredicate = QueryPredicate.all;
      queryPredicate = Property.CITY.eq(queryLocation);

      final request = ModelQueries.list(
        Property.classType,
        where: queryPredicate
      );

      final response = await Amplify.API.query(request: request).response;
      print('this is response from fetchbyFilterQuery : ${response.data?.items}');
      List<Property> responseData =  response.data?.items.where((property) => property != null).cast<Property>().toList()??[];
      return DataOutput(total: response.data?.items.length ?? 0, modelList:responseData) ;
      // if (response.data != null) {
      //   Map<String, dynamic>? data = json.decode(response.data.items!);
      //
      //   final List<dynamic> propertyList = data?['listProperties']['items'];
      //   // final List<Property?> propertyList = response.data!.items;
      //
      //   print('this data from property lenght: ${propertyList.length}');
      //
      //   List<Property> modelList = propertyList.map(
      //         (e) {
      //       return Property.fromJson(e);
      //     },
      //   ).toList();
      //
      //   print('this is modelList from property repository: $modelList');
      //
      //   return DataOutput(total: 0, modelList: modelList);
      // } else {
      //   throw Exception('Failed to fetch property repo');
      // }
    } catch (e) {
      throw e;
    }

  }

  Future<DataOutput<Property?>> fetchByPropertyId({required int offset, required String propertyId}) async {
    Map<String, dynamic> parameters = {
      Api.offset: offset,
      Api.limit: Constant.loadLimit,
      "current_user": HiveUtils.getUserId()
    };
    List<Property> modelList = [];

    print('listening to fetchByPropertyId');
    try {
      final request = ModelQueries.list(Property.classType, where: Property.ID.eq(propertyId));
      final response = await Amplify.API.query(request: request).response;
      print('this is response from property repo: $response');

      if (response.data != null) {
        final propertyItems = response.data?.items ?? [];
        print('this data from property length: ${propertyItems.length}');

        List<Property> modelList = propertyItems.map(
              (e) {
            return Property.fromJson(e!.toJson());
          },
        ).toList();

        print('this is modelList from property repository: $modelList');
        return DataOutput(total: modelList.length, modelList: modelList);
      } else {
        throw Exception('Failed to fetch property repo');
      }
    } catch (e) {
      throw e;
    }
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
  Future<DataOutput<Property>> searchProperty(String searchQuery,
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

    // Map<String, dynamic> response =
    //     await Api.get(url: Api.apiGetProprty, queryParameters: parameters);
    DataOutput<Property> repsonse = await fetchByLocation(queryLocation:  searchQuery);
    List<Property> modelList = repsonse.modelList;
    // List<Property> modelList = (response['data'] as List)
    //     .map((e) => PropertyModel.fromMap(e))
    //     .toList();

    return DataOutput(total: modelList.length ?? 0, modelList: modelList);
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

  Future<DataOutput<Property>> fetchFavoritesByBrokerId({required int offset, required String? brokerId}) async {
    print('listening to fetchFavoritesByBrokerId');
    try {
      final request = ModelQueries.list(Favorites.classType, where: Favorites.BROKERID.eq(brokerId));
      final response = await Amplify.API.query(request: request).response;
      final favoriteItems = response.data?.items ?? [];

      print('this is response from favorite items repo: $favoriteItems');

      if (response.data != null) {
        List<Property> modelList = [];

        for (var item in favoriteItems) {
          final propertyId = item?.propertyID;
          if (propertyId != null) {
            DataOutput<Property?> propertyOutput = await fetchByPropertyId(offset: offset, propertyId: propertyId);
            if (propertyOutput.modelList.isNotEmpty) {
              modelList.add(propertyOutput.modelList.first!);
            }
          }
        }

        print('this is modelList from myproperty repository: $modelList');
        return DataOutput(total: modelList.length, modelList: modelList);
      } else {
        throw Exception('Failed to fetch favorite items');
      }
    } catch (e) {
      throw e;
    }
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
