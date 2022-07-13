import 'package:flutter/material.dart';
import 'package:shopping_app/screens/login_register/Login_screen.dart';
import 'package:shopping_app/shared/component/component.dart';
import 'package:shopping_app/shared/local/Colors.dart';
import 'package:shopping_app/shared/local/cash_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  var pageController = PageController();
  bool isLastPage=false;

  List<pageModel> pagesData = [
    pageModel(
      img: "assets/images/onboard_1.jpg",
      title: "Page Title 1",
      body: "Page Body 1",
    ),
    pageModel(
      img: "assets/images/onboard_1.jpg",
      title: "Page Title 2",
      body: "Page Body 2",
    ),
    pageModel(
      img: "assets/images/onboard_1.jpg",
      title: "Page Title 3",
      body: "Page Body 3",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                MyComponents.navigateAndFinish(context,  LoginScreen());
                CashHelper.saveData(key: "isBoardingScreen", value: false);
              },
              child: const Text("SKIP"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller:pageController ,
                onPageChanged: (int index){
                if(pagesData.length-1==index){
                  isLastPage=true;
                }
                },

                itemBuilder: (context, index) =>
                    pageItem(
                        context: context,
                        record: pagesData[index]),
                        itemCount: pagesData.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller:pageController,
                    count: pagesData.length,
                    effect: ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 5,
                      dotColor: Colors.grey,
                      activeDotColor: MyColors.defaultColor,
                    ) ,
                ),
                const Spacer(),
                FloatingActionButton(onPressed:(){
                  if(isLastPage){
                    MyComponents.navigateAndFinish(context,  LoginScreen());
                    CashHelper.saveData(key: "isBoardingScreen", value: false);
                  }else{
                    pageController.nextPage(duration:
                    const Duration(milliseconds: 500) ,
                        curve:Curves.fastLinearToSlowEaseIn);
                  }
                },
                 backgroundColor: MyColors.defaultColor,
                 child: const Icon(Icons.arrow_forward),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget pageItem({required BuildContext context, required pageModel record}) =>
      Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset(record.img!)),
          const SizedBox(height: 30,),
          Text(
            record.title!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 20,),
          Text(
            record.body!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 30,),
        ],
      );
}

class pageModel {
  String? img;
  String? title;
  String? body;

  pageModel({
    required this.img,
    required this.title,
    required this.body,
  });
}
