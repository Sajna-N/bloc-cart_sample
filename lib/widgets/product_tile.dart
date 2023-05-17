import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../models/homeproduct.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  const ProductTileWidget({
    super.key,
    required this.productDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        // bloc: homeBloc,
        builder: (context, state) {
      return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(productDataModel.imageUrl))),
            ),
            const SizedBox(height: 20),
            Text(productDataModel.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(productDataModel.description),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${productDataModel.price}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (productDataModel.isCartSelected == false) {
                          context
                              .read<HomeBloc>()
                              .add(HomeProductCartButtonClickedEvent(
                                clickedProduct: productDataModel,
                              ));
                        } else {
                          context.read<HomeBloc>().add(OnCartRemove(
                                removeCart: productDataModel,
                              ));
                        }
                      },
                      icon: productDataModel.isCartSelected == true
                          ? const Icon(Icons.shopping_bag)
                          : const Icon(Icons.shopping_bag_outlined),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
