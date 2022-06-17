import 'package:flutter/material.dart';
import 'package:myday/screens/setting_list.dart';
import 'package:myday/screens/mainPage_calendar.dart';




class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(

          body: TabBarView(
            children: [
              MainPage_Calendar(),
              SettingList(),
            ],
          ),
          extendBodyBehindAppBar: true, // add this line

          bottomNavigationBar: Container(
            color: Colors.lightGreen[200], //색상
            child: Container(
              height: 70,
              padding: EdgeInsets.only(bottom: 10, top: 5),
              child: const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                //tab 하단 indicator color
                indicatorColor: Colors.black54,
                //tab 하단 indicator weight
                indicatorWeight: 2,
                //label color
                labelColor: Colors.black54,
                //unselected label color
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(
                  fontSize: 13,
                ),
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.calendar_month_outlined,
                    ),
                    text: 'Calendar',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.settings,
                    ),
                    text: 'Settings',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

