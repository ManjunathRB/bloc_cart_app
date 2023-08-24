part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> cartItems;

  WishlistSuccessState(this.cartItems);
}

class WishlistItemRemovedActionState extends WishlistActionState {}

class NavigateToCartPageActionState extends WishlistActionState {}
