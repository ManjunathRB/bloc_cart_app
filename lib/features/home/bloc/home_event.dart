part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductWishlistButtonClickedEvent(this.clickedProduct);
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductCartButtonClickedEvent(this.clickedProduct);
}

class HometWishlistButtonNavigateEvent extends HomeEvent {}

class HometCartButtonNavigateEvent extends HomeEvent {}
