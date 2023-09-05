import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../dataclass/dataclass.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    Provider.of<DataClass>(context, listen: false).toggle1(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Filters'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<DataClass>(
        builder: (context, dvalue, child) => SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text('Any', style: TextStyle(fontSize: 14.sp)),
                      Radio(
                        activeColor: Colors.black,
                        value: dvalue.any,
                        groupValue: dvalue.customisation,
                        onChanged: (value) {
                          setState(() {
                            dvalue.customisation = dvalue.any;
                            dvalue.categoryx2 = 'Any';
                            Provider.of<DataClass>(context, listen: false)
                                .toggle(false);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Custom', style: TextStyle(fontSize: 14.sp)),
                      Radio(
                        activeColor: Colors.black,
                        groupValue: dvalue.customisation,
                        value: dvalue.custom,
                        onChanged: (value) {
                          setState(() {
                            dvalue.customisation = dvalue.custom;
                            Provider.of<DataClass>(context, listen: false)
                                .toggle(true);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              CheckboxListTile(
                title: Text('Programming', style: TextStyle(fontSize: 14.sp)),
                enabled: dvalue.programmingState,
                dense: true,
                activeColor: Colors.black,
                value: dvalue.programming,
                onChanged: (value) {
                  setState(() {
                    dvalue.programming = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Miscellaneous', style: TextStyle(fontSize: 14.sp)),
                enabled: dvalue.miscellaneousState,
                dense: true,
                activeColor: Colors.black,
                value: dvalue.miscellaneous,
                onChanged: (value) {
                  setState(() {
                    dvalue.miscellaneous = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Dark', style: TextStyle(fontSize: 14.sp)),
                enabled: dvalue.darkState,
                dense: true,
                activeColor: Colors.black,
                value: dvalue.dark,
                onChanged: (value) {
                  setState(() {
                    dvalue.dark = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Pun', style: TextStyle(fontSize: 14.sp)),
                enabled: dvalue.punState,
                dense: true,
                activeColor: Colors.black,
                value: dvalue.pun,
                onChanged: (value) {
                  setState(() {
                    dvalue.pun = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Spooky', style: TextStyle(fontSize: 14.sp)),
                enabled: dvalue.spookyState,
                dense: true,
                activeColor: Colors.black,
                value: dvalue.spooky,
                onChanged: (value) {
                  setState(() {
                    dvalue.spooky = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Christmas', style: TextStyle(fontSize: 14.sp)),
                enabled: dvalue.christmasState,
                dense: true,
                activeColor: Colors.black,
                value: dvalue.christmas,
                onChanged: (value) {
                  setState(() {
                    dvalue.christmas = value!;
                  });
                },
              ),
              Text('Set Flags to exclude', style: TextStyle(fontSize: 14.sp)),
              CheckboxListTile(
                title: Text('Not suitable for work',
                    style: TextStyle(fontSize: 14.sp)),
                dense: true,
                activeColor: Colors.black,
                value: dvalue.nsfw,
                onChanged: (value) {
                  setState(() {
                    dvalue.nsfw = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Religious', style: TextStyle(fontSize: 14.sp)),
                dense: true,
                activeColor: Colors.black,
                value: dvalue.religious,
                onChanged: (value) {
                  setState(() {
                    dvalue.religious = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Political', style: TextStyle(fontSize: 14.sp)),
                dense: true,
                activeColor: Colors.black,
                value: dvalue.political,
                onChanged: (value) {
                  setState(() {
                    dvalue.political = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Racist', style: TextStyle(fontSize: 14.sp)),
                dense: true,
                activeColor: Colors.black,
                value: dvalue.racist,
                onChanged: (value) {
                  setState(() {
                    dvalue.racist = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Sexist', style: TextStyle(fontSize: 14.sp)),
                dense: true,
                activeColor: Colors.black,
                value: dvalue.sexist,
                onChanged: (value) {
                  setState(() {
                    dvalue.sexist = value!;
                  });
                },
              ),
              CheckboxListTile(
                enableFeedback: false,
                dense: true,
                title: Text('Explicit', style: TextStyle(fontSize: 14.sp)),
                activeColor: Colors.black,
                value: dvalue.explicit,
                onChanged: (value) {
                  setState(() {
                    dvalue.explicit = value!;
                  });
                },
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: Size(130.w, 45.h),
                      shape: const StadiumBorder()),
                  onPressed: () {
                    setState(() {
                      Provider.of<DataClass>(context, listen: false)
                          .singleJoke();

                      Provider.of<DataClass>(context, listen: false).dualJoke();
                      Provider.of<DataClass>(context, listen: false)
                          .customisation = 'Any';

                      Navigator.pop(context);
                    });
                  },
                  child: Text('Save', style: TextStyle(fontSize: 14.sp)))
            ],
          ),
        ),
      ),
    );
  }
}
