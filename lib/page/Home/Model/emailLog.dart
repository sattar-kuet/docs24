import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class EmailLogModel extends Equatable {
  int? id;
  String? subject;
  String? receiverEmail;
  String? time;

  EmailLogModel({this.id, this.subject, this.receiverEmail, this.time});

  EmailLogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    receiverEmail = json['receiver_email'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['receiver_email'] = this.receiverEmail;
    data['time'] = this.time;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, subject, receiverEmail, time];
}
