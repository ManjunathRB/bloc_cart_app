import 'dart:async';

import 'package:bloc_cart_app/data/cart_items.dart';
import 'package:bloc_cart_app/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartItemRemoveEvent>(cartItemRemoveEvent);
    on<WishlistButtonNavigateEvent>(wishlistButtonNavigateEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems));
  }

  FutureOr<void> cartItemRemoveEvent(
      CartItemRemoveEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productDataModel);
    emit(CartItemRemovedActionState());
    emit(CartSuccessState(cartItems));
  }

  FutureOr<void> wishlistButtonNavigateEvent(
      WishlistButtonNavigateEvent event, Emitter<CartState> emit) {
    emit(NavigateToWishlistPageActionState());
  }
}
