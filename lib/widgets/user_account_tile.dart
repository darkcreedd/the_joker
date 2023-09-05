import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class UserAccountTile extends StatelessWidget {
  UserAccountTile({super.key, required this.title, required this.icon});
  String title;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10).w,
      margin: const EdgeInsets.all(5).w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10).r,
      ),
      child: Builder(builder: (context) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20.sp,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0).w,
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            )
          ],
        );
      }),
    );
  }
}
