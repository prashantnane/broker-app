import 'dart:convert';
import 'package:amplify_core/amplify_core.dart';

import '../../../models/Category.dart';
import '../../../utils/constant.dart';

class CategoryRepository {
  Future<List<CategoryModel>> fetchCategories({required int offset}) async {
    print('inside fetchCategories');
    try {
      final request = GraphQLRequest<String>(
        document: '''
          query GetCategories {
      listCategories {
              
              items {
                category
                image
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

      if (response.data != null) {
        Map<String, dynamic> data = json.decode(response.data!);
        List<CategoryModel> modelList =
            (data as List).map(
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
