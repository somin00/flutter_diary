import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myday/widgets/Diary.dart';

class DiaryList extends StatelessWidget {
  //const DiaryList({Key? key}) : super(key: key);

  DiaryList(this.diaries);

  final List<Diary> diaries;

  Widget _buildItem(BuildContext context, int index) {
    final diary = diaries[index];

    return Card(
      child: ListTile(
        onTap: () {},
        leading: Text(
          DateFormat.MMMd().format(diary.date),
        ),

        // title: Text(
        //   diary.title,
        // ),
        title: Row(
          children: [
            Text(
              diary.title,
            ),
            SizedBox(width: 20),
            Text(
              diary.weather
            ),
          ],
        ),
        subtitle: Text(
          diary.text,
          //diary.line,
        ),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildItem,
      itemCount: diaries.length,
    );
  }
}
