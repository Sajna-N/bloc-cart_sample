import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './cart.dart';
import '../widgets/product_tile.dart';

import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context
        .read<HomeBloc>()
        .add(HomeInitialEvent()); //adding data to the stream
    super.initState();
  }

  // final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      // listener: (context, state) {
        // if (state is HomeNavigateToCartPageActionState) {
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => Cart()));
        //   // .then(
        //   //     (value) => context.read<HomeBloc>().add(HomeInitialEvent()));
        // } else if (state is HomeProductItemCartedActionState) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: state.isAddState == true
        //           ? Text('Item Carted')
        //           : Text('Item Removed'),
        //     ),
        //   );
        // }
      // },
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
                title: const Text('Grocery App'),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Cart()));
                      },
                      icon: const Icon(Icons.shopping_bag_outlined)),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        // homeBloc: homeBloc,
                        productDataModel: successState.products[index]);
                  }),
            );

          case HomeErrorState:
            return const Scaffold(body: Center(child: Text('Error')));
          default:
            return const SizedBox();
        }
      },
    );
  }
}
