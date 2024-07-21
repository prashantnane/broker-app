import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubits/Utility/like_properties.dart';
import '../../../data/cubits/favorite/add_to_favorite_cubit.dart';
import '../../../data/cubits/favorite/remove_favoriteubit.dart';
import '../../../data/model/property_model.dart';
import '../../../models/Property.dart';
import '../../../utils/AppIcon.dart';
import '../../../utils/Extensions/extensions.dart';
import '../../../utils/guestChecker.dart';
import '../../../utils/ui_utils.dart';

//This like button is used in app for favorite feature, it is used in all propery so it is very important
class LikeButtonWidgetTest extends StatefulWidget {
  final Property? property;
  final Function(FavoriteType type)? onLikeChanged;
  final Function(AddToFavoriteCubitState state)? onStateChange;
  const LikeButtonWidgetTest({
    super.key,
    required this.property,
    this.onStateChange,
    this.onLikeChanged,
  });

  @override
  State<LikeButtonWidgetTest> createState() => _LikeButtonWidgetTestState();
}

class _LikeButtonWidgetTestState extends State<LikeButtonWidgetTest> {
  @override
  void initState() {
    //checking is property is already favorite , it will come in api
    if (GuestChecker.value != true) {
      if (widget.property!.isFavourite == 1 &&
          context
                  .read<LikedPropertiesCubit>()
                  .state
                  .liked
                  .contains(widget.property!.id) ==
              false) {
        if (!context
            .read<LikedPropertiesCubit>()
            .getRemovedLikes()!
            .contains(widget.property!.id)) {
          context.read<LikedPropertiesCubit>().add(widget.property!.id);
        }
      }
    }

    super.initState();
  }

//this is main like button method
  Widget setFavorite(Property property, BuildContext context) {
    return BlocConsumer<AddToFavoriteCubitCubit, AddToFavoriteCubitState>(
      listener: (BuildContext context, AddToFavoriteCubitState state) {
        widget.onStateChange?.call(state);
        if (state is AddToFavoriteCubitFailure) {
          log("Hello thiss ${state.errorMessage}");
        }
        if (state is AddToFavoriteCubitSuccess) {
          //callback
          widget.onLikeChanged?.call(state.favorite);

          // if it is already added then we'll remove it, otherwise we'll add it into the local list
          context.read<LikedPropertiesCubit>().changeLike(state.id);
        }
      },
      builder: (BuildContext context, AddToFavoriteCubitState favoriteState) {
        return GestureDetector(
          onTap: () {
            GuestChecker.check(onNotGuest: () {
              // checking if added then remove or else add it
              FavoriteType favoriteType;

              bool contains = context
                  .read<LikedPropertiesCubit>()
                  .state
                  .liked
                  .contains(property.id);

              if (contains == true || property.isFavourite == 1) {
                favoriteType = FavoriteType.remove;
              } else {
                favoriteType = FavoriteType.add;
              }

              context.read<AddToFavoriteCubitCubit>().setFavroite(
                propertyId: property.id,
                type: favoriteType,
              );
            });
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: context.color.primaryColor,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(33, 0, 0, 0),
                    offset: Offset(0, 2),
                    blurRadius: 15,
                    spreadRadius: 0
                )
              ],
            ),
            child: BlocBuilder<LikedPropertiesCubit, LikedPropertiesState>(
              builder: (context, state) {
                return Center(
                    child: (favoriteState is AddToFavoriteCubitInProgress)
                        ? UiUtils.progress(width: 20, height: 20)
                        : state.liked.contains(widget.property!.id)
                        ? UiUtils.getSvg(
                      AppIcons.like_fill,
                      color: context.color.teritoryColor,
                    )
                        : UiUtils.getSvg(AppIcons.like,
                        color: context.color.teritoryColor)
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return setFavorite(widget.property!, context);
  }
}
