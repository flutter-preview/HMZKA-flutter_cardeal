import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/constants.dart';

import 'cubit/app_cubit.dart';

class SellRequestsScreen extends StatelessWidget {
  const SellRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var sellRequest = AppCubit().get(context).sellRequests;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const Text("Sell Request"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: sellRequest.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.network(
                        "$baseUrl/media/${sellRequest[index].carModel?.imageUrl}",
                        width: MediaQuery.of(context).size.width / 2.7,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          "assets/images/cardeal.png",
                          width: MediaQuery.of(context).size.width / 2.7,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Buyer :${sellRequest[index].name}",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${sellRequest[index].carModel?.make} ${sellRequest[index].carModel?.model} ${sellRequest[index].carModel?.year}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                              "${sellRequest[index].price?.split('.').first} \$")
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              AppCubit().get(context).sellAction(
                                  id: sellRequest[index].id, action: "accept");
                            },
                            child: const Icon(Icons.task_alt)),
                        const SizedBox(
                          height: 7,
                        ),
                        GestureDetector(
                            onTap: () {
                              AppCubit().get(context).sellAction(
                                  id: sellRequest[index].id, action: "reject");
                            },
                            child: const Icon(Icons.delete))
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
