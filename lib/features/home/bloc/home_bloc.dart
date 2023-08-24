import 'dart:async';
import 'package:bloc_cart_app/data/cart_items.dart';
import 'package:bloc_cart_app/data/grocery_data.dart';
import 'package:bloc_cart_app/data/wishlist_items.dart';
import 'package:bloc_cart_app/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HometWishlistButtonNavigateEvent>(
        hometWishlistButtonNavigateClickedEvent);
    on<HometCartButtonNavigateEvent>(hometCartButtonNavigateClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(GroceryData.groceryProducts
        .map((e) => ProductDataModel(
            e['id'], e['name'], e['description'], e['price'], e['imageUrl']))
        .toList()));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    wishlistItems.add(event.clickedProduct);
    emit(ItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    cartItems.add(event.clickedProduct);
    emit(ItemCartedActionState());
  }

  FutureOr<void> hometWishlistButtonNavigateClickedEvent(
      HometWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> hometCartButtonNavigateClickedEvent(
      HometCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartPageActionState());
  }
}
