import 'package:bloc_cart_app/features/cart/ui/cart.dart';
import 'package:bloc_cart_app/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:bloc_cart_app/features/wishlist/ui/wishlist_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist Page"),
        actions: [
          IconButton(
              onPressed: () {
                wishlistBloc.add(CartButtonNavigateEvent());
              },
              icon: const Icon(Icons.shopping_bag_outlined))
        ],
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {
          if (state is WishlistItemRemovedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text("Item Removed from Wishlist"),
              backgroundColor: Colors.red,
            ));
          }
          if (state is NavigateToCartPageActionState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;

              return ListView.builder(
                itemCount: successState.cartItems.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return WishlistTileWidget(
                      productDataModel: successState.cartItems[index],
                      wishlistBloc: wishlistBloc);
                },
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
