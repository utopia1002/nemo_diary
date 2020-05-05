class Diary{
  final int id;
  final String content;
  final int boxnumber;
  final int color;
  final String date;

  Diary({this.id, this.content, this.boxnumber, this.color, this.date});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'content' : content,
      'boxnumber' : boxnumber,
      'color' : color,
      'date' : date,
    };
  }

  @override
  String toString(){
    return 'Diary{id: $id, content: $content, boxnumber: $boxnumber, color: $color, date: $date}';
  }
}