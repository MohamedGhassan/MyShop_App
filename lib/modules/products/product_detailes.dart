import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/shared/componentes/componentes.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_cubit.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_states.dart';
import 'package:shop_app/shared/styles/colors.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        var product = cubit.productDetailsModel!.productModel;
        var pageController = PageController();
        String productPrice = product.price.toString();
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
          state is! ShopLoadingGetProductDetailsState && product != null,
          widgetBuilder: (context) => Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 400,
                        color: Colors.white,
                        child: PageView.builder(
                          controller: pageController,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                              child: Image.network(
                                '${product.images[index]}',
                              ),
                            );
                          },
                          physics: BouncingScrollPhysics(),
                          itemCount: product.images.length,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.deepPurple,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: product.images.length,
                    effect: SlideEffect(
                      activeDotColor: Colors.deepPurple,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            productPrice.length == 5
                                                ? '${productPrice.substring(0, 2)},${productPrice.substring(2, productPrice.length)} L.E'
                                                : '$productPrice L.E',
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepPurple,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          if (product.discount != 0)
                                            Text(
                                              '${product.oldPrice} L.E',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                TextDecoration.lineThrough,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 5.0, top: 5.0),
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.deepPurpleAccent),
                                          color: Colors.grey[200],
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              cubit.favorite[product.id]!
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                            ),
                                            color: cubit.favorite[product.id]!
                                                ? defaultColor
                                                : Colors.grey,
                                            onPressed: () {
                                              cubit.changeFavorite(product.id);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: defaultColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    height: 120.0,
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Text(
                                        product.description,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: buildAddToCartButton(
                            label: 'Add to cart',
                            onPressed: () {


                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ),
          fallbackBuilder: (context) => Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
