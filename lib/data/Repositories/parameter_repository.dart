import 'dart:convert';
import 'package:amplify_core/amplify_core.dart';

import '../../models/Parameter.dart';

class ParameterRepository {
  Future<List<Parameter>> fetchParameterRepository(
      ) async {
    print('listening to fetchParameters');
    try {
      final request = GraphQLRequest<String>(
        document: '''
          query GetParameters {
            listParameters {
              items {
                id
                image
                name
                parameterId
                typeOfParamter
                typeValues
                value
               }
            }
          }
        ''',
      );

      final response = await Amplify.API.query(request: request).response;
      // print('this is response from category repo: ${response.data}');

      if (response.data != null) {
        Map<String, dynamic> data = json.decode(response.data!);

        final List<dynamic> parameterList = data['listParameters']['items'];
        // print('this data from category repo: ${data}');

        List<Parameter> modelList = parameterList.map(
          (e) {
            return Parameter.fromJson(e);
          },
        ).toList();

        print('this is modelList from parameter repository: $modelList');

        return modelList;
      } else {
        throw Exception('Failed to fetch categories');
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
}
