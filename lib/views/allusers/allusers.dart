import 'package:apni_mandi/utils/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/color_manager.dart';
import '../../utils/constants/values_manager.dart';
import '../usersprofile/waiting_screen for users.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  final TextEditingController _searchControler = TextEditingController();
  List<Map> searchResult = [];
  bool isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchResult.clear;
    searchAll();
  }

  void searchAll() async {
    setState(() {
      isloading = true;
    });

    await FirebaseFirestore.instance
        .collection("usersAuthData")
        .get()
        .then((value) {
      for (var alluser in value.docs) {
        searchResult.add(alluser.data());
      }
      setState(() {
        isloading = false;
      });
    });
  }

  void onSearch() async {
    setState(() {
      isloading = true;
    });

    await FirebaseFirestore.instance
        .collection("usersAuthData")
        .where('name', isEqualTo: _searchControler.text.trim())
        .get()
        .then((value) {
      for (var alluser in value.docs) {
        searchResult.add(alluser.data());
      }
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.primaryColor,
          title: const Text(
            'All users',
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 70,
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 11, bottom: 13),
                      child: TextFormField(
                        controller: _searchControler,
                        obscureText: false,
                        enabled: true,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppSize.s22)),
                            borderSide:
                                BorderSide(color: ColorManager.primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppSize.s22)),
                            borderSide:
                                BorderSide(color: ColorManager.primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppSize.s22)),
                            borderSide:
                                BorderSide(color: ColorManager.redColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppSize.s22)),
                            borderSide:
                                BorderSide(color: ColorManager.redColor),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppSize.s22)),
                            borderSide:
                                BorderSide(color: ColorManager.primaryColor),
                          ),
                          hintText: "  Enter name",
                          hintStyle: TextStyle(fontSize: AppSize.s14),
                          fillColor: ColorManager.whiteColor,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: isloading == false
                        ? IconButton(
                            onPressed: () {
                              searchResult.clear();
                              onSearch();
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 40,
                              color: ColorManager.primaryColor,
                            ))
                        : const CircularProgressIndicator(
                            color: ColorManager.primaryColor,
                          ),
                  )
                ],
              ),
            ),
            const Divider(
              color: ColorManager.primaryColor,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('usersAuthData')
                      // .where("name", isEqualTo: _searchControler.text)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (searchResult.isNotEmpty) {
                      if (searchResult.isNotEmpty) {
                        return ListView.builder(
                            itemCount: searchResult.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                WaitingScreenUser(
                                                    searchResult[index]['id']),
                                          ));
                                    },
                                    child: ListTile(
                                      title: Text(
                                        searchResult[index]['name']
                                            .toString()
                                            .capitalize(),
                                        style: const TextStyle(
                                            color: ColorManager.primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(searchResult[index]
                                              ['email']
                                          .toString()),
                                    ),
                                  ),
                                  const Divider(
                                    color: ColorManager.primaryColor,
                                  )
                                ],
                              )

                                  //
                                  ;
                            });
                      }
                    }
                    return const Center(child: Text("Enter name to Search"));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
