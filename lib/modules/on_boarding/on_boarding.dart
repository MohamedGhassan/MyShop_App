import 'package:flutter/material.dart';

import 'package:shop_app/modeles/onboarding_model/onboarding_model.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/componentes/componentes.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<OnBoardingModel> items = [
    OnBoardingModel(
        image: 'assets/images/onboard.jpg', body: 'body 1', title: 'title1'),
    OnBoardingModel(
        image: 'assets/images/onboard.jpg', body: 'body 2', title: 'title2'),
    OnBoardingModel(
        image: 'assets/images/onboard.jpg', body: 'body 3', title: 'title3'),
  ];
  var boarderController = PageController();
  bool isLast = false;

  void submit() {
    CacheHelper.savetData(
        key: 'onBoardingSkip',
        value: true)
        .then((value) {
      if (value) {
        pushAndRemove(widget:
        LoginScreen(), context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [textButton(fun: submit, text: 'skip')],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageView.builder(
            onPageChanged: (index) {
              if (index == items.length - 1) {
                setState(() {
                  isLast = true;
                });
              } else {
                setState(() {
                  isLast = false;
                });
              }
            },
            controller: boarderController,
            itemBuilder: (context, index) => onBoarding(items[index]),
            physics: BouncingScrollPhysics(),
            itemCount: items.length,
          )),
    );
  }

  Widget onBoarding(OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 50),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 50),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SmoothPageIndicator(
                controller: boarderController,
                count: items.length,
                effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5),
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (isLast) {
                    submit();
                  } else {
                    boarderController.nextPage(
                      duration: Duration(milliseconds: 750),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }
                },
                child: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          )
        ],
      );
}
