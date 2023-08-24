import 'package:bloc_cart_app/features/cart/ui/cart.dart';
import 'package:bloc_cart_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_cart_app/features/home/ui/product_tile_widget.dart';
import 'package:bloc_cart_app/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WishlistPage(),
              ));
        } else if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ));
        } else if (state is ItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 500),
            content: Text('Item Wishlisted'),
            backgroundColor: Colors.green,
          ));
        } else if (state is ItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 500),
            content: Text('Item Added to Cart'),
            backgroundColor: Colors.green,
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Bloc Grocery App"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HometWishlistButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.favorite_border_outlined)),
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HometCartButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.shopping_bag_outlined))
                  ],
                ),
                body: ListView.builder(
                  itemCount: successState.products.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        homeBloc: homeBloc,
                        productDataModel: successState.products[index]);
                  },
                ));
          case HomeErrorState:
            return const Scaffold(
              body: Center(child: Text("Error")),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
