import 'package:flutter/cupertino.dart';

class Job {
  final String? jid;
  final String? name;
  final String? service;
  String? imageurl;
  final String? nid;
  final String? phno;

  Job({
    required this.jid,
    required this.name,
    required this.service,
    required this.imageurl,
    required this.nid,
    required this.phno,
  });
}
