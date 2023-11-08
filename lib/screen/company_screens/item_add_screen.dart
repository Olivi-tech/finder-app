import 'dart:io';
import 'package:finder_app/constant/app_colors.dart';
import 'package:finder_app/db_servies/post_data.dart';
import 'package:finder_app/widget/custom_button.dart';
import 'package:finder_app/widget/custom_dropdown.dart';
import 'package:finder_app/widget/custom_text.dart';
import 'package:finder_app/widget/custom_textfield.dart';
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
            primaryColor: AppColors.darkGreen,
            hintColor: AppColors.darkGreen,
            colorScheme: ColorScheme.light(primary: AppColors.darkGreen),
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
            primaryColor: AppColors.darkGreen,
            hintColor: AppColors.darkGreen,
            colorScheme: ColorScheme.light(primary: AppColors.darkGreen),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const CustomText(
          text: 'Post',
          letterSpacing: 1,
          color: Colors.black,
          size: 16,
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
                                size: 24,
                                color: Colors.grey,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CustomText(
                                  text: 'Upload item image here',
                                  weight: FontWeight.w400,
                                  letterSpacing: 0.73,
                                  size: 10,
                                ),
                              ),
                              CustomText(
                                text: "Browse",
                                size: 10,
                                color: AppColors.green,
                                letterSpacing: 0.73,
                                weight: FontWeight.w400,
                              )
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
                  fillColor: Colors.white,
                  controller: nameController,
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
                  fillColor: Colors.white,
                  controller: itemcountController,
                  suffixIcon: DropDownsWidget(
                    itemList: List<String>.generate(
                        5, (index) => (index + 1).toString()),
                    controller: itemcountController,
                    onChanged: (String? selectedOption) {
                      itemcountController.text = selectedOption ?? '';
                    },
                  ),
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
                  fillColor: Colors.white,
                  controller: colorController,
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
                                  width: 0.5,
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
                                  width: 0.5,
                                  color: Colors.black,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                selectedTime != null
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
                  height: 10,
                ),
                const CustomText(
                  text: 'Description',
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w600,
                ),
                SizedBox(
                  height: 150,
                  child: CustomTextField(
                    hintText: 'Add Description of item here ',
                    fillColor: Colors.white,
                    controller: descriptionController,
                    maxLines: 40,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Post',
                  btnColor: AppColors.green,
                  textColor: Colors.white,
                  onPressed: () {
                     // DateTime dateTime = DateTime( selectedDate!.year, selectedDate!.month, selectedDate!.day, selectedTime!.hour, selectedTime!.minute,  );
                    try {
                       DbService.submitData(
                        context,
                        nameController.text,
                        descriptionController.text,
                        colorController.text,
                        int.parse(itemcountController.text),
                        selectedDate as DateTime,
                        selectedTime as TimeOfDay,
                        image,
                      );
                    } catch (e) {
                      print('Registration failed: $e');
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
