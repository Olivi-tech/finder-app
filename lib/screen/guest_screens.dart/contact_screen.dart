
import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';

class GuestContactScreen extends StatefulWidget {
  const GuestContactScreen({super.key});

  @override
  State<GuestContactScreen> createState() => _GuestContactScreenState();
}

class _GuestContactScreenState extends State<GuestContactScreen> {
  @override
  Widget build(BuildContext context) {
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
          text: 'Contact Us',
          letterSpacing: 1,
          color: Colors.black,
          size: 16,
          weight: FontWeight.w600,
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                child: CustomText(
                  text: 'Do You Want to Contact Us?',
                  color: Colors.black,
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w500,
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 500,
                width: 180,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final icons = [
                      Icons.phone,
                      Icons.email,
                      Icons.message,
                      Icons.security,
                    ];

                    final labels = [
                      'Phone',
                      'Email',
                      'Message',
                      'Key',
                    ];
                    final colors = [
                      Colors.green,
                      Colors.red,
                      Colors.blue,
                    ];
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: CustomContainer(
                        labelText: labels[index],
                        iconData: icons[index],
                        color: colors[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ]),
    );
  }
}
