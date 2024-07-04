import 'dart:developer';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:ebroker/models/Favorites.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/api.dart';
import '../../utils/constant.dart';
import '../model/data_output.dart';
import '../model/property_model.dart';

class FavoriteRepository {
  // Add a constructor to inject dependencies if necessary (e.g., the broker ID)
  final String brokerId;

  FavoriteRepository({required this.brokerId});

  Future<void> addToFavorite(String propertyId) async {
    print('listening to addToFavorite');
    bool success = false;
    final data = Favorites(propertyID: propertyId, brokerID: brokerId);

    try {
      final request = ModelMutations.create(data);
      final response = await Amplify.API.mutate(request: request).response;
      final FavoritesData = response.data;
      final statuscode = response.hasErrors;
      print('this is FavoritesData: $FavoritesData');
      success = true;
      if (FavoritesData == null) {
        safePrint('errors: ${response.errors}');
        success = false;
      } else {
        safePrint('Mutation result: ${FavoritesData.id}');
      }
    } on Exception catch (error) {
      debugPrint(
        error.toString(),
      );
      success = false;
    }
    // return success;
    log("Added to favorites status: $success");
  }

  // Future<void> removeFavorite(int propertyId) async {
  //   Map<String, dynamic> parameters = {
  //     'propertyid': propertyId,
  //     'brokerid': brokerId,
  //   };
  //
  //   await Api.post(url: Api.removeFavorite, parameter: parameters);
  //   log("Removed from favorites: $propertyId");
  // }

  // New method to remove a favorite
  Future<void> removeFavorite(String propertyId) async {
    print('listening to removeFavorite');
    bool success = false;

    try {
      // Query to find the favorite entry to delete
      final request = ModelQueries.list(Favorites.classType, where: Favorites.PROPERTYID.eq(propertyId).and(Favorites.BROKERID.eq(brokerId)));
      final response = await Amplify.API.query(request: request).response;

      final favoritesList = response.data?.items;
      if (favoritesList != null && favoritesList.isNotEmpty) {
        final favoriteToDelete = favoritesList.first;
        if (favoriteToDelete != null) {
          final deleteRequest = ModelMutations.delete(favoriteToDelete);
          final deleteResponse = await Amplify.API.mutate(request: deleteRequest).response;
          if (!deleteResponse.hasErrors) {
            safePrint('Deleted favorite: ${favoriteToDelete.id}');
            success = true;
          } else {
            safePrint('errors: ${deleteResponse.errors}');
          }
        }
      } else {
        safePrint('No favorite found to delete');
      }
    } on Exception catch (error) {
      debugPrint(
        error.toString(),
      );
      success = false;
    }
    log("Removed from favorites status: $success");
  }

  Future<DataOutput<PropertyModel>> fetchFavorites({required int offset}) async {
    Map<String, dynamic> parameters = {
      'brokerid': brokerId,
      'offset': offset,
      'limit': Constant.loadLimit,
    };

    Map<String, dynamic> response = await Api.get(
      url: Api.getFavoriteProperty,
      queryParameters: parameters,
    );

    List<PropertyModel> modelList = (response['data'] as List)
        .map((e) => PropertyModel.fromMap(e))
        .toList();

    return DataOutput<PropertyModel>(
      total: response['total'] ?? 0,
      modelList: modelList,
    );
  }
}
