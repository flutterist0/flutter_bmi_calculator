// import 'dart:ffi';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/views/calculate_page.dart';
import 'package:flutter_bmi_calculator/views/category_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';


class ResultPage extends StatefulWidget {
  final double currentSliderValue;
  final double counter1;
  const ResultPage({
    super.key,
    required this.currentSliderValue,
    required this.counter1,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    double result = (widget.counter1 / pow(widget.currentSliderValue / 100, 2));
    String textToShow = '';

    if (result <= 18.5) {
      textToShow = 'Weak';
    } else if (result > 18.5 && result <= 24.9) {
      textToShow = 'Normal';
    } else if (result >= 25 && result <= 29.9) {
      textToShow = 'Overweight';
    } else if (result >= 30 && result <= 34.9) {
      textToShow = 'Fat (obesity class 1)';
    } else if (result >= 35 && result <= 39.9) {
      textToShow = 'Overweight (obesity class 2)';
    } else {
      textToShow = 'Extremely obese \n(obesity class 3)';
    }

    Color getColorForBMIResult(String result) {
      switch (textToShow) {
        case 'Weak':
          return Colors.blue;
        case 'Normal':
          return Colors.green;
        case 'Overweight':
          return Colors.yellow;
        case 'Fat (obesity class 1)':
          return Colors.orange;
        case 'Overweight (obesity class 2)':
          return Colors.redAccent;
        default:
          return Colors.red;
      }
    }
    Color color = getColorForBMIResult(result.toString());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Result',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 50.sp),
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your result',
                    style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  width: 130.w,
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageAnimationTransition(
                          page: const CategoryPage(),
                          pageAnimationType: FadeAnimationTransition(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(235, 250, 12, 39)),
                        
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Container(
              width: double.infinity,
              height: 500.h,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(29, 30, 51, 255),
                  borderRadius: BorderRadius.all(Radius.circular(30.sp))),
              child: Column(
                children: [
                  SizedBox(
                    height: 100.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      result.toStringAsFixed(2),
                      style: TextStyle(color: Colors.white, fontSize: 40.sp),
                    ),
                  ),
                  SizedBox(
                    height: 50.sp,
                  ),
                  Padding(
                    padding:  EdgeInsets.all(8.sp),
                    child: Text(
                      textToShow,
                      style: TextStyle(color: color, fontSize: 25.sp),
                    ),
                  ),
                  SizedBox(
                    height: 50.sp,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              width: double.infinity,
              height: 80.h,
              child: Padding(
                padding:  EdgeInsets.all(8.sp),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(PageAnimationTransition(
                        page: CalculatePage(),
                        pageAnimationType: FadeAnimationTransition()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(235, 250, 12, 39)),
                  child: Text(
                    'Recalculate',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
