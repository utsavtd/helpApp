import 'package:help_app/models/User.dart';

class HelpRequest {
  String id;
  String type;
  String user ;

  HelpRequest(this.id, this.type,this.user);

  HelpRequest.fromJson(Map<String, dynamic> json)
      :id=json['_id'],
        type = json['type'],
        user=json['user'];


}
