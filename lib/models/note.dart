class Note {
  final String? key;
  final String? groupid;
  final String? usercreated;
  final String? title;
  final String? description;
  final String? timecreated;
  final bool? important;

  Note({
    this.key,
    this.groupid,
    this.usercreated,
    this.title,
    this.description,
    this.timecreated,
    this.important,
  });

  factory Note.fromMap(Map data) {
    return Note(
      key: data['key'],
      groupid: data['groupid'],
      usercreated: data['usercreated'],
      title: data['title'],
      description: data['description'],
      timecreated: data['timecreated'],
      important: data['important'],
    );
  }

  factory Note.fromDS(String id, Map<String, dynamic> data) {
    return Note(
      key: data['key'],
      groupid: data['groupid'],
      usercreated: data['usercreated'],
      title: data['title'],
      description: data['description'],
      timecreated: data['timecreated'],
      important: data['important'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "key": key,
      "groupid": groupid,
      "usercreated": usercreated,
      "title": title,
      "description": description,
      "timecreated": timecreated,
      "important": important
    };
  }
}
