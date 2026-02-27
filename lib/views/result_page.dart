// import 'dart:ffi';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/views/calculate_page.dart';
import 'package:flutter_bmi_calculator/widget/custom_container.dart';
import 'package:flutter_bmi_calculator/widget/bottom_action_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:flutter_bmi_calculator/views/category_page.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.currentSliderValue,
    required this.counter1,
  });
  final double currentSliderValue;
  final double counter1;

  @override
  Widget build(BuildContext context) {
    double bmi = counter1 / pow(currentSliderValue / 100, 2);
    String bmiString = bmi.toStringAsFixed(1);
    String status = '';
    String description = '';
    Color statusColor = Colors.white;

    if (bmi < 18.5) {
      status = 'UNDERWEIGHT';
      description = 'You have a lower than normal body weight. You can eat a bit more.';
      statusColor = Colors.orange;
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      status = 'NORMAL';
      description = 'You have a normal body weight. Good job!';
      statusColor = Colors.green;
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      status = 'OVERWEIGHT';
      description = 'You have a higher than normal body weight. Try to exercise more.';
      statusColor = Colors.yellow;
    } else {
      status = 'OBESE';
      description = 'You have a significantly higher than normal body weight. Please consult a doctor.';
      statusColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Result',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageAnimationTransition(
                        page: const CategoryPage(),
                        pageAnimationType: FadeAnimationTransition(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4C4F5E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h)),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: CustomContainer(
                width: double.infinity,
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      bmiString,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 60.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Normal BMI result',
                      style: TextStyle(
                          color: Color.fromARGB(255, 115, 126, 142),
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '18.5 - 25 kg/m\u00b2',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          final box = Hive.box('bmi_history');
                          final now = DateTime.now();
                          final formattedDate =
                              DateFormat('MMM d, yyyy - HH:mm').format(now);

                          box.add({
                            'bmi': bmiString,
                            'status': status,
                            'date': formattedDate,
                          });

                          const snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Success!',
                              message: 'Result saved successfully.',
                              contentType: ContentType.success,
                            ),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 5.sp,vertical: 10.sp),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFE52D27), Color(0xFFB31217)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.redAccent.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  'SAVE RESULT',
                                  textStyle: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2),
                                  colors: const [
                                    Colors.white,
                                    Colors.yellow,
                                    Colors.white,
                                  ],
                                ),
                              ],
                              onTap: null, // Explicitly null as handled by GestureDetector
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ), height: 60.h,
              ),
            ),
          ),
          BottomActionButton(
            title: 'Re-Calculate',
            onPressed: () {
              Navigator.of(context).push(PageAnimationTransition(
                  page:  CalculatePage(),
                  pageAnimationType: RightToLeftTransition()));
            },
          ),
        ],
      ),
    );
  }
}

class AwesomeSnackbarContent extends StatelessWidget {
  final String title;
  final String message;
  final ContentType contentType;

  const AwesomeSnackbarContent({
    super.key,
    required this.title,
    required this.message,
    required this.contentType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: contentType == ContentType.failure ? Colors.red : Colors.green,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

enum ContentType { failure, success }
