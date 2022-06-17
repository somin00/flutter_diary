import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

class Event{
  final String title;
  final String content;


  Event({required this.title, required this.content});

  String toString()=>title;


  //
  // Map<DateTime, List<T>> eventSource={
  //   DateTime(2022,5,23) : [Event(title:'5분 기도하기', complete: true), Event(title:'5분 기도하기', complete: true), Event(title:'5분 기도하기', complete: true)],
  //   DateTime(2022,5,24) : [Event(title:'5분 기도하기', complete: true)],
  //   DateTime(2022,5,25) : [Event(title:'5분 기도하기', complete: true)],
  //   DateTime(2022,5,26) : [Event(title:'5분 기도하기', complete: true)],
  // };
  //
  // final events=LinkedHashMap(
  //   equals: isSameDay,
  // )..addAll(eventSource);
}