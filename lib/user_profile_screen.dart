import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/cubit/app_cubit.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'app_cache.dart';
import 'car_details_screen.dart';
import 'components/components.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key, required this.name, required this.id});
  String name;
  String id;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              actions: [
                IconButton(
                  icon: const Icon(Icons.star),
                  onPressed: () {
                    showRateDialog(context);
                  },
                )
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            "https://th.bing.com/th/id/R.7b87218a34ce5cd9f6cb59ee78fb3e9e?rik=UTW4kuS%2b%2fT%2bdNA&riu=http%3a%2f%2fvignette2.wikia.nocookie.net%2fmafiagame%2fimages%2f2%2f23%2fUnknown_Person.png%2frevision%2flatest%2fscale-to-width-down%2f464%3fcb%3d20151119092211&ehk=VgKcVhhiQxAuqvkG%2b8mTd2v6Co6DYGjgWKn2kd0ok5w%3d&risl=&pid=ImgRaw&r=0"),
                      ),
                      Card(
                        color: Colors.grey.shade50,
                        elevation: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Name: $name",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.grey.shade50,
                        elevation: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Rate: ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                RatingStars(
                                  valueLabelVisibility: false,
                                  value: AppCubit().get(context).rate,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        children: AppCubit().get(context).userCar.map((e) {
                          return GestureDetector(
                            onTap: () {
                              pushNavigation(
                                  context, CarDetailsScreen(model: e));
                            },
                            child: Card(
                              shadowColor: Colors.black87,
                              elevation: 8,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Image.network(
                                    "${e.imageUrl}",
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      "assets/images/cardeal.png",
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      fit: BoxFit.cover,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    "${e.make}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text("${e.model} ${e.year}"),
                                  Text(
                                    "${e.price}  S.P",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    ])))));
      },
    );
  }

  showRateDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AppCubit, AppState>(
            listener: (context, state) {},
            builder: (context, state) {
              double rate = 0.0;
              return Dialog(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatefulBuilder(builder: (context, setState) {
                      return RatingStars(
                        valueLabelVisibility: false,
                        value: rate,
                        starSize: 25,
                        animationDuration: const Duration(milliseconds: 1400),
                        onValueChanged: (rating) {
                          setState(
                            () {
                              rate = rating;
                            },
                          );
                          Future.delayed(
                            const Duration(milliseconds: 1400),
                            () {
                              popNavigation(context);
                            },
                          );
                          AppCubit()
                              .get(context)
                              .rateUser(id: id, rate: rating.round());
                        },
                      );
                    }),
                  ],
                ),
              ));
            },
          );
        });
  }
}
