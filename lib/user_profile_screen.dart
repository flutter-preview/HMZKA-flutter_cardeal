import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/cubit/app_cubit.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import 'app_cache.dart';

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
                  icon: Icon(Icons.star),
                  onPressed: () {},
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
                              style: TextStyle(
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
                            child: Text(
                              "Rate: ${CacheHelper.getData(key: "email")}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ])))));
      },
    );
  }

  showRateDialog(context) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        double rate = 0.0;
        return Dialog(
            child: Column(
          children: [
            SimpleStarRating(
              isReadOnly: false,
              allowHalfRating: true,
              rating: rate,
              onRated: (rating) {
                rate = rating!;
              },
            ),
            TextButton(onPressed: () {}, child: const Text("Rate"))
          ],
        ));
      }),
    );
  }
}
