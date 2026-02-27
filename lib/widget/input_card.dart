import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bmi_calculator/widget/custom_container.dart';

class InputCard extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final Function(String) onChanged;

  const InputCard({
    super.key,
    required this.title,
    required this.controller,
    required this.onDecrement,
    required this.onIncrement,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      height: 200.h,
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Text(
              title,
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
              controller: controller,
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
              onChanged: onChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RawMaterialButton(
                onPressed: onDecrement,
                elevation: 0.0,
                constraints: BoxConstraints.tightFor(
                  width: 45.w,
                  height: 45.w,
                ),
                shape: const CircleBorder(),
                fillColor: const Color(0xFF4C4F5E),
                child: Icon(Icons.remove, color: Colors.white, size: 30.sp),
              ),
              SizedBox(width: 15.w),
              RawMaterialButton(
                onPressed: onIncrement,
                elevation: 0.0,
                constraints: BoxConstraints.tightFor(
                  width: 45.w,
                  height: 45.w,
                ),
                shape: const CircleBorder(),
                fillColor: const Color(0xFF4C4F5E),
                child: Icon(Icons.add, color: Colors.white, size: 30.sp),
              ),
            ],
          )
        ],
      ),
    );
  }
}
