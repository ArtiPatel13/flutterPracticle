class FilterModel {
  String? eyeColor;
  String? hairColor;

  FilterModel({this.eyeColor, this.hairColor});

  FilterModel.fromJson(Map<String, dynamic> json) {
    eyeColor = json['eyeColor'];
    hairColor = json['hairColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eyeColor'] = this.eyeColor;
    data['hairColor'] = this.hairColor;
    return data;
  }
}
