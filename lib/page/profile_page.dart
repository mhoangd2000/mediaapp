import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../component/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  //current user logined
  final User? currentUser = FirebaseAuth.instance.currentUser;

  //future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUSerDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: getUSerDetails(),
            builder: (context, snapshot) {
              //loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              //error
              else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }

              //data recieved
              else if (snapshot.hasData) {
                //extract the data
                Map<String, dynamic>? user = snapshot.data!.data();
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //back button
                      const Padding(
                        padding: EdgeInsets.only(top: 50, left: 15),
                        child: Row(
                          children: [
                            MyBackButton(),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //profile figure
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.all(25),
                        child: const Icon(
                          Icons.person,
                          size: 64,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        user!['username'],
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        user['email'],
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                );
              } else {
                return const Text("no data! ");
              }
            }));
  }
}
