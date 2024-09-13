import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bmi_calculator/views/result_page.dart';
import 'package:flutter_bmi_calculator/widget/custom_container.dart';
import 'package:flutter_bmi_calculator/widget/female_container.dart';
import 'package:flutter_bmi_calculator/widget/male_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/animations/rotate_animation_transition.dart';
import 'package:page_animation_transition/animations/scale_animation_transition.dart';
import 'package:page_animation_transition/animations/top_to_bottom_faded.dart';
import 'package:page_animation_transition/animations/top_to_bottom_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class CalculatePage extends StatefulWidget {
  CalculatePage({super.key});

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  int _selectedContainer = 0;
  double currentSliderValue = 100;
  final ValueNotifier<double> counter1 = ValueNotifier<double>(60);

  void _incrementCounter1() {
    counter1.value++;
  }

  void _decrementCounter1() {
    if (counter1.value > 0) {
      counter1.value--;
    }
  }

  final ValueNotifier<int> counter2 = ValueNotifier<int>(10);

  void _incrementCounter2() {
    counter2.value++;
  }

  void _decrementCounter2() {
    if (counter2.value > 0) {
      counter2.value--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedContainer = 1;
                        });
                      },
                      child: MaleContainer(selectedContainer: _selectedContainer),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedContainer = 2;
                        });
                      },
                      child:
                          FemaleContainer(selectedContainer: _selectedContainer),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomContainer(
                width: double.infinity,
                height: 200.sp,
                widget: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.all(8.0) + EdgeInsets.only(top: 13),
                      child: Text(
                        'Height',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0) +
                          EdgeInsets.only(bottom: 3),
                      child: Text(
                        '${currentSliderValue.round()} cm',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 30.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Slider(
                        activeColor: Color.fromARGB(235, 250, 12, 39),
                        value: currentSliderValue,
                        min: 100.sp,
                        max: 200.sp,
                        divisions: 200,
                        label: currentSliderValue.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            currentSliderValue = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomContainer(
                      width: 100.sp,
                      height: 200.sp,
                      widget: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Weight',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                              valueListenable: counter1,
                              builder: (context, value, child) {
                                return Text(
                                  '${value.toInt()}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30.sp,
                                  ),
                                );
                              }),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: _decrementCounter1,
                                      icon: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 50.sp,
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    onPressed: _incrementCounter1,
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 50.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomContainer(
                      width: 100.sp,
                      height: 200.sp,
                      widget: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Age',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                              valueListenable: counter2,
                              builder: (context, value, child) {
                                return Text(
                                  '${value}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30.sp,
                                  ),
                                );
                              }),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: _decrementCounter2,
                                      icon: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 50.sp,
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    onPressed: _incrementCounter2,
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 50.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 80.sp,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (counter1.value > 0 && counter2.value > 0) {
                    Navigator.of(context).push(PageAnimationTransition(
                        page: ResultPage(
                            currentSliderValue: currentSliderValue,
                            counter1: counter1.value),
                        pageAnimationType: FadeAnimationTransition()));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color.fromARGB(29, 30, 51, 255),
                          title: Text(
                            "Warning",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: Text(
                            "Please enter the value of the weight correctly. (The value of the weight must be greater than 10)",
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Close",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(
                  'Calculate',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(235, 250, 12, 39)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
