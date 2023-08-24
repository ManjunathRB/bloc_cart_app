import 'dart:async';

import 'package:bloc_cart_app/data/wishlist_items.dart';
import 'package:bloc_cart_app/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistItemRemoveEvent>(wishlistItemRemoveEvent);
    on<CartButtonNavigateEvent>(cartButtonNavigateEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItems));
  }

  FutureOr<void> wishlistItemRemoveEvent(
      WishlistItemRemoveEvent event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.productDataModel);
    emit(WishlistItemRemovedActionState());
    emit(WishlistSuccessState(wishlistItems));
  }

  FutureOr<void> cartButtonNavigateEvent(
      CartButtonNavigateEvent event, Emitter<WishlistState> emit) {
    emit(NavigateToCartPageActionState());
  }
}
