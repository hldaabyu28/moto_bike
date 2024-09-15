import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rent_motor/common/info.dart';
import 'package:rent_motor/sources/auth_source.dart';
import 'package:rent_motor/widgets/button_primary.dart';
import 'package:rent_motor/widgets/button_secondary.dart';
import 'package:rent_motor/widgets/input.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final edtName = TextEditingController();
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();

  createNewAccount(){
    if (edtName.text == '') return Info.error('Name must be filled');
    if (edtEmail.text == '') return Info.error('Email must be filled');
    if (edtPassword.text == '') return Info.error('Password must be filled');

    Info.netral('Loading ...');
    AuthSource.signUp(
      edtName.text,
      edtEmail.text,
      edtPassword.text,     
    ).then((message) {
      if(message != 'success') return Info.error(message);

      Info.success('Success Sign Up');
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pushReplacementNamed(context, '/signin');
      });
    });
  
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        children: [
          const Gap(100),
          Image.asset(
            'assets/logo_text.png',
            height: 38,
            width: 171,
          ),
          const Gap(50),
          const Text(
            'Sign Up Account',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xff070623),
            ),
          ),
          Gap(30),
          const Text(
            'Complete Name',
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
            'Email Address',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Gap(12),
          Input(
              icon: 'assets/ic_email.png',
              hint: 'Write your email',
              editingController: edtEmail),
          Gap(20),
           const Text(
            'Password',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
          Gap(12),
          Input(
              icon: 'assets/ic_key.png',
              hint: 'Write your password',
              editingController: edtPassword,
              obscure: true
            ),
          Gap(30),
          ButtonPrimary(
            text: 'Create New Account', 
            onTap: (){
              createNewAccount();
            }),
          Gap(30),
          DottedLine(
            dashLength: 6,
            dashGapLength: 6,
            dashColor: const Color(0xffCECED5),
          ),
          Gap(30),
            ButtonSecondary(
            text: 'Sign In', 
            onTap: (){
                Navigator.pushReplacementNamed(context, '/signin');
          }),
          Gap(30),
        ],
      ),
    );
  }
}
