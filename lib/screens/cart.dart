import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/cart_tile.dart';

import '../bloc/home_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        // bloc: cartBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case HomeLoadedSuccessState:
              final successState = state as HomeLoadedSuccessState;
              return ListView.builder(
                  itemCount: successState.carts.length,
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                        // homeBloc: homeBloc,
                        productDataModel: successState.carts[index]);
                  });

            case HomeErrorState:
              return const  Center(child: Text('Error'));
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
