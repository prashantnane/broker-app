// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/hive_utils.dart';
import '../../Repositories/favourites_repository.dart';

abstract class RemoveFavoriteState {}

class RemoveFavoriteInitial extends RemoveFavoriteState {}

class RemoveFavoriteInProgress extends RemoveFavoriteState {}

class RemoveFavoriteSuccess extends RemoveFavoriteState {
  final String id;
  RemoveFavoriteSuccess({
    required this.id,
  });
}

class RemoveFavoriteFailure extends RemoveFavoriteState {
  final String errorMessage;

  RemoveFavoriteFailure(this.errorMessage);
}

class RemoveFavoriteCubit extends Cubit<RemoveFavoriteState> {
  final FavoriteRepository _favoriteRepository = FavoriteRepository(brokerId: HiveUtils.getUserDetails().id);

  RemoveFavoriteCubit() : super(RemoveFavoriteInitial());

  void remove(String propertyID) async {
    try {
      emit(RemoveFavoriteInProgress());
      await _favoriteRepository.removeFavorite(propertyID);
      emit(RemoveFavoriteSuccess(id: propertyID));
    } catch (e) {
      emit(RemoveFavoriteFailure(e.toString()));
    }
  }
}
