
class HelpNotification {
  String id;
  String text;

  HelpNotification(this.id, this.text);

  HelpNotification.fromJson(Map<String, dynamic> json)
      :id=json['_id'],
        text = json['text'];

}
