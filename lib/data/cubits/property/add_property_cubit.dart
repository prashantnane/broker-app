// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';
import 'dart:io';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_common/vm.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/Property.dart';
import '../../../utils/helper_utils.dart';
import '../../../utils/ui_utils.dart';
import '../../helper/widgets.dart';
import '../../model/property_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_webservice/directions.dart';

import '../../../utils/api.dart';

abstract class AddPropertyState {}

class AddPropertyInitial extends AddPropertyState {}

class AddPropertyProgress extends AddPropertyState {}

class AddPropertySuccess extends AddPropertyState {
  List<Property> propertylist = [];

  AddPropertySuccess(this.propertylist);
}

class AddPropertyFailure extends AddPropertyState {
  final String errmsg;

  AddPropertyFailure(this.errmsg);
}

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit() : super(AddPropertyInitial());

  void addProperty(BuildContext context, Property property) {
    emit(AddPropertyProgress());
    addPropertyToDb(property).then((success) {
      if (success) {
        Widgets.showLoader(context);
        HelperUtils.showSnackBarMessage(
            context, UiUtils.getTranslatedLabel(context, "propertyAdded"),
            type: MessageType.success, onClose: () {
          Navigator.of(context)
            ..pop()
            ..pop()
            ..pop()
            ..pop()
            ..pop();
        });
      } else if (!success) {
        // Widgets.hideLoder(context);
        HelperUtils.showSnackBarMessage(context, 'Failed to add Property',
            type: MessageType.error);
      }
    }).catchError((e, st) => emit(AddPropertyFailure(st.toString())));
    emit(AddPropertyProgress());
  }

  Future<String?> uploadFileToS3(String filePath, String s3Key) async {
    try {
      final localFile = File(filePath);

      // Upload file to S3
      final result = await Amplify.Storage.uploadFile(
        key: s3Key, // Unique key for your S3 object
        localFile: AWSFilePlatform.fromFile(localFile),
      );

      print('File uploaded to S3 successfully.');
      return result.operationId;
    } catch (e) {
      print('Error uploading file to S3: $e');
    }
    
  }

  Future<bool> addPropertyToDb(Property property) async {
    print('listening to addPropertyToDb');
    bool success = false;
    try {
      final request = ModelMutations.create(property);
      final response = await Amplify.API.mutate(request: request).response;
      final propertyData = response.data;
      final statuscode = response.hasErrors;
      print('this is propertyDtat: $propertyData');
      if (propertyData == null) {
        safePrint('errors: ${response.errors}');
      } else {
        safePrint('Mutation result: ${propertyData.id}');
      }
      success = true;
    } on Exception catch (error) {
      debugPrint(
        error.toString(),
      );
    }
    return success;
  }
}
