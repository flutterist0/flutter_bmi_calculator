import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaleContainer extends StatelessWidget {
  const MaleContainer({
    super.key,
    required int selectedContainer,
  }) : _selectedContainer = selectedContainer;

  final int _selectedContainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 210.h,
      decoration: BoxDecoration(
          color: _selectedContainer == 1
              ? Color.fromARGB(235, 250, 12, 39)
              : Color.fromARGB(29, 30, 51, 255),
          borderRadius: BorderRadius.all(Radius.circular(30.sp))),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.male,
                color: Colors.white,
                size: 130.sp,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Male',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
