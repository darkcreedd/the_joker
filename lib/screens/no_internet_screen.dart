import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:the_joker/dataclass/dataclass.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataClass>(
      builder: (context, value, child) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/joker2.jpg'),
              fit: BoxFit.cover,
              opacity: 0.2),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200.h,
                width: 150.w,
                child: Image.asset('assets/images/wireless-error.png'),
              ),
              Text('No internet connection', style: TextStyle(fontSize: 14.sp)),
              Text('Please check your internet and try again',
                  style: TextStyle(fontSize: 14.sp)),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const StadiumBorder(),
                      fixedSize: Size(150.w, 45.h)),
                  onPressed: () {
                    Provider.of<DataClass>(context, listen: false)
                        .updateConnectionStatus(ConnectivityResult.none);
                    Provider.of<DataClass>(context, listen: false)
                        .internetState = value.xconnectionStatus;
                  },
                  child: Text('Reload', style: TextStyle(fontSize: 14.sp)))
            ],
          ),
        ),
      ),
    );
  }
}
