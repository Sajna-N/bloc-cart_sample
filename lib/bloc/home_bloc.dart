import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/groccery_items.dart';
import '../models/homeproduct.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<OnCartRemove>(onCartRemove);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map(
              (e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                imageUrl: e['imageUrl'],
              ),
            )
            .toList()));
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    final state = this.state;
    final clickedProduct = event.clickedProduct;

    if (state is HomeLoadedSuccessState) {
      final int index = state.products.indexOf(clickedProduct);
      List<ProductDataModel> allProducts = List.from(state.products)
        ..remove(clickedProduct);
      clickedProduct.isCartSelected == false
          ? allProducts.insert(
              index, clickedProduct.copyWith(isCartSelected: true))
          : allProducts.insert(
              index, clickedProduct.copyWith(isCartSelected: false));
      emit(HomeLoadedSuccessState(
        products: allProducts,
        carts: allProducts
            .where((element) => element.isCartSelected == true)
            .toList(),
      ));
    }
  }

  FutureOr<void> onCartRemove(OnCartRemove event, Emitter<HomeState> emit) {
    final state = this.state;
    final removeCart = event.removeCart;

    if (state is HomeLoadedSuccessState) {
      final int index = state.products.indexOf(removeCart);

      List<ProductDataModel> allProducts = List.from(state.products)
        ..remove(removeCart);
      removeCart.isCartSelected == true
          ? allProducts.insert(
              index, removeCart.copyWith(isCartSelected: false))
          : allProducts.insert(
              index, removeCart.copyWith(isCartSelected: true));

      emit(
        HomeLoadedSuccessState(
            products: allProducts,
            carts: List.from(state.carts)..remove(removeCart)),
      );
    }
  }
}
