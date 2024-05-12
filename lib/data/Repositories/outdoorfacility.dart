
import 'dart:convert';
import 'package:amplify_core/amplify_core.dart';

import '../../models/OutdoorFacility.dart';
import '../../utils/api.dart';

class OutdoorFacilityRepository {
  Future<List<OutdoorFacility>> fetchOutdoorFacilityRepository(
      ) async {
    print('listening to fetchOutdoorFacility');
    try {
      final request = GraphQLRequest<String>(
        document: '''
          query GetOutdoorFacility {
            listOutdoorFacilities {
              items {
                id
                image
                name
                facilityId
               }
            }
          }
        ''',
      );

      final response = await Amplify.API.query(request: request).response;
      // print('this is response from category repo: ${response.data}');

      if (response.data != null) {
        Map<String, dynamic> data = json.decode(response.data!);

        final List<dynamic> parameterList = data['listOutdoorFacilities']['items'];
        print('this data from category repo: ${parameterList}');

        List<OutdoorFacility> modelList = parameterList.map(
              (e) {
            return OutdoorFacility.fromJson(e);
          },
        ).toList();

        print('this is modelList from outdoorfacility: $modelList');

        return modelList;
      } else {
        throw Exception('Failed to fetch outdoorfacility');
      }
    } catch (e) {
      throw e;
    }
  }

// Future<Map<String, dynamic>> fetchCategoryById(String id) async {
//   print('listening to fetchCategoryById');
//   try {
//     final request = GraphQLRequest<String>(
//       document: '''
//         query fetchCategoryById {
//           getCategory(id: "$id") {
//             category
//             image
//           }
//         }
//       ''',
//     );
//
//     final response = await Amplify.API.query(request: request).response;
//     // print('this is response from category repo: ${response.data}');
//
//     if (response.data != null) {
//       Map<String, dynamic> data = json.decode(response.data!);
//
//       final Map<String, dynamic> categoryList = data['getCategory'];
//       // print('this data from category repo: ${data}');
//
//       // List<CategoryModel> modelList = categoryList.map(
//       //   (e) {
//       //     return CategoryModel.fromJson(e);
//       //   },
//       // ).toList();
//
//       print('this is modelList from categorybyID: $categoryList');
//
//       return categoryList;
//     } else {
//       throw Exception('Failed to fetch categories');
//     }
//   } catch (e) {
//     throw e;
//   }
// }
  Future<List<OutdoorFacility>> fetchOutdoorFacilityList() async {
    Map<String, dynamic> result =
    await Api.get(url: Api.getOutdoorFacilites, queryParameters: {});

    List<OutdoorFacility> outdoorFacilities =
    (result['data'] as List).map((element) {
      return OutdoorFacility.fromJson(element);
    }).toList();

    return List.from(outdoorFacilities);
  }
}



