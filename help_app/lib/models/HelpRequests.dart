import 'package:help_app/models/User.dart';

class HelpRequest {
  String id;
  String type;
  User user ;

  HelpRequest(this.id, this.type,this.user);

  HelpRequest.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        type = json['type'],
        user=User( json['user_id']['_id'],
           json['first_name'],
           json['last_name'],
            json['email'],
           json['password'],
            json['type']);


}
