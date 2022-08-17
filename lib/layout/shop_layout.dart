import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/cart/cart_screen.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/shared/componentes/componentes.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_cubit.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('Salla'),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo( widget: SearchScreen(), context:  context);
                  },
                  icon: Icon(Icons.search),
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.star), label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings')
              ],
              onTap: (index) {
                cubit.change(index);
              },
              currentIndex: cubit.currentIndex,
            ),
            floatingActionButton: (
                CircleAvatar(
              backgroundColor: defaultColor,
              radius: 20,
              child: FloatingActionButton(onPressed: () {
                navigateTo( context: context, widget:  CartScreen ());
              },
              child:  Icon(Icons.local_grocery_store_outlined , color: Colors.grey[350],)

                ,),
            )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: cubit.screens[cubit.currentIndex],
          );
        });
  }
}
