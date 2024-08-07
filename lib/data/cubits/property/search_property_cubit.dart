// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ebroker/data/Repositories/property_repository.dart';
import 'package:ebroker/data/model/data_output.dart';
import 'package:ebroker/data/model/property_model.dart';

import '../../../models/Property.dart';

abstract class SearchPropertyState {}

class SearchPropertyInitial extends SearchPropertyState {}

class SearchPropertyFetchProgress extends SearchPropertyState {}

class SearchPropertyProgress extends SearchPropertyState {}

class SearchPropertySuccess extends SearchPropertyState {
  final int total;
  final int offset;
  final String searchQuery;
  final bool isLoadingMore;
  final bool hasError;
  final List<Property> searchedProperties;

  SearchPropertySuccess({
    required this.searchQuery,
    required this.total,
    required this.offset,
    required this.isLoadingMore,
    required this.hasError,
    required this.searchedProperties,
  });

  SearchPropertySuccess copyWith({
    int? total,
    int? offset,
    String? searchQuery,
    bool? isLoadingMore,
    bool? hasError,
    List<Property>? searchedProperties,
  }) {
    return SearchPropertySuccess(
      total: total ?? this.total,
      offset: offset ?? this.offset,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasError: hasError ?? this.hasError,
      searchedProperties: searchedProperties ?? this.searchedProperties,
    );
  }
}

class SearchPropertyFailure extends SearchPropertyState {
  final String errorMessage;
  SearchPropertyFailure(this.errorMessage);
}

class SearchPropertyCubit extends Cubit<SearchPropertyState> {
  SearchPropertyCubit() : super(SearchPropertyInitial());

  final PropertyRepository _propertyRepository = PropertyRepository();
  Future<void> searchProperty(String query,
      {required int offset, bool? useOffset}) async {
    try {
      emit(SearchPropertyFetchProgress());
      DataOutput<Property> result =
          await _propertyRepository.searchProperty(query, offset: 0);

      emit(SearchPropertySuccess(
          searchQuery: query,
          total: result.total,
          hasError: false,
          isLoadingMore: false,
          offset: 0,
          searchedProperties: result.modelList));
    } catch (e) {
      emit(SearchPropertyFailure(e.toString()));
    }
  }

  void clearSearch() {
    if (state is SearchPropertySuccess) {
      emit(SearchPropertyInitial());
    }
  }

  Future<void> fetchMoreSearchData() async {
    try {
      if (state is SearchPropertySuccess) {
        if ((state as SearchPropertySuccess).isLoadingMore) {
          return;
        }
        emit((state as SearchPropertySuccess).copyWith(isLoadingMore: true));

        DataOutput<Property> result =
            await _propertyRepository.searchProperty(
          (state as SearchPropertySuccess).searchQuery,
          offset: (state as SearchPropertySuccess).searchedProperties.length,
        );

        SearchPropertySuccess bookingsState = (state as SearchPropertySuccess);
        bookingsState.searchedProperties.addAll(result.modelList);
        emit(
          SearchPropertySuccess(
            searchQuery: (state as SearchPropertySuccess).searchQuery,
            isLoadingMore: false,
            hasError: false,
            searchedProperties: bookingsState.searchedProperties,
            offset: (state as SearchPropertySuccess).searchedProperties.length,
            total: result.total,
          ),
        );
      }
    } catch (e) {
      emit(
        (state as SearchPropertySuccess).copyWith(
          isLoadingMore: false,
          hasError: true,
        ),
      );
    }
  }

  bool hasMoreData() {
    if (state is SearchPropertySuccess) {
      return (state as SearchPropertySuccess).searchedProperties.length <
          (state as SearchPropertySuccess).total;
    }
    return false;
  }
}
