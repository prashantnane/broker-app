// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ebroker/data/model/user_model.dart';
import 'package:ebroker/utils/hive_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/Broker.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit()
      : super(UserDetailsState(
            user: HiveUtils.isGuest() ? null : HiveUtils.getUserDetails()));

  void fill(Broker model) {
    emit(UserDetailsState(user: model));
  }

  void copy(Broker model) {
    emit(state.copyWith(user: model));
  }

  void clear() {
    emit(UserDetailsState(user: null));
  }
}

class UserDetailsState {
  final Broker? user;
  UserDetailsState({
    required this.user,
  });

  UserDetailsState copyWith({
    Broker? user,
  }) {
    return UserDetailsState(
      user: user ?? this.user,
    );
  }
}
