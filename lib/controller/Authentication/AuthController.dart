
import 'package:flutter/material.dart';
import '../../model/Authentication/AuthModel.dart';
import 'package:get_storage/get_storage.dart';

class AuthController{
    final TextEditingController emailController = new TextEditingController();
    final TextEditingController passwordController = new TextEditingController();
    AuthModel authmodel = new AuthModel();
}