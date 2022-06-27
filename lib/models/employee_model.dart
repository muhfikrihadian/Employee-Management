class EmployeeModel {
  String id;
  String employeeName;
  String employeeSalary;
  String employeeAge;
  String profileImage;

  EmployeeModel({
      required this.id,
      required this.employeeName,
      required this.employeeSalary,
      required this.employeeAge,
      required this.profileImage
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
      id: json['id'],
      employeeName: json['employee_name'],
      employeeSalary: json['employee_salary'],
      employeeAge: json['employee_age'],
      profileImage: json['profile_image']);
}
