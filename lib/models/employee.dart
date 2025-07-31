class Employee {
  final int id;
  final String name;
  final double salary;

  Employee({
    required this.id,
    required this.name,
    required this.salary,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['Employee ID'] ?? json['id'],
      name: json['Employee Name'] ?? json['name'],
      salary: (json['Salary'] ?? json['salary'] ?? 0.0).toDouble(),
    );
  }
}
