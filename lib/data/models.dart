class Diary{
  final int id;
  final String content;
  final int boxnumber;
  final int color;

  Diary({this.id, this.content, this.boxnumber, this.color});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'content' : content,
      'boxnumber' : boxnumber,
      'color' : color
    };
  }

  @override
  String toString(){
    return 'Diary{id: $id, content: $content, boxnumber: $boxnumber, color: $color}';
  }
}