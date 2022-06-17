import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

import '../event/addDiary_event.dart';

class MainPage_Calendar extends StatefulWidget {
  const MainPage_Calendar({Key? key}) : super(key: key);

  @override
  State<MainPage_Calendar> createState() => _MainPage_CalendarState();
}

class _MainPage_CalendarState extends State<MainPage_Calendar> {
  final _authentication = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? loggedUser;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late Map<DateTime, List<Event>> selectedEvents;

  TextEditingController _eventController1 = TextEditingController();
  TextEditingController _eventController2 = TextEditingController();

  var count = 0;

  var selectedTitle = 'a';
  var selectedsubTitle = 'a';

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    selectedEvents = {};
    getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    _eventController1.dispose();
    _eventController2.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  Widget show(String title, String content){
    return ListTile(
      // title: Text(event.title),
      title: Text(title),
      subtitle: Text(content),
      onTap: (){
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // content: Container(
                //   child: Writing(selectedDay),
                // ),
                  scrollable: true,
                  title: Center(child: Text(title)),
                  content: Column(
                    children: [
                      Text(content),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "확인",
                        style: TextStyle(
                            color: Colors.grey[700], fontSize: 15),
                      ),
                    ),
                  ]);
            });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            SizedBox(height: 10.0),
            TableCalendar(
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2022, 12, 31),
              focusedDay: selectedDay,
              calendarFormat: CalendarFormat.month,
              weekendDays: const [DateTime.sunday, 6],
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekHeight: 50.0,
              rowHeight: 50.0,
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Colors.grey,
                  size: 28,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                  size: 28,
                ),
              ),
              calendarStyle: const CalendarStyle(
                isTodayHighlighted: true,
                todayDecoration: BoxDecoration(
                  color: Color(0xffC9DF9A),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(color: Colors.white),
                selectedDecoration: BoxDecoration(
                  color: Color(0xffE3F1C7),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.grey),
              ),
              selectedDayPredicate: (DateTime date) {
                return (isSameDay(selectedDay, date));
              },
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                firestore
                    .collection("diary")
                    .where("date",
                    isEqualTo: DateFormat("yyyy-MM-dd").format(selectedDay))
                    .get()
                    .then((QuerySnapshot ds) => {
                  ds.docs.forEach((doc) {
                    print(doc['title']);
                    print(doc['content']);

                  })
                });
                setState(() {

                });

              },
              eventLoader: (day) {

                return _getEventsForDay(day);
              },
            ),
            ..._getEventsForDay(selectedDay).map((Event event){


              return ListTile(
                // title: Text(event.title),
                title: Text(event.title),
                subtitle: Text(event.content),
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            scrollable: true,
                            title: Center(child: Text(event.title)),
                            content: Column(
                              children: [
                                Text(event.content),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "확인",
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 15),
                                ),
                              ),
                            ]);
                      });
                },
              );
            }),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        // content: Container(
                        //   child: Writing(selectedDay),
                        // ),
                        scrollable: true,
                        title: Center(child: Text("일기 작성")),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat("yyyy-MM-dd").format(selectedDay)),
                            SizedBox(height: 15.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text("제목"),
                                // SizedBox(height: 10),
                                TextFormField(
                                  controller: _eventController1,
                                  decoration: InputDecoration(
                                    labelText: "제목",
                                    filled: true,
                                    fillColor: Color(0xffE3F1C7),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 20.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffC9DF9A), width: 2.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text("내용"),
                                // SizedBox(height: 10),
                                TextFormField(
                                  controller: _eventController2,
                                  decoration: InputDecoration(
                                    labelText: "내용",
                                    filled: true,
                                    fillColor: Color(0xffE3F1C7),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 20.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffC9DF9A), width: 2.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                if (_eventController1.text.isEmpty ||
                                    _eventController2.text.isEmpty) {
                                } else {
                                  if (selectedEvents[selectedDay] != null) {
                                    selectedEvents[selectedDay]?.add(Event(
                                        title: _eventController1.text,
                                        content: _eventController2.text));
                                    firestore.collection("diary").add({
                                      "title": _eventController1.text,
                                      "content": _eventController2.text,
                                      "date": DateFormat("yyyy-MM-dd")
                                          .format(selectedDay),
                                      "month":
                                          DateFormat("MM").format(selectedDay),
                                    });
                                  } else {
                                    selectedEvents[selectedDay] = [
                                      Event(
                                          title: _eventController1.text,
                                          content: _eventController2.text)
                                    ];
                                    firestore.collection("diary").add({
                                      "title": _eventController1.text,
                                      "content": _eventController2.text,
                                      "date": DateFormat("yyyy-MM-dd")
                                          .format(selectedDay),
                                      "month":
                                          DateFormat("MM").format(selectedDay),
                                    });
                                  }
                                }
                                Navigator.pop(context);
                                _eventController1.clear();
                                _eventController2.clear();
                                setState(() {});
                                return;
                              },
                              child: Text(
                                "저장",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 15),
                              )),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "취소",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 15),
                            ),
                          ),
                        ]);
                  }),
              child: Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: Colors.lightGreen[200],
              ),
            ),

          ],
        )),
      ),
    );
  }
}
