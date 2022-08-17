import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop_app/modeles/categories_model/categories.dart';
import 'package:shop_app/modeles/home_model/home_model.dart';
import 'package:shop_app/shared/componentes/componentes.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_cubit.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ChangeFavoriteSuccessState) {
          if (!(state.favoritesModel.status!)) {
            toast(state: ToastState.Error, text: state.favoritesModel.message!);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              cubit.homeModel != null && cubit.categoryModel != null,
          widgetBuilder: (context) => pageBuilder(cubit.homeModel, context),
          fallbackBuilder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget pageBuilder(HomeModel? model, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data.banners
                .map((e) => ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        image: NetworkImage('${e.image}'),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              height: 200.0,
              autoPlay: true,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.easeInBack,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                categoryBuilder(ShopAppCubit.get(context).categoryModel),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Products",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1 / 1.9,
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              children: List.generate(
                  model.data.products.length,
                  (index) =>
                      productBuilder(model.data.products[index], context)),
            ),
          )
        ],
      ),
    );
  }
}

Widget productBuilder(ProductModel model, context) => Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  height: 200,
                  width: double.infinity,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'Discount ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
              ],
            ),
            Text(
              " ${model.name}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  " ${model.price.round()} ",
                  style:
                      TextStyle(fontSize: 12, height: 1.5, color: defaultColor),
                ),
                SizedBox(width: 5),
                if (model.discount != 0)
                  Text(
                    " ${model.oldPrice.round()}",
                    style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: ShopAppCubit.get(context).favorite[model.id]!
                      ? defaultColor
                      : Colors.grey,
                  radius: 15,
                  child: IconButton(
                    onPressed: () {
                      ShopAppCubit.get(context).changeFavorite(model.id);
                      print(model.id);
                    },
                    icon: Icon(
                      Icons.star_border_outlined,
                      color: Colors.white,
                    ),
                    iconSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            defaultButton(
                text: 'Add to cart',
                fun: () {
                  ShopAppCubit.get(context).addCarts(model.id);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Added to cart successfully!'),
                    padding: EdgeInsetsDirectional.all(20),
                    duration: Duration(milliseconds: 800),
                  ));
                },
                isUpper: true),
          ],
        ),
      ),
    );

Widget categoryBuilder(CategoryModel? model) => Container(
      height: 100,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildCategoryItem(model!.categoryData!.dataInfo[index]),
          separatorBuilder: (context, index) => SizedBox(
                width: 25,
              ),
          itemCount: model!.categoryData!.dataInfo.length),
    );

Widget buildCategoryItem(DataInfo model) => Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          fit: BoxFit.cover,
          height: 100,
          width: 100,
        ),
        Container(
            width: 100,
            color: Colors.black.withOpacity(.6),
            child: Text(
              '${model.name}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ))
      ],
    );
