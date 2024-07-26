import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/widgets/main_button.dart';
import 'package:school_daashboard/core/widgets/main_text_field.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final targetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications),
            Text('إرسال إشعار'),
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: context.scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 15,
                  spreadRadius: 1.5,
                  color: Colors.black.withOpacity(.1)),
            ],
          ),
          width: context.isAndroid ? .8.sw : .5.sw,
          height: .7.sh,
          padding: EdgeInsets.symmetric(horizontal: 25.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'إرسال إشعار',
                style: context.textTheme.titleLarge,
              ),
              MainTextField(
                controller: titleController,
                text: 'العنوان:',
              ),
              MainTextField(
                controller: descriptionController,
                text: 'الوصف:',
                maxLines: 3,
              ),
              MainTextField(
                controller: targetController,
                text: 'الجمهور:',
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: MainButton(
                  text: 'Send',
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
