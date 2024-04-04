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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject'] = subject;
    data['receiver_email'] = receiverEmail;
    data['time'] = time;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, subject, receiverEmail, time];
}
