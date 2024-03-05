// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';

import '../../model/property_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_webservice/directions.dart';

import '../../../utils/api.dart';

abstract class AddPropertyState {}

class AddPropertyInitial extends AddPropertyState {}

class AddPropertyProgress extends AddPropertyState {}

class AddPropertySuccess extends AddPropertyState {
  List<PropertyModel> propertylist = [];
  int total = 0;
  AddPropertySuccess(this.propertylist, this.total);
}

class AddPropertyFailure extends AddPropertyState {
  final String errmsg;
  AddPropertyFailure(this.errmsg);
}

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit() : super(AddPropertyInitial());

  void addProperty(BuildContext context, Map<String, dynamic> mbodyparam,
      {bool fromUserlist = false}) {
    emit(AddPropertyProgress());
    addPropertyToDb(context, mbodyparam, fromUserlist: fromUserlist)
        .then((value) {
      emit(AddPropertySuccess(value['list'], value['total']));
    }).catchError((e, st) => emit(AddPropertyFailure(st.toString())));
  }

  Future<Map> addPropertyToDb(
      BuildContext context,
      Map<String, dynamic> bodyparam, {
        bool fromUserlist = false,
      }) async {
    //String? propertyId,
    Map result = {};
    List<PropertyModel> propertylist = [];
    int mtotal = 0;
    var response = await Api.post(url: Api.apiGetProprty, parameter: {});
    // log("server data $map");
    // var response = await HelperUtils.sendApiRequest(
    //   Api.apiGetProprty,
    //   bodyparam,
    //   true,
    //   context,
    //   passUserid: fromUserlist,
    // );
    // var getdata = json.decode(response);
    List list = response['data'];
    log(response.toString(), name: "serrrrr");
    mtotal = response["total"];
    result['total'] = mtotal;
    propertylist = list.map((model) => PropertyModel.fromMap(model)).toList();

    result['list'] = propertylist;
    return result;
  }
}

