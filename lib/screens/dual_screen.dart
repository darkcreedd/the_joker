import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:the_joker/dataclass/dataclass.dart';
import 'package:the_joker/models/models.dart';

class DualScreen extends StatefulWidget {
  const DualScreen({super.key});

  @override
  State<DualScreen> createState() => _DualScreenState();
}

class _DualScreenState extends State<DualScreen> {
  late Future<DualJoke>? joke2;
  bool favoriteDouble = false;
  @override
  void initState() {
    var data = Provider.of<DataClass>(context, listen: false);
    data.categoryx2 ??= 'Any?';
    data.flagx2 ??= '';

    joke2 = data.dualJoke();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/joker2.jpg'),
            fit: BoxFit.cover,
            opacity: 0.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10).w,
            padding: const EdgeInsets.all(8).w,
            constraints:
                BoxConstraints(minWidth: double.infinity, minHeight: 40.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15).r,
              border: Border.all(width: 2.w, color: Colors.black),
            ),
            child: FutureBuilder(
              future: joke2,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data?.error == true) {
                    return Center(
                      child: Text(
                        'No jokes were found that match your provided filter(s).',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          'No internet connection, please make sure you are connected to the internet',
                          style: TextStyle(fontSize: 14.sp)),
                    );
                  }
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data!.setup!),
                        Text(snapshot.data!.delivery!),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(snapshot.data!.category!),
                              IconButton(
                                splashRadius: 20.r,
                                onPressed: () {
                                  setState(() {
                                    favoriteDouble = !favoriteDouble;
                                    Provider.of<DataClass>(context,
                                            listen: false)
                                        .addToSaved(
                                            id: snapshot.data!.id,
                                            category: snapshot.data!.category!,
                                            type: snapshot.data!.type!,
                                            setup: snapshot.data!.setup,
                                            delivery: snapshot.data!.delivery);
                                  });
                                },
                                icon: (favoriteDouble)
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 24.sp,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: Colors.black,
                                        size: 24.sp,
                                      ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
                }
                return Center(
                  child: Container(
                    constraints:
                        BoxConstraints(maxHeight: 50.h, minHeight: 50.h),
                    child: SizedBox(
                      height: 35.h,
                      width: 45.w,
                      child:
                          const CircularProgressIndicator(color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const StadiumBorder(),
                  fixedSize: Size(150.w, 45.h)),
              onPressed: () {
                Provider.of<DataClass>(context, listen: false).setCategory();
                Provider.of<DataClass>(context, listen: false).setFlags();
                setState(() {
                  joke2 =
                      Provider.of<DataClass>(context, listen: false).dualJoke();
                  favoriteDouble = false;
                });
              },
              child: Text(
                'Next Joke',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ))
        ],
      ),
    );
  }
}
