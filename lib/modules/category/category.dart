import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modeles/categories_model/categories.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_cubit.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_states.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => rowBuild(ShopAppCubit.get(context)
                .categoryModel!
                .categoryData!
                .dataInfo[index]),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: ShopAppCubit.get(context)
                .categoryModel!
                .categoryData!
                .dataInfo
                .length);
      },
    );
  }
}

Widget rowBuild(DataInfo model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Image(
              image: NetworkImage(
                '${model.image}',
              ),
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            '${model.name}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          Spacer(),
          Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
