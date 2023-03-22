import 'dart:convert';

class ABExperiment {
  final String name;
  final String group;

  ABExperiment(String obj)
      : name = json.decode(obj)['name'],
        group = json.decode(obj)['group'];
}
