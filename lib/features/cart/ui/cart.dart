import 'package:bloc_cart_app/features/cart/bloc/cart_bloc.dart';
import 'package:bloc_cart_app/features/cart/ui/cart_tile_widget.dart';
import 'package:bloc_cart_app/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  final CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Page"),
        actions: [
          IconButton(
              onPressed: () {
                cartBloc.add(WishlistButtonNavigateEvent());
              },
              icon: const Icon(Icons.favorite_border_outlined)),
        ],
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (state is CartItemRemovedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text("Item Removed from Cart"),
              backgroundColor: Colors.red,
            ));
          } else if (state is NavigateToWishlistPageActionState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WishlistPage(),
                ));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;

              return ListView.builder(
                itemCount: successState.cartItems.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CartTileWidget(
                      productDataModel: successState.cartItems[index],
                      cartBloc: cartBloc);
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
