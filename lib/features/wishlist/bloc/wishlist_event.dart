part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistItemRemoveEvent extends WishlistEvent {
  final ProductDataModel productDataModel;

  WishlistItemRemoveEvent(this.productDataModel);
}

class CartButtonNavigateEvent extends WishlistEvent {}
