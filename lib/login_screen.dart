import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/components/components.dart';
import 'package:flutter_cardeal/main_screen.dart';
import 'package:flutter_cardeal/register_screen.dart';

import 'components/text_field.dart';
import 'cubit/app_cubit.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isScure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AppLoginSuccessState) {
          pushAndRemoveUntil(context, MainScreen());
          AppCubit().get(context).getMyCars();
          AppCubit().get(context).getBuyRequest();
          AppCubit().get(context).getCategories();
          AppCubit().get(context).getCars();
        } else if (state is AppLoginErrorState) {
          showSnackBarr(msg: "Something went wrong");
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Login",
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 15,
                                offset: Offset(1, 1),
                                color: Colors.black38)
                          ],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Image.asset(
                        "assets/images/cardeal.png",
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: MyTextField().build(
                      context,
                      hint: "example@gmail.com",
                      lable: const Text(
                        "Email",
                      ),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "email address is required";
                        } else if (!(value.contains("@"))) {
                          return "Invalid email";
                        }
                      },
                    ),
                  ),
                  MyTextField().build(context,
                      hint: "P@ssw0rd",
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                    if (value!.isEmpty) {
                      return "password is required";
                    }
                  },
                      controller: passwordController,
                      isSecure: isScure,
                      suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              isScure = !isScure;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility,
                          )),
                      lable: const Text(
                        "Password",
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)))),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AppCubit().get(context).login(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.all(12),
                          width: MediaQuery.of(context).size.width / 1.91,
                          child: state is! AppLoginLoadingState
                              ? const Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                ))),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have account?",
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ));
                        },
                        child: const Text("Create One"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
