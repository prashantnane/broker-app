import 'dart:developer';

import 'package:ebroker/Ui/screens/proprties/viewAll.dart';
import 'package:ebroker/data/Repositories/property_repository.dart';
import 'package:ebroker/data/model/data_output.dart';
import 'package:ebroker/data/model/property_model.dart';
import 'package:ebroker/test_page/viewAllTest.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../settings.dart';
import '../../../utils/Network/networkAvailability.dart';
import '../models/Property.dart';

abstract class FetchAllPropertiesState {}

class FetchAllProepertiesInitial extends FetchAllPropertiesState {}

class FetchAllPropertiesInProgress extends FetchAllPropertiesState {}

class FetchAllPropertiesSuccess extends FetchAllPropertiesState
    implements PropertySuccessStateWireframeTest {
  final int total;
  final int offset;
  @override
  final bool isLoadingMore;
  final bool hasError;
  // @override
  final List<Property?> properties;

  FetchAllPropertiesSuccess({
    required this.total,
    required this.offset,
    required this.isLoadingMore,
    required this.hasError,
    required this.properties,
  });

  FetchAllPropertiesSuccess copyWith({
    int? total,
    int? offset,
    bool? isLoadingMore,
    bool? hasError,
    List<Property?>? properties,
  }) {
    return FetchAllPropertiesSuccess(
      total: total ?? this.total,
      offset: offset ?? this.offset,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasError: hasError ?? this.hasError,
      properties: properties ?? this.properties,
    );
  }

  @override
  set properties(List<Property?> _properties) {
    // TODO: implement properties
  }

  @override
  set isLoadingMore(bool _isLoadingMore) {
    // TODO: implement isLoadingMore
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'offset': offset,
      'isLoadingMore': isLoadingMore,
      'hasError': hasError,
      'properties': properties.map((e) => e?.toMap()).toList(),
    };
  }

  factory FetchAllPropertiesSuccess.fromMap(Map<String, dynamic> map) {
    return FetchAllPropertiesSuccess(
      total: map['total'] as int,
      offset: map['offset'] as int,
      isLoadingMore: map['isLoadingMore'] as bool,
      hasError: map['hasError'] as bool,
      properties: List<Property>.from(map['properties']?.map((x) => Property.fromJson(x))),
    );
  }
}


class FetchAllPropertiesFailur extends FetchAllPropertiesState
    implements PropertyErrorStateWireframe {
  final dynamic error;

  FetchAllPropertiesFailur(this.error);

  @override
  set error(_error) {}
}

class FetchAllPropertiesCubit extends Cubit<FetchAllPropertiesState>
    with PropertyCubitWireframe, HydratedMixin {
  FetchAllPropertiesCubit() : super(FetchAllProepertiesInitial());

  final PropertyRepository _propertyRepository = PropertyRepository();
  @override
  void fetch({bool? forceRefresh, bool? loadWithoutDelay}) async {
    print('inside fetch fn of FetchAllProp');
    try {
      if (forceRefresh != true) {
        if (state is FetchAllPropertiesSuccess) {
          // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await Future.delayed(Duration(
              seconds: loadWithoutDelay == true
                  ? 0
                  : AppSettings.hiddenAPIProcessDelay));
          // });
        } else {
          emit(FetchAllPropertiesInProgress());
        }
      } else {
        emit(FetchAllPropertiesInProgress());
      }

      // if(forceRefresh==true){
      //
      //
      // }else{
      //   if(state is! FetchAllPropertiesSuccess){
      //
      //   }else{
      //
      //   }
      // }
      if (forceRefresh == true) {
        DataOutput<Property?> result =
        await _propertyRepository.fetchAllProperties(offset: 0);
        // log("API RESULT IS $result");
        emit(
          FetchAllPropertiesSuccess(
              total: result.total,
              offset: 0,
              isLoadingMore: false,
              hasError: false,
              properties: result.modelList),
        );
      } else {
        if (state is! FetchAllPropertiesSuccess) {
          DataOutput<Property?> result =
          await _propertyRepository.fetchAllProperties(offset: 0);
          emit(
            FetchAllPropertiesSuccess(
                total: result.total,
                offset: 0,
                isLoadingMore: false,
                hasError: false,
                properties: result.modelList),
          );
        } else {
          await CheckInternet.check(
            onInternet: () async {
              DataOutput<Property?> result =
              await _propertyRepository.fetchAllProperties(offset: 0);
              emit(
                FetchAllPropertiesSuccess(
                    total: result.total,
                    offset: 0,
                    isLoadingMore: false,
                    hasError: false,
                    properties: result.modelList),
              );
            },
            onNoInternet: () {
              emit(
                FetchAllPropertiesSuccess(
                    total: (state as FetchAllPropertiesSuccess).total,
                    offset: (state as FetchAllPropertiesSuccess).offset,
                    isLoadingMore:
                    (state as FetchAllPropertiesSuccess).isLoadingMore,
                    hasError: (state as FetchAllPropertiesSuccess).hasError,
                    properties:
                    (state as FetchAllPropertiesSuccess).properties),
              );
            },
          );
        }
      }
    } catch (e) {
      log("ISSUE IS $e");
      emit(FetchAllPropertiesFailur(e.toString()));
    }
  }

  @override
  void fetchMore() async {
    if (state is FetchAllPropertiesSuccess) {
      FetchAllPropertiesSuccess mystate =
      (state as FetchAllPropertiesSuccess);
      if (mystate.isLoadingMore) {
        return;
      }
      emit((state as FetchAllPropertiesSuccess)
          .copyWith(isLoadingMore: true));
      DataOutput<Property?> result =
      await _propertyRepository.fetchAllProperties(
        offset: (state as FetchAllPropertiesSuccess).properties.length,
      );
      FetchAllPropertiesSuccess propertyState =
      (state as FetchAllPropertiesSuccess);
      propertyState.properties.addAll(result.modelList);
      emit(FetchAllPropertiesSuccess(
          isLoadingMore: false,
          hasError: false,
          properties: propertyState.properties,
          offset: (state as FetchAllPropertiesSuccess).properties.length,
          total: result.total));
    }
  }

  @override
  bool hasMoreData() {
    if (state is FetchAllPropertiesSuccess) {
      log("HAS MORE DATA CALLED ${(state as FetchAllPropertiesSuccess).properties.length} & ${(state as FetchAllPropertiesSuccess).total}");

      return (state as FetchAllPropertiesSuccess).properties.length <
          (state as FetchAllPropertiesSuccess).total;
    }
    return false;
  }

  @override
  FetchAllPropertiesState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['cubit_state'] == "FetchAllPropertiesSuccess") {
        FetchAllPropertiesSuccess fetchAllPropertiesSuccess =
        FetchAllPropertiesSuccess.fromMap(json);

        return fetchAllPropertiesSuccess;
      }
    } catch (e, st) {
      log("ERROR WHILE lOAD JSON TO MODEL $st");
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(FetchAllPropertiesState state) {
    try {
      if (state is FetchAllPropertiesSuccess) {
        Map<String, dynamic> mapped = state.toMap();
        mapped['cubit_state'] = "FetchAllPropertiesSuccess";
        return mapped;
      }
    } catch (e) {
      log("ISSUE ISSSS $e");
    }

    return null;
  }
}
