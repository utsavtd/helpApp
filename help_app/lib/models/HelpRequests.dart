import 'package:help_app/models/User.dart';

class HelpRequest {
  String id;
  String type;
  String user ;
  String address ;

  HelpRequest(this.id, this.type,this.user,this.address);

  HelpRequest.fromJson(Map<String, dynamic> json)
      :id=json['_id'],
        type = json['type'],
        user=json['user'],
        address = json['address'];


}
