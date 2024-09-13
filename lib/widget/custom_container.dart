import 'package:flutter/cupertino.dart';

class CustomContainer extends StatelessWidget {
  double width;
  double height;
  Widget widget;

  CustomContainer({
    required this.width,
    required this.height,
    required this.widget,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color.fromARGB(29, 30, 51, 255),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: widget,
    );
  }
}
