
class Todo {

  String _title;
  bool _check;

  Todo(this._title,this._check );

  Todo.fromJson(Map<String,dynamic> json)
      : _title = json['title']??'',
        _check = bool.parse(json['check']);

  Map<String, dynamic> toJson() {
    return {
      'title': _title,
      'date': _check.toString(),
    };
  }




}