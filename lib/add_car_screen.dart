import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/components/components.dart';
import 'package:flutter_cardeal/components/text_field.dart';
import 'package:flutter_cardeal/constants.dart';
import 'package:image_picker/image_picker.dart';

import 'cubit/app_cubit.dart';

class AddCarScreen extends StatefulWidget {
  AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  var formKey = GlobalKey<FormState>();
  var manufacturerController = TextEditingController();
  var milageController = TextEditingController();
  var modelController = TextEditingController();
  var colorController = TextEditingController();
  var yearController = TextEditingController();
  var descriptionController = TextEditingController();
  var typeController = TextEditingController();

  var transmissionController = TextEditingController();

  var fuelController = TextEditingController();

  var conditionController = TextEditingController();

  var priceController = TextEditingController();

  XFile? carImage;
  pickImage() async {
    carImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit().get(context);
        priceController.text = cubit.price?.split(".").first ?? "";
        return SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    dropdownButtonField(
                      context: context,
                      items: manufacturer.keys
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      hint: const Text("Manufacturer"),
                      validator: (value) {
                        if (value == null) {
                          return "This field is required";
                        }
                      },
                      onChanged: (value) {
                        manufacturerController.text = value;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextField().build(
                            context,
                            controller: modelController,
                            lable: const Text("Model"),
                            hint: "Passat",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Model is required";
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: MyTextField().build(context,
                              lable: const Text("Year"),
                              hint: "2010",
                              controller: yearController, validator: (value) {
                            RegExp regExp = RegExp(r'^\d{4}$');
                            if (value!.isEmpty) {
                              return "Year is required";
                            } else if (!(regExp.hasMatch(value))) {
                              return "It must be a year";
                            } else if (int.parse(value) > 2023) {
                              return "It must be less or equal 2023";
                            }
                            return null;
                          }, keyboardType: TextInputType.number),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: dropdownButtonField(
                              items: type.keys
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return "This field is required";
                                }
                              },
                              hint: const Text("Type"),
                              onChanged: (value) {
                                typeController.text = value;
                              },
                              context: context),
                        ),
                        Expanded(
                            child: MyTextField().build(
                          context,
                          lable: const Text("Color"),
                          controller: colorController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                          },
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: dropdownButtonField(
                                items: transmission.keys
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return "This field is required";
                                  }
                                },
                                hint: const Text("Transmission"),
                                onChanged: (value) {
                                  transmissionController.text = value;
                                },
                                context: context)),
                        Expanded(
                            child: dropdownButtonField(
                                items: fuel.keys
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                hint: const Text("Fuel"),
                                validator: (value) {
                                  if (value == null) {
                                    return "This field is required";
                                  }
                                },
                                onChanged: (value) {
                                  fuelController.text = value;
                                },
                                context: context))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: dropdownButtonField(
                              items: condition.keys
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              hint: const Text("Condition"),
                              validator: (value) {
                                if (value == null) {
                                  return "This field is required";
                                }
                              },
                              onChanged: (value) {
                                conditionController.text = value;
                              },
                              context: context),
                        ),
                        Expanded(
                          child: MyTextField().build(context,
                              lable: const Text("Mileage"),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          }, controller: milageController),
                        )
                      ],
                    ),
                    MyTextField().build(context,
                        hint: "Description", controller: descriptionController),
                    MyTextField().build(context,
                        lable: const Text("Price"),
                        hint: "10000000",
                        controller: priceController, validator: (value) {
                      if (value!.isEmpty) {
                        return "Price is required";
                      }
                      return null;
                    },
                        keyboardType: TextInputType.number,
                        suffix: IconButton(
                            onPressed: () {
                              AppCubit().get(context).getPrice(
                                  manfuctrer: manufacturerController.text,
                                  condition: conditionController.text,
                                  type: typeController.text,
                                  feul: fuelController.text,
                                  transmission: transmissionController.text,
                                  mileAge: milageController.text,
                                  year: yearController.text);
                            },
                            icon: const ImageIcon(
                                AssetImage("assets/images/magic.png")))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(carImage == null
                              ? "Select a photo for the car"
                              : carImage!.name),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            carImage != null
                                ? cubit.addCar(
                                    manfuctrer: manufacturerController.text,
                                    condition: conditionController.text,
                                    type: typeController.text,
                                    feul: fuelController.text,
                                    color: colorController.text,
                                    transmission: transmissionController.text,
                                    mileAge: milageController.text,
                                    year: yearController.text,
                                    description: descriptionController.text,
                                    price: priceController.text,
                                    model: modelController.text,
                                    image: carImage!)
                                : showSnackBarr(msg: "Image is required");
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: state is! AppAddCarCarLoadingState
                                ? const Text(
                                    "Save",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  ))),
                  ],
                )));
      },
    );
  }
}
