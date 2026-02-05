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
  final ValueNotifier<double> _heightNotifier = ValueNotifier<double>(100);
  final ValueNotifier<double> counter1 = ValueNotifier<double>(60);
  final TextEditingController _weightController = TextEditingController();

  final ValueNotifier<int> counter2 = ValueNotifier<int>(10);
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weightController.text = counter1.value.toInt().toString();
    _ageController.text = counter2.value.toString();
  }

  @override
  void dispose() {
    _heightNotifier.dispose();
    counter1.dispose();
    counter2.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _incrementCounter1() {
    counter1.value++;
    _weightController.text = counter1.value.toInt().toString();
  }

  void _decrementCounter1() {
    if (counter1.value > 0) {
      counter1.value--;
      _weightController.text = counter1.value.toInt().toString();
    }
  }

  void _incrementCounter2() {
    counter2.value++;
    _ageController.text = counter2.value.toString();
  }

  void _decrementCounter2() {
    if (counter2.value > 0) {
      counter2.value--;
      _ageController.text = counter2.value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedContainer = 1;
                        });
                      },
                      child:
                          MaleContainer(selectedContainer: _selectedContainer),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedContainer = 2;
                        });
                      },
                      child: FemaleContainer(
                          selectedContainer: _selectedContainer),
                    ),
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
                height: 200.h,
                widget: ValueListenableBuilder<double>(
                  valueListenable: _heightNotifier,
                  builder: (context, currentSliderValue, child) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.sp) +
                              EdgeInsets.only(top: 13.sp),
                          child: Text(
                            'Height',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.sp) +
                              EdgeInsets.only(bottom: 3.sp),
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
                            activeColor: const Color.fromARGB(235, 250, 12, 39),
                            value: currentSliderValue,
                            min: 100,
                            max: 200,
                            divisions: 200,
                            label: currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              _heightNotifier.value = value;
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: CustomContainer(
                      width: 100.w,
                      height: 200.h,
                      widget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Text(
                              'Weight',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.sp),
                            child: TextField(
                              controller: _weightController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 30.sp,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  counter1.value =
                                      double.tryParse(value) ?? counter1.value;
                                }
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.sp),
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
                                  padding: EdgeInsets.all(8.sp),
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
                    padding: EdgeInsets.all(8.sp),
                    child: CustomContainer(
                      width: 100.w,
                      height: 200.h,
                      widget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Text(
                              'Age',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.sp),
                            child: TextField(
                              controller: _ageController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 30.sp,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  counter2.value =
                                      int.tryParse(value) ?? counter2.value;
                                }
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.sp),
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
                                  padding: EdgeInsets.all(8.sp),
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
            height: 80.h,
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: ElevatedButton(
                onPressed: () {
                  if (counter1.value > 0 &&
                      counter2.value > 0 &&
                      _selectedContainer != 0) {
                    Navigator.of(context).push(PageAnimationTransition(
                        page: ResultPage(
                            currentSliderValue: _heightNotifier.value,
                            counter1: counter1.value),
                        pageAnimationType: FadeAnimationTransition()));
                  } else if (_selectedContainer == 0) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(29, 30, 51, 255),
                          title: const Text(
                            "Warning",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: const Text(
                            "Please select your gender.",
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Close",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(29, 30, 51, 255),
                          title: const Text(
                            "Warning",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: const Text(
                            "Please enter the value of the weight correctly. (The value of the weight must be greater than 10)",
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
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
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(235, 250, 12, 39)),
                child: Text(
                  'Calculate',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
