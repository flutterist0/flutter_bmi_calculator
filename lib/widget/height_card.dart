import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bmi_calculator/widget/custom_container.dart';

class HeightCard extends StatelessWidget {
  final ValueNotifier<double> heightNotifier;

  const HeightCard({
    super.key,
    required this.heightNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      height: 200.h,
      widget: ValueListenableBuilder<double>(
        valueListenable: heightNotifier,
        builder: (context, currentSliderValue, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Text(
                  'Height',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.sp),
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
                    heightNotifier.value = value;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
