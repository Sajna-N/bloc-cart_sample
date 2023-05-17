part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;
  final List<ProductDataModel> carts;
  HomeLoadedSuccessState(
      {this.products = const <ProductDataModel>[],
      this.carts = const <ProductDataModel>[]});
}

class HomeErrorState extends HomeState {}
