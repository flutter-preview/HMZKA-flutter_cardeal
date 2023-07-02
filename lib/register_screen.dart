import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/components/components.dart';
import 'components/text_field.dart';
import 'cubit/app_cubit.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isScure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AppRegisterSuccessState) {
          popNavigation(context);
          showSnackBarr(msg: "Please Login");
        } else if (state is AppRegisterErrorState) {
          showSnackBarr(msg: "Something went wrong");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Register",
            ),
          ),
          body: Form(
            key: formKey,
            child: Column(children: [
              MyTextField().build(
                context,
                controller: nameController,
                lable: const Text(
                  "Name",
                ),
                hint: "My Name",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  }
                },
              ),
              MyTextField().build(
                context,
                controller: emailController,
                lable: const Text(
                  "Email",
                ),
                hint: "example@example.com",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  } else if (!(value.contains("@"))) {
                    return "Invalid email";
                  }
                },
              ),
              MyTextField().build(
                context,
                controller: passwordController,
                lable: const Text(
                  "Password",
                ),
                isSecure: isScure,
                suffix: IconButton(
                  icon: const Icon(
                    Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      isScure = !isScure;
                    });
                  },
                ),
                hint: "P@ssw0rd",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  } else if (value.length < 8) {
                    return "password must be at least 8 characters";
                  }
                },
              ),
              MyTextField().build(
                context,
                hint: "Confirm password",
                isSecure: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  } else if (value != passwordController.text) {
                    return "password is not as match as the password";
                  }
                },
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AppCubit().get(context).register(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text);
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width / 1.91,
                      child: state is! AppRegisterLoadingState
                          ? const Text(
                              "Register",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ))),
            ]),
          ),
        );
      },
    );
  }
}
