import 'package:myday/event/addDiary_event.dart';
import 'package:myday/screens/DetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:myday/widgets/Diary.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/utils.dart';
import 'package:intl/intl.dart';


var items = <Diary>[];

class CalendarScreen extends StatefulWidget {
  var returnItems = <Diary>[];
  var selectedDay;
  var weather;

  CalendarScreen({Key? key, required this.returnItems, required String date, required String weather}) {
    items = this.returnItems;
    this.selectedDay=date;
    this.weather=weather;
  }


  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  Widget _buildItemWidget(Diary diary) {

    return Card(
      child: ListTile(
        onTap: () {
          final detailedDiary = new Diary(title: diary.title, text: diary.text);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    detailedDiary: detailedDiary,
                    selectDate: diary.day,
                    prePage: "CalendarScreen",
                    weather: diary.weather,
                  )));
        },
        leading: Text(
          diary.day
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
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(

        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            TableCalendar(
              calendarBuilders: CalendarBuilders(
              ),
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2022, 12, 31),
              focusedDay: _selectedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
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
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },

              // eventLoader: (day) {
              //   return _getEventsForDay(day);
              //
              // },
            ),
            // ..._getEventsForDay(_selectedDay).map((Event event){
            //   return Container();
            // }),

            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  DateFormat("yyyy.MM.dd").format(_selectedDay),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                  children: items
                      .map((diary) =>
                  (diary.day==
                      DateFormat("yyyy.M.dd").format(_selectedDay))
                      ? (_buildItemWidget(diary))
                      : (Container()))
                      .toList()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home, color: Colors.white),
          backgroundColor: Colors.lightGreen[200],
          elevation: 0,
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
