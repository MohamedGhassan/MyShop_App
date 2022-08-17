import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/componentes/componentes.dart';
import 'package:shop_app/shared/cubits/search_cubit/search_cubit.dart';
import 'package:shop_app/shared/cubits/search_cubit/search_states.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          textLabel: 'Search',
                          controller: searchController,
                          textKeyboard: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'write a word to search..';
                            }
                            return null;
                          },
                          prefix: Icons.search,
                          onFieldSubmitted: (value) {
                            SearchCubit.get(context).search(value);
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      if (state is LoadingSearchState)
                        LinearProgressIndicator(),
                      if (state is DoneSearchState)
                        Expanded(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  buildSearchedItem(
                                      SearchCubit.get(context)
                                          .searchModel!
                                          .searchData
                                          .productsData[index],
                                      context),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 10,
                                  ),
                              itemCount: SearchCubit.get(context)
                                  .searchModel!
                                  .searchData
                                  .productsData
                                  .length),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

Widget buildSearchedItem(model, context) => Container(
      height: 140,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

                Image(
                  image: NetworkImage(model.image),
                  height: 140,
                  width: 140,
                ),

            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    " ${model.name} ",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                            fontSize: 12, height: 1.5, color: defaultColor),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),

                ]))
          ],
        ),
      ),
    );







