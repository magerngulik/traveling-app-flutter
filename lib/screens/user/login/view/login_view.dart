// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:healing_apps/screens/user/navigator/view/navigator_view.dart';
import 'package:healing_apps/shared/dialog/show_info_dialog.dart';

import 'package:healing_apps/shared/widget/button/q_button1/q_button1.dart';

import '../../../../logic/login/login_bloc.dart';
import '../../../../shared/show_loading/Q_loading.dart';
import '../../../../shared/util/validator/validator.dart';
import '../../../../shared/widget/container/q_dont_have_account/q_dont_have_accont.dart';
import '../../../../shared/widget/container/q_icon_apps/q_icon_apps.dart';
import '../../../../shared/widget/container/q_or/q_or.dart';
import '../../../../shared/widget/textfield/q_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var login = context.read<LoginBloc>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BlocConsumer<LoginBloc, LoginState>(
                bloc: login,
                listener: (context, state) async {
                  if (state is LoginLoaded) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavigatorView()),
                    );
                  }
                  if (state is LoginError) {
                    await showInfoDialog(state.error, context: context);
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const QLoading();
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50.0,
                        ),
                        QIconApps(),
                        const SizedBox(
                          height: 50.0,
                        ),
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        QTextfieldLogin(
                          title: "Email",
                          hintText: "Enter Your Email",
                          controller: email,
                          validator: Validator.required,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        QTextfieldLogin(
                          title: "Password",
                          hintText: "Enter Your Password",
                          obscureText: true,
                          controller: password,
                          validator: Validator.required,
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        QButton(
                          title: "Sign in",
                          ontap: () {
                            if (_formKey.currentState!.validate()) {
                              login.add(TryLogin(
                                  email: email.text, password: password.text));
                            }
                          },
                          backgroundColor: Colors.red[300],
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Qor(
                          sideContainer: false,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        QButton(
                          title: "Login with Google",
                          ontap: () {
                            print(
                                "email: ${email.text} password: ${password.text} ");
                          },
                          backgroundColor: Colors.black,
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        QDontHaveAccont(ontap: () {})
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
