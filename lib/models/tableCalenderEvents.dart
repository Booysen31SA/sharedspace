class TableCalenderEvents {
  final String? key;
  final String? groupid;
  final String? usercreated;
  final String? title;
  final String? description;
  final String? timecreated;
  final bool? important;
  final bool? isEditable;

  TableCalenderEvents(
      {this.key,
      this.groupid,
      this.usercreated,
      this.title,
      this.description,
      this.timecreated,
      this.important,
      this.isEditable});

  factory TableCalenderEvents.fromMap(Map data) {
    return TableCalenderEvents(
      key: data['key'],
      groupid: data['groupid'],
      usercreated: data['usercreated'],
      title: data['title'],
      description: data['description'],
      timecreated: data['timecreated'],
      important: data['important'],
      isEditable: data['isEditable'],
    );
  }

  factory TableCalenderEvents.fromDS(String id, Map<String, dynamic> data) {
    return TableCalenderEvents(
      key: data['key'],
      groupid: data['groupid'],
      usercreated: data['usercreated'],
      title: data['title'],
      description: data['description'],
      timecreated: data['timecreated'],
      important: data['important'],
      isEditable: data['isEditable'],
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
      "important": important,
      "isEditable": isEditable,
    };
  }
}
