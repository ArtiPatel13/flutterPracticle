

abstract class DashboardEvent{}

class DashboardEventSubmit extends DashboardEvent{
  DashboardEventSubmit();
}

class DashboardDetailsEvent extends DashboardEvent{
  int id;
  DashboardDetailsEvent({required this.id});
}

class DashboardSearchEvent extends DashboardEvent{
  String searchValue;
  DashboardSearchEvent({required this.searchValue});
}
class FilterEventSubmit extends DashboardEvent{
  Map<String, dynamic> request;
  FilterEventSubmit({required this.request });
}