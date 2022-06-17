import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myday/widgets/Diary.dart';
import 'package:myday/event/addDiary_event.dart';
import 'package:myday/model/weather.dart';


class AddScreen extends StatefulWidget {
  var date;
  var json;
  AddScreen({Key? key, required String date, required var json}){
    this.date=date;
    this.json=json;
  }

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  Model model=Model();
  String icon="";


  // 다이어리 인풋 텍스트 조작을 위한 컨트롤러
  var _diaryTitleController = TextEditingController();
  var _diaryTextController = TextEditingController();
  var _diaryWeatherController = TextEditingController();
  late Map<DateTime, List<Event>> selectedEvents;


  void updateData(dynamic json){
    int condition=json['weather'][0]['id'];
    icon=model.getWeatherIcon(condition);
  }
  void dispose() {
    _diaryTitleController.dispose();
    _diaryTextController.dispose();
    super.dispose();
  }
  @override
  void initState(){
    selectedEvents={};
    updateData(widget.json);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(
            "WRITING MYDAY",
            style: TextStyle(
                fontSize: 20.0,
                // fontWeight: FontWeight.bold,
                color: Colors.grey[500]),
          ),
          iconTheme: IconThemeData(
            color: Colors.grey[500],
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20
              ),
              Row(
                children: [
                  SizedBox(width: 50,),
                  Text(
                    "${widget.date}",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500]),
                  ),
                  // Container(
                  //     width: 60,
                  //     height: 60,
                  //     child: icon
                  // ),
                  SizedBox(width: 20),
                  Text(
                    icon,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,

                    )
                  )
                ],
              ),

              // SizedBox(
              //   height: 10,
              // ),

              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(8.0),
                      width: width - 80,
                      child: TextField(
                        maxLines: 1,
                        controller: _diaryTitleController,
                        // decoration: InputDecoration(
                        //   labelText: '제목을 작성해주세요',
                        //   fillColor: Colors.grey[300],
                        //   filled: true,
                        // ),
                        decoration: InputDecoration(
                          labelText: "제목을 입력해주세요",
                          labelStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.all(8.0),
                      width: width - 80,
                      child: TextField(
                        maxLines: 7,
                        controller: _diaryTextController,
                        decoration: InputDecoration(
                          labelText: "내용을 입력해주세요",
                          labelStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
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
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final diary = new Diary(
                            title: _diaryTitleController.value.text,
                            text: _diaryTextController.value.text,
                          day: widget.date,
                          weather: icon,
                        );

                        Navigator.pop(context, diary);
                        _diaryTextController.clear();
                        _diaryTitleController.clear();
                      },

                      child: Text(
                        '저장',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary:Color(0xffE3F1C7),
                          shadowColor: Colors.transparent),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
