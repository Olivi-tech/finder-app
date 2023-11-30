import 'dart:io';
import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/db_servies/cloud_services.dart';
import 'package:finder_app/providers/image_picker_provider.dart';
import 'package:finder_app/utils/app_utils.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController itemCountController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  late ImagePickerProvider imagePickerProvider;
  final globalKey = GlobalKey<FormState>();
  ValueNotifier<String> timeNotifier = ValueNotifier('');
  ValueNotifier<String> DateNotifier = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);

    Future.delayed(Duration.zero).then((value) {
      imagePickerProvider.setPath = '';
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    itemCountController.dispose();
    colorController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          title: const CustomText(
            text: ' Post ',
            letterSpacing: 1,
            color: AppColors.black,
            size: 18,
            weight: FontWeight.w500,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: globalKey,
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
                        String image = await AppUtils.getImageFromGallery();
                        if (image == '') return;
                        imagePickerProvider.setPath = image;
                      },
                      child: Consumer<ImagePickerProvider>(
                        builder: (context, imagePick, child) => Container(
                          height: 152,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lightwhite),
                          child: imagePick.path != ''
                              ? Image.file(File(imagePick.path))
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
                                      color: AppColors.blue,
                                      weight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                      text: 'Category',
                      letterSpacing: 1,
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                    CustomTextField(
                      readOnly: true,
                      hintText: 'Item category',
                      obscureText: false,
                      controller: categoryController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter Category';
                        }
                        return null;
                      },
                      suffixIcon: DropDownsWidget(
                        itemList: AppText.categoryList,
                        controller: categoryController,
                        onChanged: (String? selectedOption) {
                          categoryController.text = selectedOption ?? '';
                        },
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
                      hintText: 'Item name',
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
                      text: 'Brand',
                      letterSpacing: 1,
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                    CustomTextField(
                      readOnly: true,
                      hintText: 'Item brand',
                      obscureText: false,
                      controller: brandController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter Brand name';
                        }
                        return null;
                      },
                      suffixIcon: DropDownsWidget(
                        itemList: AppText.brandList,
                        controller: brandController,
                        onChanged: (String? selectedOption) {
                          brandController.text = selectedOption ?? '';
                        },
                      ),
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
                      hintText: 'Item quantity',
                      readOnly: true,
                      obscureText: false,
                      controller: itemCountController,
                      suffixIcon: DropDownsWidget(
                        itemList: List<String>.generate(
                            50, (index) => (index + 1).toString()),
                        controller: itemCountController,
                        onChanged: (String? selectedOption) {
                          itemCountController.text = selectedOption ?? '';
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
                      readOnly: true,
                      hintText: 'Black',
                      obscureText: false,
                      controller: colorController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter color';
                        }
                        return null;
                      },
                      suffixIcon: DropDownsWidget(
                        itemList: AppText.colorList,
                        controller: colorController,
                        onChanged: (String? selectedOption) {
                          colorController.text = selectedOption ?? '';
                        },
                      ),
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
                                ValueListenableBuilder(
                                  valueListenable: DateNotifier,
                                  builder: (context, date, child) => Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 0.2,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      date != ''
                                          ? (DateFormat('dd-MM-yyyy')
                                              .format((DateTime.parse(date))))
                                          : 'Date',
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                                  padding:
                                      const EdgeInsets.only(right: 8, left: 8),
                                  child: Icon(
                                    Icons.access_time,
                                    color: Colors.grey,
                                    size: 24,
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: timeNotifier,
                                  builder: (context, timeValue, child) =>
                                      Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 0.2,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      timeValue != '' ? timeValue : 'Time',
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                        if (globalKey.currentState!.validate()) {
                          if (DateNotifier.value != '' &&
                              timeNotifier.value != '') {
                            await CloudServices.uploadDataToFirebase(
                                context: context,
                                image: File(imagePickerProvider.path),
                                category: categoryController.text,
                                name: nameController.text,
                                brand: brandController.text,
                                quantity: int.parse(itemCountController.text),
                                color: colorController.text,
                                date: DateNotifier.value,
                                time: timeNotifier.value,
                                description: descriptionController.text);
                            imagePickerProvider.setPath = '';
                          } else {
                            CustomSnackBar.show(
                                context: context,
                                text: 'Please select date and time',
                                backgroundColor: Colors.red);
                          }
                        }
                      },
                      width: size.width,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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

    DateNotifier.value = picked.toString();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.blue,
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    ))!;

    timeNotifier.value = picked.format(context);
  }
}
