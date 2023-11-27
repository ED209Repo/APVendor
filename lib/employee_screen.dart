import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/Widgets/AppColors.dart';
import 'dart:io';
import 'employee.model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeesScreen extends StatefulWidget {
  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  List<Employee> employees = []; // Initialize the list of employees

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.themeColor2,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.employee, style: TextStyle(color: Colors.white, fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddEmployeeScreen(
                  onEmployeeAdded: (Employee? newEmployee) {
                    if (newEmployee != null) {
                      setState(() {
                        employees.add(newEmployee);
                      });
                    }
                  }
              )));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container( // Wrap the TextField with a Container
              decoration: BoxDecoration(
                color: Color(0xff358597).withOpacity(0.3),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchemployee,
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none, // Remove the border to let the container's decoration handle it
                ),
              ),
            ),
          ),
          Expanded(
            child: EmployeeList(employees: employees),
          ),
        ],
      ),
    );
  }
}

class EmployeeList extends StatelessWidget {
  final List<Employee> employees;

  EmployeeList({required this.employees});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final employee = employees[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('images/employee1.jpg'),
          ),
          title: Text(employee.name),
          subtitle: Text('${employee.designation} - ${employee.branch}'),
        );
      },
    );
  }
}

class AddEmployeeScreen extends StatefulWidget {
  final Function(Employee?) onEmployeeAdded;

  AddEmployeeScreen({required this.onEmployeeAdded});

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  String gender = '';
  File? selectedImageFile;
  DateTime? selectedDate;
  String imagePath = '';

  Future<void> openGallery() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImageFile = File(image.path);
      });
    }
  }

  Future<String?> saveSelectedImage() async {
    if (selectedImageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
      await selectedImageFile!.copy(imagePath);
      return imagePath;
    }
    return null;
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff358597),
          width: 3,
        ),
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double buttonHeight = screenHeight * 0.06;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.addemployee, style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: AppColors.themeColor2,
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.details,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: _inputDecoration('Name'),
            ),
            // SizedBox(height: 7),
            // TextField(
            //   controller: emailController,
            //   decoration: _inputDecoration('Email'),
            // ),
            SizedBox(height: 7),
            TextField(
              controller: phoneNumberController,
              decoration: _inputDecoration('Phone Number'),
            ),
            SizedBox(height: 7),
            TextField(
              controller: designationController,
              decoration: _inputDecoration('Designation'),
            ),
            SizedBox(height: 7),
            TextField(
              controller: branchController,
              decoration: _inputDecoration('Branch'),
            ),
            SizedBox(height: 7),
            Row(
              children: [
                Text('Gender:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Radio<String>(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Male'),
                Radio<String>(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
            SizedBox(height: 7),
            Row(
              children: [
                Text('Date Of Birth: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(selectedDate != null
                    ? DateFormat('dd-MM-yyyy').format(selectedDate!)
                    : ''),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          selectedDate = value;
                        });
                      }
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    await openGallery();
                  },
                ),
                Text('Add Profile Image', style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                String? imagePath = await saveSelectedImage();
                Employee newEmployee = Employee(
                  name: nameController.text,
                  phoneNumber: phoneNumberController.text,
                  designation: designationController.text,
                  branch: branchController.text,
                  gender: gender,
                  profileImage: imagePath ?? '', email: '',
                );
                widget.onEmployeeAdded(newEmployee);

                Navigator.pop(context);
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff358597)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(double.infinity, buttonHeight),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.addemployee),
            ),
          ],
        ),
      ),
    );
  }
}
