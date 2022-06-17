import 'package:flutter/cupertino.dart';
import 'package:myday/model/diaryList.dart';
import 'package:myday/model/lineInitialize.dart';
import 'package:myday/screens/AddScreen.dart';
import 'package:myday/screens/CalendarScreen.dart';
import 'package:myday/screens/DetailScreen.dart';
import 'package:myday/screens/setting_list.dart';
import 'package:myday/widgets/Diary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myday/widgets/DiaryEvent.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 다이어리 목록을 저장할 리스트
  var items = <Diary>[];
  bool showAll=false;

  String dateText = DateFormat("yyyy.M.dd").format(DateTime.now());
  int yearMonth = 202201;

  Future<DiaryList>? diarylist;
  Future<LineInitialize>? lineinitialize;

  double latitude2=0.0;
  double longitude2=0.0;

  var json;


  void getLocation() async{
    try{
      LocationPermission permission = await Geolocator.requestPermission();
      Position position=await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high );
      latitude2=position.latitude;
      longitude2=position.longitude;
      print(position);
      print(latitude2);
      print(longitude2);
    }catch(e){
      print("error");
    }

  }

  void fetchDate() async{
    http.Response response=await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$latitude2&lon=$longitude2&appid=41affb87e84fb099872b7941b42eecee"));

    if(response.statusCode==200){
      String jsonData=response.body;
      json=jsonDecode(jsonData);

    }
    else{
      print(response.statusCode);
    }

  }
  // 일기 작성
  void _awaitReturnValueFromAddScreen(BuildContext context) async {
    final diaryItem = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddScreen(date: dateText, json: json)));
    if (diaryItem != null) {
      lineinitialize = SendToServer().newTextDiary(
          diaryItem.title, diaryItem.text, diaryItem.dateInt, 'androidId');
      items.add(diaryItem);

      setState(() {});
    }
  }

  Widget _buildItemWidget(Diary diary) {
    return Card(
      child: ListTile(
        onTap: () async {
          final detailedDiary = new Diary(title: diary.title, text: diary.text);

          final modifiedLine1 = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailScreen(
                        detailedDiary: detailedDiary,
                        selectDate: diary.day,
                        prePage: "MainScreen",
                        weather: diary.weather,
                      )));

          setState(() {
            diary.text = modifiedLine1;

          });
        },
        leading: Text(
          diary.day,
        ),

        title: Text(
          diary.title,
        ),
        subtitle: Text(
          diary.text,
        ),
        trailing: Text(
          diary.weather,
          style: TextStyle(
            fontSize: 34
          ),
        ),
        isThreeLine: true,

      ),
    );
    // return Card(
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: items.length,
    //     itemBuilder: (context, index) {
    //       final item = items[index].diaryId;
    //       final itemString = item.toString();
    //       return Dismissible(
    //         key: Key(itemString),
    //         onDismissed: (direction){
    //           items.map((e) => {
    //             items.remove(e);
    //           });
    //         },
    //         child: ListTile(
    //           onTap: () async {
    //             final detailedDiary =
    //                 new Diary(title: diary.title, text: diary.text);
    //
    //             final modifiedLine1 = await Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => DetailScreen(
    //                           detailedDiary: detailedDiary,
    //                           selectDate: diary.day,
    //                           prePage: "MainScreen",
    //                       weather: diary.weather,
    //                         )));
    //
    //             setState(() {
    //               diary.text = modifiedLine1;
    //             });
    //           },
    //           leading: Text(
    //             diary.day,
    //           ),
    //           title: Text(
    //             diary.title,
    //           ),
    //           subtitle: Text(
    //             diary.text,
    //           ),
    //           trailing: Text(
    //             diary.weather,
    //             style: TextStyle(
    //                 fontSize: 34
    //             ),
    //           ),
    //           isThreeLine: true,
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  @override
  void initState() {
    getLocation();
    fetchDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // String datetext = dateText;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingList()));
            },
            icon: Icon(
              Icons.logout_outlined,
              color: Colors.lightGreen[300],
            ),
          ),
        ],
        title: Text(
          "MYDAY",
          style: TextStyle(
            color: Colors.grey[500],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.calendar_today),
          color: Colors.lightGreen[300],
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CalendarScreen(
                          returnItems: items,
                          date: dateText,
                          weather: diary.weather,
                        )));
          },
        ),
      ),
      body: Center(
        child: Container(
          width: width - 20,
          child: Center(
              child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              if(showAll)
              Row(
                children: [
                  SizedBox(width: 128),
                  Text("All DIARY",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold,
                        fontSize: 20),),
                  SizedBox(width: 10),
                  IconButton(onPressed: (){
                    setState(() {
                      showAll=!showAll;
                    });
                  }, icon: Icon(Icons.list_alt_outlined, color: Colors.grey[500],))
                ],
              ),
              if(!showAll)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 50),
                    TextButton(
                        onPressed: () {
                          Future<DateTime?> selectedDay = showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2023),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Color(0xffE3F1C7),
                                      onPrimary: Color(0xff9e9e9e),
                                      // onSurface: Color(0xffE3F1C7),
                                      onSurface: Color(0xff9e9e9e),
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary:
                                        Colors.grey[500], // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              });
                          selectedDay.then((dateTime) {
                            setState(() {
                              dateText = dateTime!.year.toString() +
                                  "." +
                                  dateTime.month.toString() +
                                  "." +
                                  dateTime.day.toString();

                            });
                          });
                        },
                        child: Text(
                          dateText,
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                    // SizedBox(width: 10),
                    IconButton(onPressed: (){
                      setState(() {
                        showAll=!showAll;
                      });
                    }, icon: Icon(Icons.list_alt_outlined, color: Colors.grey[500]))
                  ],
                ),

              if(showAll)
                Expanded(
                    child: Column(
                      children: items.map((diary) => _buildItemWidget(diary)).toList()
                    ),
                ),
              if(!showAll)
              Expanded(
                  child: Column(
                children: items
                    .map((diary) =>
                        // DateFormat("yyyy.M.dd").format(diary.date) == dateText
                        diary.day == dateText
                            ? _buildItemWidget(diary)
                            : Container())
                    .toList(),
              ))
            ],
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.lightGreen[200],
          elevation: 0,
          onPressed: () {
            _awaitReturnValueFromAddScreen(context);
            // getLocation();
          }),
    );
  }
}
