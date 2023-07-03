import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/constants.dart';
import 'package:flutter_cardeal/cubit/app_cubit.dart';

class BuyRequestScreen extends StatelessWidget {
  const BuyRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var buyrequest = AppCubit().get(context).buyRequest;
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: buyrequest.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Image.network(
                      "$baseUrl/media/${buyrequest[index].carModel?.imageUrl}",
                      width: MediaQuery.of(context).size.width / 2.7,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/images/cardeal.png",
                        width: MediaQuery.of(context).size.width / 2.7,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${buyrequest[index].carModel?.make} ${buyrequest[index].carModel?.model} ${buyrequest[index].carModel?.year}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text("${buyrequest[index].price?.split(".").first} \$")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppCubit()
                          .get(context)
                          .deleteCar(id: buyrequest[index].id);
                    },
                    child: const SizedBox(
                      child: CircleAvatar(
                        radius: 13.5,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
