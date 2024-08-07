// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:ebroker/data/Repositories/property_repository.dart';
import 'package:ebroker/data/model/data_output.dart';
import 'package:ebroker/data/model/property_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/Property.dart';
import '../../../utils/hive_utils.dart';

abstract class FetchMyPropertiesState {}

class FetchMyPropertiesInitial extends FetchMyPropertiesState {}

class FetchMyPropertiesInProgress extends FetchMyPropertiesState {}

class FetchMyPropertiesSuccess extends FetchMyPropertiesState {
  final int total;
  final int offset;
  final bool isLoadingMore;
  final bool hasError;
  final List<Property> myProperty;
  FetchMyPropertiesSuccess({
    required this.total,
    required this.offset,
    required this.isLoadingMore,
    required this.hasError,
    required this.myProperty,
  });

  FetchMyPropertiesSuccess copyWith({
    int? total,
    int? offset,
    bool? isLoadingMore,
    bool? hasMoreData,
    List<Property>? myProperty,
  }) {
    return FetchMyPropertiesSuccess(
      total: total ?? this.total,
      offset: offset ?? this.offset,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasError: hasMoreData ?? hasError,
      myProperty: myProperty ?? this.myProperty,
    );
  }
}

class FetchMyPropertiesFailure extends FetchMyPropertiesState {
  final dynamic errorMessage;

  FetchMyPropertiesFailure(this.errorMessage);
}

class FetchMyPropertiesCubit extends Cubit<FetchMyPropertiesState> {
  FetchMyPropertiesCubit() : super(FetchMyPropertiesInitial());

  final PropertyRepository _propertyRepository = PropertyRepository();
  Future<void> fetchMyProperties({
    required String type,
  }) async {
    try {
      emit(FetchMyPropertiesInProgress());
      DataOutput<Property> result =
          await _propertyRepository.fetchFavoritesByBrokerId(offset: 0, brokerId: HiveUtils.getUserId());
      log("MY PROPERTIES RESULT ${result.total}");
      emit(FetchMyPropertiesSuccess(
          hasError: false,
          isLoadingMore: false,
          myProperty: result.modelList,
          total: result.total,
          offset: 0));
    } catch (e) {
      emit(FetchMyPropertiesFailure(e));
    }
  }

  // void updateStatus(int propertyId, String currentType) {
  //   try {
  //     if (state is FetchMyPropertiesSuccess) {
  //       List<Property> propertyList =
  //           (state as FetchMyPropertiesSuccess).myProperty;
  //       int index = propertyList.indexWhere((element) {
  //         return element.id == propertyId;
  //       });
  //
  //       if (currentType == "Sell") {
  //         propertyList[index].properyType = "Sold";
  //       }
  //       if (currentType == "Rent") {
  //         propertyList[index].properyType = "Rented";
  //       }
  //
  //       if (currentType == "Rented") {
  //         propertyList[index].properyType = "Rent";
  //       }
  //       if (kDebugMode) {
  //         if (currentType == "Sold") {
  //           propertyList[index].properyType = "Sell";
  //         }
  //       }
  //
  //       emit((state as FetchMyPropertiesSuccess)
  //           .copyWith(myProperty: propertyList));
  //     }
  //   } catch (e) {
  //     log("#--this has error");
  //   }
  // }

  void update(Property model) {
    if (state is FetchMyPropertiesSuccess) {
      List<Property> properties =
          (state as FetchMyPropertiesSuccess).myProperty;

      var index = properties.indexWhere((element) => element.id == model.id);

      if (index != -1) {
        properties[index] = model;
      }

      emit(
          (state as FetchMyPropertiesSuccess).copyWith(myProperty: properties));
    }
  }

  Future<void> fetchMoreProperties({required String type}) async {
    try {
      if (state is FetchMyPropertiesSuccess) {
        if ((state as FetchMyPropertiesSuccess).isLoadingMore) {
          return;
        }
        emit((state as FetchMyPropertiesSuccess).copyWith(isLoadingMore: true));

        DataOutput<Property> result =
            await _propertyRepository.fetchFavoritesByBrokerId(
                offset: (state as FetchMyPropertiesSuccess).myProperty.length, brokerId: HiveUtils.getUserId());

        FetchMyPropertiesSuccess bookingsState =
            (state as FetchMyPropertiesSuccess);
        bookingsState.myProperty.addAll(result.modelList);
        emit(
          FetchMyPropertiesSuccess(
            isLoadingMore: false,
            hasError: false,
            myProperty: bookingsState.myProperty,
            offset: (state as FetchMyPropertiesSuccess).myProperty.length,
            total: result.total,
          ),
        );
      }
    } catch (e) {
      emit(
        (state as FetchMyPropertiesSuccess).copyWith(
          isLoadingMore: false,
          hasMoreData: true,
        ),
      );
    }
  }

  void addLocal(Property model) {
    try {
      if (state is FetchMyPropertiesSuccess) {
        List<Property> myProperty =
            (state as FetchMyPropertiesSuccess).myProperty;
        if (myProperty.isNotEmpty) {
          myProperty.insert(0, model);
        } else {
          myProperty.add(model);
        }

        emit((state as FetchMyPropertiesSuccess)
            .copyWith(myProperty: myProperty));
      }
    } catch (e, st) {
      throw st;
    }
  }

  bool hasMoreData() {
    if (state is FetchMyPropertiesSuccess) {
      return (state as FetchMyPropertiesSuccess).myProperty.length <
          (state as FetchMyPropertiesSuccess).total;
    }
    return false;
  }
}
