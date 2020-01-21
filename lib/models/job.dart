import 'package:intl/intl.dart';
import 'package:pizo/resources/constants.dart';

Constants cons = new Constants();

class Job {
  var id, title, description, owner_id, category_id, owner_name;

  Job(
      {this.id,
      this.title,
      this.description,
      this.owner_id,
      this.category_id,
      this.owner_name});

  factory Job.fromJson(Map<String, dynamic> parsedJson) {
    return Job(
        id: parsedJson['id'],
        title: parsedJson['title'],
        description: parsedJson['description'],
        owner_id: parsedJson['owner_id'],
        category_id: parsedJson['category_id'],
        owner_name: parsedJson['owner_name']);
  }

  getID() {
    return id;
  }

  getTitle() {
    return title;
  }

  getDescription() {
    return description;
  }

  getOwnerID() {
    return owner_id;
  }

  getOwnerName() {
    return owner_name;
  }

  getCategoryID() {
    return category_id;
  }
}
