// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:developer';

import 'package:ebroker/utils/helper_utils.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../models/Category.dart';
import '../../../settings.dart';
import '../../../utils/Network/networkAvailability.dart';
import '../../model/data_output.dart';
import 'category_repository.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}


class CategoryLoadedState extends CategoryState {
  final int total;
  final int offset;
  final bool isLoadingMore;
  final bool hasError;
  final List<CategoryModel> categories;
  CategoryLoadedState({
    required this.total,
    required this.offset,
    required this.isLoadingMore,
    required this.hasError,
    required this.categories,
  });

  CategoryLoadedState copyWith({
    int? total,
    int? offset,
    bool? isLoadingMore,
    bool? hasError,
    List<CategoryModel>? categories,
  }) {
    return CategoryLoadedState(
      total: total ?? this.total,
      offset: offset ?? this.offset,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasError: hasError ?? this.hasError,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'offset': offset,
      'isLoadingMore': isLoadingMore,
      'hasError': hasError,
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryLoadedState.fromMap(Map<String, dynamic> map) {
    return CategoryLoadedState(
      total: map['total'] as int,
      offset: map['offset'] as int,
      isLoadingMore: map['isLoadingMore'] as bool,
      hasError: map['hasError'] as bool,
      categories: List<CategoryModel>.from(
        (map['categories']).map<CategoryModel>(
              (x) => CategoryModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryLoadedState.fromJson(String source) =>
      CategoryLoadedState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FetchCategorySuccess(total: $total, offset: $offset, isLoadingMore: $isLoadingMore, hasError: $hasError, categories: $categories)';
  }
}

class FetchCategoryFailure extends CategoryState {
  final String errorMessage;

  FetchCategoryFailure(this.errorMessage);
}

class CategoryBloc extends Cubit<CategoryState> with HydratedMixin {
  CategoryBloc({required CategoryRepository categoryRepository}) : super(CategoryInitialState());

  final CategoryRepository _categoryRepository = CategoryRepository();




  bool hasMoreData() {
    if (state is CategoryLoadedState) {
      return (state as CategoryLoadedState).categories.length <
          (state as CategoryLoadedState).total;
    }
    return false;
  }

  @override
  CategoryState? fromJson(Map<String, dynamic> json) {
    try {
      var state = json['cubit_state'];

      if (state == "FetchCategorySuccess") {
        return CategoryLoadedState.fromMap(json);
      }
    } catch (e) {
      log("category from map error $e");
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(CategoryState state) {
    if (state is CategoryLoadedState) {
      Map<String, dynamic> mapped = state.toMap();

      mapped['cubit_state'] = "FetchCategorySuccess";

      return mapped;
    }

    return null;
  }
}
