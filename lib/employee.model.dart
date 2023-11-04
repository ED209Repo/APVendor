class Employee {
  final String name;
  final String email;
  final String phoneNumber;
  final String designation;
  final String branch;
  final String gender;
  final String profileImage;

  Employee({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.designation,
    required this.branch,
    required this.gender,
    required this.profileImage,
  });
}

List<Employee> employees = [];
