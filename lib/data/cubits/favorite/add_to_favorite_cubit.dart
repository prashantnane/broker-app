// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ebroker/data/Repositories/favourites_repository.dart';

import '../../../utils/constant.dart';
import 'remove_favoriteubit.dart';

enum FavoriteType {
  add("1"),
  remove("0");

  final String value;

  const FavoriteType(this.value);
}

abstract class AddToFavoriteCubitState {}

class AddToFavoriteCubitInitial extends AddToFavoriteCubitState {}

class AddToFavoriteCubitInProgress extends AddToFavoriteCubitState {}

class AddToFavoriteCubitSuccess extends AddToFavoriteCubitState {
  final String id;
  final FavoriteType favorite;
  AddToFavoriteCubitSuccess({
    required this.favorite,
    required this.id,
  });
}

class AddToFavoriteCubitFailure extends AddToFavoriteCubitState {
  final String errorMessage;

  AddToFavoriteCubitFailure(this.errorMessage);
}

class AddToFavoriteCubitCubit extends Cubit<AddToFavoriteCubitState> {
  AddToFavoriteCubitCubit() : super(AddToFavoriteCubitInitial());

  final FavoriteRepository _favouriteRepository = FavoriteRepository(brokerId: '');

  Future<void> setFavroite({
    required String propertyId,
    required FavoriteType type,
  }) async {
    try {
      emit(AddToFavoriteCubitInProgress());
      if (type == FavoriteType.add) {
      await _favouriteRepository.addToFavorite(propertyId);
        Constant.favoritePropertyList.add((propertyId));
      } else {
        await _favouriteRepository.removeFavorite(propertyId);
        Constant.favoritePropertyList.remove((propertyId));
      }
      emit(AddToFavoriteCubitSuccess(id: propertyId, favorite: type));
    } catch (e) {
      emit(AddToFavoriteCubitFailure(e.toString()));
    }
  }
}
