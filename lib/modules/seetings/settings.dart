import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/modules/seetings/about_us.dart';
import 'package:shop_app/modules/seetings/terms.dart';
import 'package:shop_app/modules/seetings/user_information.dart';

import 'package:shop_app/shared/componentes/componentes.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_cubit.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_states.dart';

class SettingsScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopAppCubit.get(context).userModel;
        if (model != null) {
          nameController.text = model.data!.name;
          emailController.text = model.data!.email;
          phoneController.text = model.data!.phone;
        }

        var formKey = GlobalKey<FormState>();
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => model != null,
          widgetBuilder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  AssetImage('assets/images/user_image.png')),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(model!.data!.name),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  model.data!.email,
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 15),
                                ),
                                textButton(
                                    text:
                                        'Click Here To Show Your Data And Update It ',
                                    fun: () {
                                      navigateTo(
                                          widget: UserScreen(),
                                          context: context);
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  defaultButton(
                    text: 'Log out',
                    fun: () {
                      signOut(context);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textButton(
                          text: 'About US ',
                          fun: () {
                            navigateTo(widget: AboutUs(), context: context);
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      textButton(
                          text: 'Our Terms ',
                          fun: () {
                            navigateTo(widget: Terms(), context: context);
                          }),
                    ],
                  )),
                ],
              ),
            ),
          ),
          fallbackBuilder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
