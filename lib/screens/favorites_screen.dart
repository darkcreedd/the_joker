import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:the_joker/dataclass/dataclass.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    super.initState();
    Provider.of<DataClass>(context, listen: false).loadSavedJokes();
  }

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
        child: Visibility(
          replacement: Center(
              child: Text(
            'No saved jokes',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14.sp),
          )),
          visible: value.savedJokeList.isNotEmpty,
          child: ListView.builder(
            itemCount: value.savedJokeList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(value.savedJokeList[index].id.toString()),
                background: Container(
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    size: 24.sp,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    value.savedJokeList.removeWhere(
                        (joke) => joke.id == value.savedJokeList[index].id);
                  });
                },
                child: Container(
                    margin: const EdgeInsets.all(10).w,
                    padding: const EdgeInsets.all(8).w,
                    constraints: BoxConstraints(
                        minHeight: 45.h, maxWidth: double.infinity),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: (value.savedJokeList[index].type != 'single')
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(value.savedJokeList[index].setup!,
                                  style: TextStyle(fontSize: 14.sp)),
                              Text(value.savedJokeList[index].delivery!,
                                  style: TextStyle(fontSize: 14.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(value.savedJokeList[index].category,
                                        style: TextStyle(fontSize: 14.sp)),
                                    Text(
                                      'Swipe left to delete',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color.fromARGB(
                                              255, 209, 88, 79),
                                          fontStyle: FontStyle.italic),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.savedJokeList[index].joke!,
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(value.savedJokeList[index].category,
                                        style: TextStyle(fontSize: 14.sp)),
                                    Text(
                                      'Swipe left to delete',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color.fromARGB(
                                              255, 211, 32, 19),
                                          fontStyle: FontStyle.italic),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
              );
            },
          ),
        ),
      ),
    );
  }
}
