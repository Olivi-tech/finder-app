import 'dart:io';
import 'package:finder_app/constant/app_colors.dart';
import 'package:finder_app/db_servies/post_data.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController itemcountController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  File? image;
  bool loading = false;
  late String formattedTime;
  final picker = ImagePicker();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.green,
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    ))!;

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    ))!;

    if (picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No Image  picked !');
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    itemcountController.dispose();
    colorController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: const CustomText(
          text: ' Post Details',
          letterSpacing: 1,
          color: Colors.black,
          size: 18,
          weight: FontWeight.w500,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Upload Image',
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    getImageGallery();
                  },
                  child: Container(
                    height: 152,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.lightwhite),
                    child: image != null
                        ? Image.file(image!.absolute)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                size: 48,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const CustomText(
                                text: 'Browse',
                                letterSpacing: 1,
                                size: 12,
                                color: Colors.blue,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomText(
                  text: 'Name',
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w600,
                ),
                CustomTextField(
                  hintText: 'Item Name',
                  obscureText: false,
                  controller: nameController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomText(
                  text: 'Quantity',
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w600,
                ),
                CustomTextField(
                  hintText: '1',
                  readOnly: true,
                  obscureText: false,
                  controller: itemcountController,
                  suffixIcon: DropDownsWidget(
                    itemList: List<String>.generate(
                        5, (index) => (index + 1).toString()),
                    controller: itemcountController,
                    onChanged: (String? selectedOption) {
                      itemcountController.text = selectedOption ?? '';
                    },
                  ),
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomText(
                  text: 'Color',
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w600,
                ),
                CustomTextField(
                  hintText: 'Black',
                  obscureText: false,
                  controller: colorController,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter color';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomText(
                  text: 'Select Date & Time',
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                                size: 24,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 0.2,
                                  color: Colors.black,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                selectedDate != null
                                    ? DateFormat('dd-MM-yyyy')
                                        .format(selectedDate!)
                                    : 'Date',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              child: Icon(
                                Icons.access_time,
                                color: Colors.grey,
                                size: 24,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 0.2,
                                  color: Colors.black,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                formattedTime = selectedTime != null
                                    ? selectedTime!.format(context)
                                    : 'Time',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomText(
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w600,
                  text: 'Description',
                ),
                SizedBox(
                  height: 150,
                  child: CustomTextField(
                    hintText: 'Add Description',
                    obscureText: false,
                    controller: descriptionController,
                    maxLines: 40,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  text: 'Post',
                  btnColor: AppColors.green,
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      await DbService.uploadDataToFirebase(
                        context,
                        nameController.text,
                        descriptionController.text,
                        colorController.text,
                        int.parse(itemcountController.text),
                        selectedDate!,
                        formattedTime,
                        image!,
                      );
                    } catch (e) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Failed please add data correctly: $e',
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      print('failed: $e');
                    }
                  },
                  width: size.width,
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
