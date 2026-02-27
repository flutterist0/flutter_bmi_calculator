import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'History',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('bmi_history').listenable(),
        builder: (context, Box box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text(
                'No saved results yet.',
                style: TextStyle(color: Colors.white70, fontSize: 18.sp),
              ),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              // Get items in reverse chronological order
              final int reverseIndex = box.length - 1 - index;
              final Map currentRecord = box.getAt(reverseIndex) as Map;

              final String bmi = currentRecord['bmi'];
              final String status = currentRecord['status'];
              final String date = currentRecord['date'];

              Color statusColor = Colors.white;
              if (status == 'UNDERWEIGHT') statusColor = Colors.orange;
              if (status == 'NORMAL') statusColor = Colors.green;
              if (status == 'OVERWEIGHT') statusColor = Colors.yellow;
              if (status == 'OBESE') statusColor = Colors.red;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Dismissible(
                  key: Key(box.keyAt(reverseIndex).toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    box.deleteAt(reverseIndex);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Result deleted'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  background: Container(
                    padding: EdgeInsets.only(right: 20.w),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Colors.white, size: 30.sp),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(29, 30, 51, 255),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            bmi,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          date,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
