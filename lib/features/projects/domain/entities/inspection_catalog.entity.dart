class InspectionCatalog {
  final Map<String, dynamic> catalog;

  InspectionCatalog({required this.catalog});

  factory InspectionCatalog.fromJson(Map<String, dynamic> json) {
    return InspectionCatalog(catalog: json);
  }
  Map<String, dynamic> toJson() {
    return catalog;
  }
}
