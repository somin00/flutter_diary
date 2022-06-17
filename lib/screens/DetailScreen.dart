import 'package:myday/screens/MainScreen.dart';
import 'package:myday/widgets/Diary.dart';
import 'package:myday/widgets/DiaryEvent.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:highlightable/highlightable.dart';

var diary = new Diary();

// String initialText = 'summarized line';
String editText="수정된 일기";


class DetailScreen extends StatefulWidget {
  String date="";
  String prePage="";
  String weather="";
  var items;
  DetailScreen({Key? key, required detailedDiary, required selectDate, required prePage, required String weather}) {
    diary = detailedDiary;
    date=selectDate;
    this.prePage=prePage;
    this.weather=weather;
    this.items=items;
  }

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool editMode = false;

  TextEditingController _editTitleController=TextEditingController(text: diary.title);
  TextEditingController _editingController =
      TextEditingController(text: diary.text);


  Widget _editTitleTextField() {
    if (editMode)
      return Center(
          child: Container(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              editText = newValue;
              diary.text=editText;
              // diary.line = initialText;
              editMode = false;

            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      ));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      IconButton(
          onPressed: () {
            setState(() {
              editMode = true;
            });
          },
          icon: Icon(Icons.edit))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;


    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[500]),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              // mainAxisAlignment: editMode? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.date,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500]),
                ),
                // if(editMode)
                SizedBox(width: 26),
                Text(
                  widget.weather,
                  style: TextStyle(
                      fontSize:34.0,
                      )
                ),
                SizedBox(width: 128),
                if(!editMode&&widget.prePage=="MainScreen")
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              editMode = true;
                              print(editMode);
                            });
                          },
                          icon: Icon(Icons.edit, color: Colors.lightGreen[300])
                      ),
                      // IconButton(
                      //   onPressed: (){
                      //
                      //   },
                      //   icon:Icon(Icons.delete, color: Colors.lightGreen[300]),
                      // )
                    ],
                  )


              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(!editMode)
                Text("Title", style: TextStyle(
                  color:Colors.grey[500],
                  fontSize: 18
                ),),
                SizedBox(
                  height: 10
                ),
                if(!editMode)
                Container(
                  width: width-40,
                  decoration: BoxDecoration(
                    color:  Color(0xffE3F1C7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        diary.title,
                        style: TextStyle(fontSize: 18.0, color: Colors.grey[600], ),
                      ),
                    ),
                ),
                if(editMode)
                  TextField(
                    enabled: false,
                    maxLines: 1,
                    controller: _editTitleController,
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
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                if(!editMode)
                Text("Content", style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 18
                ),),
                SizedBox(height: 10),
                if(!editMode)
                Container(

                  width: width - 40,
                  decoration: BoxDecoration(
                    color:  Color(0xffE3F1C7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      diary.text,
                      style: TextStyle(fontSize: 18, color :Colors.grey[600]),
                    ),
                  ),
                ),
                if(editMode)
                  Container(
                    child: TextField(
                      maxLines: 7,
                      controller: _editingController,
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
                SizedBox(height: 20),
                if(editMode)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        final modifiedLine = _editingController.text;
                        Navigator.pop(context, modifiedLine);

                      },
                      child: Text(
                        '완료',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      style: ElevatedButton.styleFrom(

                          elevation: 0.0,
                          primary: Color(0xffE3F1C7),
                          shadowColor: Colors.transparent),

                    ),
                  )
              ],
            ),
          )


        ],
      ),
    );
  }
}



