import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_joker/widgets/user_account_tile.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/joker2.jpg'),
            fit: BoxFit.cover,
            opacity: 0.5),
      ),
      child: Center(
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 500.h,
          width: 300.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20).r,
            // color: Colors.black,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.black),
                currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/user.jpg')),
                accountName: Text(
                  'darkcreedd',
                  style: TextStyle(fontSize: 14.sp),
                ),
                accountEmail: Text('darkcreedd@gmail.com',
                    style: TextStyle(fontSize: 14.sp)),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Column(children: [
                    UserAccountTile(icon: Icons.edit, title: 'Edit User Data'),
                    UserAccountTile(icon: Icons.color_lens, title: 'Theme'),
                    GestureDetector(
                        onTap: () {
                          showAboutDialog(
                              context: context,
                              applicationIcon:
                                  Image.asset('assets/icons/ic_launcher.png'),
                              applicationName: 'The Joker',
                              applicationVersion: '1.0.1v');
                        },
                        child: UserAccountTile(
                            icon: Icons.info, title: 'About App')),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      size: 24.sp,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 8.0).w,
                                      child: Text(
                                        'Log out?',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Text(
                                  'We are sad to see you leave',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Leave',
                                        style: TextStyle(fontSize: 14.sp),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Stay',
                                        style: TextStyle(fontSize: 14.sp),
                                      ))
                                ],
                              );
                            },
                          );
                        },
                        child: UserAccountTile(
                            icon: Icons.logout, title: 'Logout')),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
