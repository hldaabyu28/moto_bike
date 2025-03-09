import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:rent_motor/models/bike.dart';
import 'package:rent_motor/widgets/button_primary.dart';
import 'package:rent_motor/widgets/input.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.bike});
  final Bike bike;
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final edtName = TextEditingController();
  final edtStartDate = TextEditingController();
  final edtEndDate = TextEditingController();

  pickDate(TextEditingController editingController) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      initialDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      editingController.text = DateFormat('dd MM yyyy').format(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          buildHeader(),
          Gap(30),
          buildSnippetBike(),
          Gap(30),
          buildInput(),
          Gap(24),
          buildAgency(),
          Gap(24),
          buildInsurance(),
          Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonPrimary(
              text: 'Proceed to Checkout', 
              onTap: (){
                Navigator.pushNamed(context, '/checkout', arguments: {
                  'bike': widget.bike,
                  'startDate': edtStartDate.text,
                  'endDate': edtEndDate.text,
                });
              }
            ),
          )
        ],
      ),
    );
  }

   Widget buildInsurance() {
    final listAgency = ['Revolte', 'KBP City', 'Sumedap'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Insurance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Gap(12),
          SizedBox(
            height: 52,
            child: DropdownButtonFormField(
              value: 'Select Available Insurance',
              icon: Image.asset(
                'assets/ic_arrow_down.png',
                height: 20,
                width: 20,
              ),
              items: [
                'Select Available Insurance',
                'Jiwa Perkasa',
                'Kejiwaan',
                'Jiwa Perasaan',
              ].map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff070623),
                    ),
                  ),
                );
              }).toList(), 
              onChanged: (value){},
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.only(right: 16),
                prefixIcon: UnconstrainedBox(
                  alignment: const Alignment(0.2, 0),
                  child: Image.asset(
                    'assets/ic_insurance.png',
                    height: 24,
                    width: 24,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color(0xff4A1DFF),
                  )
                )
              ),
            ),
          )


        ],
      ),
    );
  }

  Widget buildAgency() {
    final listAgency = ['Revolte', 'KBP City', 'Sumedap'];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: const Text(
            'Agency',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
        ),
        Gap(32),
        SizedBox(
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listAgency.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(
                    left:  index == 0 ? 24 : 0,
                    right: index == listAgency.length - 1 ? 24 : 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: index == 1 ? Border.all(
                      width: 2,
                      color: const Color(0xff4A1DFF),
                    ): null
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/agency.png',
                        height: 38,
                        width: 38,
                      ),
                      Gap(10),
                      Text(
                        listAgency[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff070623),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget buildInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Complete Name',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Gap(12),
          Input(
              icon: 'assets/ic_profile.png',
              hint: 'Write your name',
              editingController: edtName),
          Gap(20),
          const Text(
            'Start Rent Date',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Gap(12),
          Input(
            icon: 'assets/calender.png',
            hint: 'Choose your date',
            enable: false,
               onTapBox: () => pickDate(edtStartDate),
            editingController: edtStartDate
          ),
          Gap(20),
          const Text(
            'End Date',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Gap(12),
          Input(
              icon: 'assets/calender.png',
              hint: 'Chose your date',
              enable: false,
              onTapBox: () => pickDate(edtEndDate),
              editingController: edtEndDate),
          Gap(20),
        ],
      ),
    );
  }

  Widget buildSnippetBike() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 98,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ExtendedImage.network(
            widget.bike.image,
            width: 90,
            height: 70,
            fit: BoxFit.contain,
          ),
          const Gap(10),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.bike.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff070623)),
              ),
              Text(
                widget.bike.category,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff838384)),
              ),
            ],
          )),
          Row(
            children: [
              Text(
                '${widget.bike.rating}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff070623)),
              ),
              Gap(4),
              const Icon(
                Icons.star,
                color: Color(0xffFFBC1C),
                size: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 46,
              width: 46,
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/ic_arrow_back.png',
                height: 24,
                width: 24,
              ),
            ),
          ),
          Expanded(
            child: const Text(
              'Booking',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff070623)),
            ),
          ),
          Container(
            height: 46,
            width: 46,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/ic_more.png',
              height: 24,
              width: 24,
            ),
          )
        ],
      ),
    );
  }
}
