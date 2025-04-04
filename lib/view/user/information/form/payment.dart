import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simanja/utils/theme/colors.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = 'Credit Card';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  void processPayment() {
    Get.snackbar("Payment Successful", "Your payment of \$99.99 has been processed successfully!", backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyle(color: kWhiteColor, fontSize: 20.sp),
        ),
        backgroundColor: kAppBarColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: kWhiteColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.sp),
            color: kWhiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Light shadow color
                spreadRadius: 2,                      // How much the shadow spreads
                blurRadius: 8,                         // Softness of the shadow
                offset: Offset(4, 4),                  // Position of the shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Select Payment Method", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                DropdownButtonFormField<String>(
                  value: selectedPaymentMethod,
                  items: ['Credit Card', 'PayPal', 'Google Pay'].map((method) {
                    return DropdownMenuItem(
                      value: method,
                      child: Text(method),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => selectedPaymentMethod = value!),
                ),
                SizedBox(height: 20.h),
                Text("Enter Payment Details", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Cardholder Name"),
                ),
                TextField(
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Card Number"),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: expiryController,
                        decoration: InputDecoration(labelText: "Expiry Date"),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TextField(
                        controller: cvvController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "CVV"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBlueColor,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
                  ),
                  onPressed: processPayment,
                  child: Center(
                    child: Text("Pay \$99.99", style: TextStyle(color: kWhiteColor, fontSize: 18.sp)),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}