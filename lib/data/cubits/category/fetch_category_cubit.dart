// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:developer';

import 'package:ebroker/utils/helper_utils.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../models/CategoryModel.dart';
import '../../../settings.dart';
import '../../../utils/Network/networkAvailability.dart';
import '../../model/data_output.dart';
import '../../Repositories/category_repository.dart';

abstract class FetchCategoryState {}

class FetchCategoryInitial extends FetchCategoryState {}


class FetchCategorySuccess extends FetchCategoryState {
  final int total;
  final int offset;
  final bool isLoadingMore;
  final bool hasError;
  final List<CategoryModel> categories;
  FetchCategorySuccess({
    required this.total,
    required this.offset,
    required this.isLoadingMore,
    required this.hasError,
    required this.categories,
  });

  FetchCategorySuccess copyWith({
    int? total,
    int? offset,
    bool? isLoadingMore,
    bool? hasError,
    List<CategoryModel>? categories,
  }) {
    return FetchCategorySuccess(
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

  factory FetchCategorySuccess.fromMap(Map<String, dynamic> map) {
    return FetchCategorySuccess(
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

  factory FetchCategorySuccess.fromJson(String source) =>
      FetchCategorySuccess.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FetchCategorySuccess(total: $total, offset: $offset, isLoadingMore: $isLoadingMore, hasError: $hasError, categories: $categories)';
  }
}

class FetchCategoryFailure extends FetchCategoryState {
  final String errorMessage;

  FetchCategoryFailure(this.errorMessage);
}

class FetchCategoryCubit extends Cubit<FetchCategoryState> with HydratedMixin {
  FetchCategoryCubit({required CategoryRepository categoryRepository}) : super(FetchCategoryInitial());

  final CategoryRepository _categoryRepository = CategoryRepository();

  Future<void> fetchCategories(
      {bool? forceRefresh, bool? loadWithoutDelay}) async {
    try {
      if (forceRefresh != true) {
        if (state is FetchCategorySuccess) {
          await Future.delayed(Duration(
              seconds: loadWithoutDelay == true
                  ? 0
                  : AppSettings.hiddenAPIProcessDelay));
        } else {
          emit(FetchCategoryInitial());
        }
      } else {
        emit(FetchCategoryInitial());
      }

      if (forceRefresh == true) {
        List<CategoryModel> categories =
        await _categoryRepository.fetchCategoriesRepository(offset: 0);

        List<String> list =
        categories.map((element) => element.image!).toList();
        await HelperUtils.precacheSVG(list);

        emit(FetchCategorySuccess(
            total: categories.length,
            categories: categories,
            offset: 0,
            hasError: false,
            isLoadingMore: false));
      } else {
        if (state is! FetchCategorySuccess) {
          List<CategoryModel> categories =
          await _categoryRepository.fetchCategoriesRepository(offset: 0);

          List<String> list =
          categories.map((element) => element.image!).toList();
          await HelperUtils.precacheSVG(list);

          emit(FetchCategorySuccess(
              total: categories.length,
              categories: categories,
              offset: 0,
              hasError: false,
              isLoadingMore: false));
        } else {
          await CheckInternet.check(
            onInternet: () async {
              List<CategoryModel> categories =
              await _categoryRepository.fetchCategoriesRepository(offset: 0);

              List<String> list = categories
                  .map((element) => element.image!)
                  .toList();
              await HelperUtils.precacheSVG(list);

              emit(FetchCategorySuccess(
                  total: categories.length,
                  categories: categories,
                  offset: 0,
                  hasError: false,
                  isLoadingMore: false));
            },
            onNoInternet: () {
              emit(FetchCategorySuccess(
                  total: (state as FetchCategorySuccess).total,
                  offset: (state as FetchCategorySuccess).offset,
                  isLoadingMore: (state as FetchCategorySuccess).isLoadingMore,
                  hasError: (state as FetchCategorySuccess).hasError,
                  categories: (state as FetchCategorySuccess).categories));
            },
          );
        }
      }
    } catch (e) {
      emit(FetchCategoryFailure(e.toString()));
    }
  }

  List<CategoryModel> getCategories() {
    if (state is FetchCategorySuccess) {
      return (state as FetchCategorySuccess).categories;
    }

    return <CategoryModel>[];
  }

  Future<void> fetchCategoriesMore() async {
    try {
      if (state is FetchCategorySuccess) {
        if ((state as FetchCategorySuccess).isLoadingMore) {
          return;
        }
        emit((state as FetchCategorySuccess).copyWith(isLoadingMore: true));
        List<CategoryModel> result = await _categoryRepository.fetchCategoriesRepository(
          offset: (state as FetchCategorySuccess).categories.length,
        );

        FetchCategorySuccess categoryState = (state as FetchCategorySuccess);
        categoryState.categories.addAll(result);

        List<String> list =
            categoryState.categories.map((e) => e.image!).toList();
        await HelperUtils.precacheSVG(list);

        emit(FetchCategorySuccess(
            isLoadingMore: false,
            hasError: false,
            categories: categoryState.categories,
            offset: (state as FetchCategorySuccess).categories.length,
            total: result.length));
      }
    } catch (e) {
      emit((state as FetchCategorySuccess)
          .copyWith(isLoadingMore: false, hasError: true));
    }
  }

  bool hasMoreData() {
    if (state is FetchCategorySuccess) {
      return (state as FetchCategorySuccess).categories.length <
          (state as FetchCategorySuccess).total;
    }
    return false;
  }

  @override
  FetchCategoryState? fromJson(Map<String, dynamic> json) {
    try {
      var state = json['cubit_state'];

      if (state == "FetchCategorySuccess") {
        return FetchCategorySuccess.fromMap(json);
      }
    } catch (e) {
      log("category from map error $e");
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(FetchCategoryState state) {
    if (state is FetchCategorySuccess) {
      Map<String, dynamic> mapped = state.toMap();

      mapped['cubit_state'] = "FetchCategorySuccess";

      return mapped;
    }

    return null;
  }
}
