import 'dart:convert';
import 'package:amplify_core/amplify_core.dart';

import '../../models/CategoryModel.dart';
import '../../utils/constant.dart';

class CategoryRepository {
  Future<List<CategoryModel>> fetchCategoriesRepository({required int offset}) async {
    print('listening to fetchCategories');
    try {
      final request = GraphQLRequest<String>(
        document: '''
          query GetCategories {
            listCategories {
              items {
                id
                category
                image
                parameterTypes
               }
            }
          }
        ''',
        variables: {
          'offset': offset,
          'limit': Constant.loadLimit, // Adjust based on your requirements
        },
      );

      final response = await Amplify.API.query(request: request).response;
      // print('this is response from category repo: ${response.data}');

      if (response.data != null) {
        Map<String, dynamic> data = json.decode(response.data!);

        final List<dynamic> categoryList = data['listCategories']['items'];
        // print('this data from category repo: ${data}');

        List<CategoryModel> modelList = categoryList.map(
          (e) {
            return CategoryModel.fromJson(e);
          },
        ).toList();

        print('this is modelList from category repository: $modelList');

        return modelList;
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      throw e;
    }
  }
}
