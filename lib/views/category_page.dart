
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bmi_calculator/colors/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Categories',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: DataTable(
              decoration: BoxDecoration(
                  color: Color.fromARGB(29, 30, 51, 255),
                  borderRadius: BorderRadius.circular(30.sp)),
              columns:  <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Degree',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                          fontSize: 17.sp),
                    ),
                  ),
                ),
                 DataColumn(
                  label: Expanded(
                    child: Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      '18.5 and below',
                      style: Styles().textStyle,
                    )),
                    DataCell(Text('Weak', style: Styles().textStyle1)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      'Between 18.5 and 24.9',
                      style: Styles().textStyle,
                    )),
                    DataCell(Text('Normal', style: Styles().textStyle2)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      'Between 25 and 29.9',
                      style: Styles().textStyle,
                    )),
                    DataCell(Text('Overweight', style: Styles().textStyle3)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      'Between 30 and 34.9',
                      style: Styles().textStyle,
                    )),
                    DataCell(Text('Fat (obesity class 1)',
                        style: Styles().textStyle4)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      'Between 35 and 39.9',
                      style: Styles().textStyle,
                    )),
                    DataCell(Text('Overweight (obesity class 2)',
                        style: Styles().textStyle5)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      '40 and above:',
                      style: Styles().textStyle,
                    )),
                    DataCell(Text('Extremely obese (obesity class 3)',
                        style: Styles().textStyle6)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
