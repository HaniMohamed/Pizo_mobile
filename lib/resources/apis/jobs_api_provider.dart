import 'package:pizo/models/event.dart';
import 'package:pizo/models/job.dart';
import 'package:pizo/resources/constants.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class JobsAPI {
  Constants cons = new Constants();

  Future<List<Job>> getJobs(token) async {
    try {
      Response response =
          await Dio().get(cons.domain + "api/v1/jobs?token=" + token);
      final decoded = JSON.jsonDecode(response.toString());
      var list = decoded['jobs'] as List;
      List<Job> jobs = list.map((i) => Job.fromJson(i)).toList();
      return jobs;
    } catch (e) {
      print(e);
    }

    return null;
  }
}
