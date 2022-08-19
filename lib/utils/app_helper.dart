import 'package:flutter/material.dart';

class AppHelper{
  static String? nameValidator(String? val){
    if(val!.isEmpty){
      return "Name is Required";
    }
    else if(!RegExp('[a-zA-Z]').hasMatch(val)){
      return "Please enter valid Name";
    }
    return null;
  }

  static String? emailValidator(String? val){
    if(val!.isEmpty){
      return "Email is Required";
    }
    else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)){
      return "Please enter valid Email";
    }
    return null;
  }

  static String? passwordValidator(String? val){
    if(val!.isEmpty){
      return "Password is Required";
    }
    else if(!RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}").hasMatch(val)){
      return "Please enter valid Password";
    }
    return null;
  }

  static String? phoneValidator(String? val){
    if (val!.isEmpty) {
      return 'Please enter phone number';
    }
    else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(val)) {
      return 'Please enter valid phone number';
    }
    return null;
  }
}