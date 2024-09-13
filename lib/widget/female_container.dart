import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FemaleContainer extends StatelessWidget {
  const FemaleContainer({
    super.key,
    required int selectedContainer,
  }) : _selectedContainer = selectedContainer;

  final int _selectedContainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.sp,
      height: 210.sp,
      decoration: BoxDecoration(
          color: _selectedContainer == 2
              ? Color.fromARGB(235, 250, 12, 39)
              : Color.fromARGB(29, 30, 51, 255),
          borderRadius: BorderRadius.all(Radius.circular(30.sp))),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.female,
                color: Colors.white,
                size: 130.sp,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Female',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
