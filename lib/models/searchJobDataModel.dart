import 'package:flutter/material.dart';

class Job {
  final int id;
  final String job;
  final String canDoWorks;
  final String urlImage;

  const Job({
    required this.id,
    required this.job,
    required this.canDoWorks,
    required this.urlImage,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json['id'],
        job: json['job'],
        canDoWorks: json['canDoWorks'],
        urlImage: json['urlImage'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': job,
        'canDoWorks': canDoWorks,
        'urlImage': urlImage,
      };
}
