import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/utils/theme/colors.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: kWhiteColor,),
        ),
        backgroundColor: kAppBarColor,
        title: Text(
          'FAQs',
          style: TextStyle(
            fontSize: 20.sp,
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: "AvarezoSerif",
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Frequently Asked Questions :',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: kBlueColor,
                ),
              ),
              SizedBox(height: 10.sp),

              _buildFAQItem(
                'How do I book a daycare session for my cat?',
                'You can book using our mobile app by filling out the booking form. Once booked, you will be notified.',
              ),
              _buildFAQItem(
                "Can I get updates about my cat's activities?",
                'Yes! Our app provides real-time updates in the form of photos, videos, and health status updates.',
              ),
              _buildFAQItem(
                'What are the business hours of daycare?',
                'We are open daily from 8:00 AM to 8:00 PM. Drop-off and pick-up times must be reserved in advance.',
              ),
              _buildFAQItem(
                  'Is there a registration process?',
                  "Yes, all pet owners must register on our app and provide their pet's information, such as health history and special needs.",
              ),
              _buildFAQItem(
                'Can I communicate with the daycare staff?',
                'Yes! Our in-app messaging feature allows you to chat directly with staff members for any updates or special instructions.',
              ),
              _buildFAQItem(
                  'What kind of services does SiManja offer?',
                  "We provide daycare services, overnight boarding, grooming, feeding, and playtime activities to keep your cat happy and comfortable while they're with us.",
              ),
              _buildFAQItem(
                  'What do I need to bring when I drop off my cat?',
                  "Bring your cat's food, medication (if applicable), favorite toy, and any special instructions for our staff.",
              ),
              _buildFAQItem(
                'Are there vaccination requirements?',
                'Yes, all cats must be up to date on vaccinations (rabies, distemper, and other shots required) before they can stay with us.',
              ),
              _buildFAQItem(
                'What is done if it is a medical emergency?',
                'In the event of an emergency, we will immediately call and inform you and take your cat to a local veterinary clinic for professional care.',
              ),
              _buildFAQItem(
                'Is my personal data safe in the app?',
                'Yes! We use encryption and secure data storage to protect your personal and pet information.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: kBlueColor,
            ),
          ),
          SizedBox(height: 5.sp),
          Text(
            answer,
            style: TextStyle(
              fontSize: 16.sp,
              color: kBlackColor,
              height: 1.5,
            ),
          ),
          SizedBox(height: 10.sp),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
