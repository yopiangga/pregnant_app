part of 'providers.dart';

class FilterProvider with ChangeNotifier {
  List<FilterModel> _filters = [
    FilterModel(id: "filter_1", title: "Agile Development", active: true),
    FilterModel(id: "filter_2", title: "Backend", active: false),
    FilterModel(id: "filter_3", title: "Front end", active: false),
    FilterModel(id: "filter_4", title: "Integrative Teaching", active: false),
  ];

  List<FilterModel> get filters => _filters;
}
