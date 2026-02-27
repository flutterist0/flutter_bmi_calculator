import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bmi_calculator/views/history_page.dart';
import 'package:flutter_bmi_calculator/views/result_page.dart';
import 'package:flutter_bmi_calculator/widget/female_container.dart';
import 'package:flutter_bmi_calculator/widget/male_container.dart';
import 'package:flutter_bmi_calculator/widget/bottom_action_button.dart';
import 'package:flutter_bmi_calculator/widget/height_card.dart';
import 'package:flutter_bmi_calculator/widget/input_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({super.key});

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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final double contentHeight = screenHeight - appBarHeight - statusBarHeight - bottomPadding;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(PageAnimationTransition(
                  page: const HistoryPage(),
                  pageAnimationType: RightToLeftTransition()));
            },
            icon: const Icon(Icons.history, color: Colors.white),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: contentHeight,
          child: Column(
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
                  child: HeightCard(heightNotifier: _heightNotifier),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: InputCard(
                          title: 'Weight',
                          controller: _weightController,
                          onDecrement: _decrementCounter1,
                          onIncrement: _incrementCounter1,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              counter1.value =
                                  double.tryParse(value) ?? counter1.value;
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: InputCard(
                          title: 'Age',
                          controller: _ageController,
                          onDecrement: _decrementCounter2,
                          onIncrement: _incrementCounter2,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              counter2.value =
                                  int.tryParse(value) ?? counter2.value;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BottomActionButton(
                title: 'Calculate',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
