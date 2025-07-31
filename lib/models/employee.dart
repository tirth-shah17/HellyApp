class Employee {
  final int id;
  final String name;
  final double salary;
  final String? pdfUrl;
  bool isShared;

  Employee({
    required this.id,
    required this.name,
    required this.salary,
    this.pdfUrl,
    this.isShared = false,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      salary: (json['salary'] ?? 0).toDouble(),
      pdfUrl: json['pdf_url'],
    );
  }
}
