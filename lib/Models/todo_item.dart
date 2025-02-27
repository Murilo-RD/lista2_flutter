
class Todo {

  String _title;
  bool _check=false;

  Todo(this._title);

  Todo.fromJson(Map<String,dynamic> json)
      : _title = json['title']??'',
        _check = bool.parse(json['check']);

  Map<String, dynamic> toJson() {
    return {
      'title': _title,
      'check': _check.toString(),
    };
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  bool get check => _check;

  set check(bool value) {
    _check = value;
  }
}