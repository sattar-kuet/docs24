import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class JobModel extends Equatable {
  int? id;
  String? title;
  int? vacancy;
  String? detail;
  String? location;
  int? salary;
  String? deadline;
  bool? applied;

  JobModel(
      {this.id,
      this.title,
      this.vacancy,
      this.detail,
      this.location,
      this.salary,
      this.deadline,
      this.applied});

  JobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    vacancy = json['vacancy'];
    detail = json['detail'];
    location = json['location'];
    salary = json['salary'];
    deadline = json['deadline'];
    applied = json['applied'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['vacancy'] = vacancy;
    data['detail'] = detail;
    data['location'] = location;
    data['salary'] = salary;
    data['deadline'] = deadline;
    data['applied'] = applied;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, title, vacancy, detail, location, salary, deadline];
}
