import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/color_manager.dart';
import '../../utils/constants/values_manager.dart';
import '../../utils/helpers/citeis_ProvincesList.dart';
import '../../utils/helpers/text_helper.dart';
import '../usersprofile/business_profile_of other users.dart';
import 'package:get/get.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  final TextEditingController _searchControler = TextEditingController();
  List<Map> searchResult = [];
  List<Map> filterdResult = [];
  List<Map> searchResultcity = [];
  String? stateValue;
  String? countryValue;
  String? cityValue;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    searchResult.clear;
    searchAll();
  }

  void searchAll() async {
    setState(() {
      isloading = true;
    });

    await FirebaseFirestore.instance
        .collection("usersBusinessData")
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

  void onSearchcity() async {
    setState(() {
      isloading = true;
    });

    await FirebaseFirestore.instance
        .collection("usersBusinessData")
        .where('city', isEqualTo: _searchControler.text.trim())
        .get()
        .then((value) {
      for (var alluser in value.docs) {
        searchResultcity.add(alluser.data());
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
        .collection("usersBusinessData")
        .where('businessName', isEqualTo: _searchControler.text.trim())
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
                      padding: const EdgeInsets.only(
                          left: 20, top: 8, bottom: 12, right: 22),
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
                          hintStyle: TextStyle(
                            fontSize: AppSize.s16,
                          ),
                          fillColor: ColorManager.whiteColor,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: Get.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorManager.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: DropdownButton<String>(
                    menuMaxHeight: Get.height * 0.7,
                    alignment: Alignment.center,
                    underline: Container(),
                    hint: const Text('Select city'),
                    value: cityValue,
                    items: pCity.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        cityValue = val!;
                      });
                    }),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.all(20),
            //   child: CSCPicker(
            //     ///Enable disable state dropdown [OPTIONAL PARAMETER]
            //     showStates: true,
            //     // defaultCountry: DefaultCountry.Pakistan,
            //     // disableCountry: true,

            //     /// Enable disable city drop down [OPTIONAL PARAMETER]
            //     showCities: true,

            //     ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
            //     flagState: CountryFlag.DISABLE,

            //     ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
            //     dropdownDecoration: BoxDecoration(
            //         borderRadius:
            //             const BorderRadius.all(Radius.circular(AppSize.s22)),
            //         color: Colors.white,
            //         border:
            //             Border.all(color: ColorManager.primaryColor, width: 1)),

            //     ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
            //     disabledDropdownDecoration: BoxDecoration(
            //         borderRadius:
            //             const BorderRadius.all(Radius.circular(AppSize.s22)),
            //         color: Colors.white,
            //         border:
            //             Border.all(color: ColorManager.primaryColor, width: 1)),

            //     ///placeholders for dropdown search field
            //     countrySearchPlaceholder: "Country",
            //     stateSearchPlaceholder: "State",
            //     citySearchPlaceholder: "City",

            //     ///labels for dropdown
            //     countryDropdownLabel: "Country",
            //     stateDropdownLabel: "State",
            //     cityDropdownLabel: "City",

            //     ///Default Country
            //     //defaultCountry: DefaultCountry.India,

            //     ///Disable country dropdown (Note: use it with default country)
            //     //disableCountry: true,

            //     ///selected item style [OPTIONAL PARAMETER]
            //     selectedItemStyle: const TextStyle(
            //       color: Colors.black,
            //       fontSize: 14,
            //     ),

            //     ///DropdownDialog Heading style [OPTIONAL PARAMETER]
            //     dropdownHeadingStyle: const TextStyle(
            //         color: Colors.black,
            //         fontSize: 17,
            //         fontWeight: FontWeight.bold),

            //     ///DropdownDialog Item style [OPTIONAL PARAMETER]
            //     dropdownItemStyle: TextStyle(
            //       color: Colors.black,
            //       fontSize: 14,
            //     ),

            //     ///Dialog box radius [OPTIONAL PARAMETER]
            //     dropdownDialogRadius: 10.0,

            //     ///Search bar radius [OPTIONAL PARAMETER]
            //     searchBarRadius: 10.0,

            //     ///triggers once country selected in dropdown
            //     onCountryChanged: (value) {
            //       setState(() {
            //         ///store value in country variable
            //         countryValue = value;
            //       });
            //     },

            //     ///triggers once state selected in dropdown
            //     onStateChanged: (value) {
            //       setState(() {
            //         ///store value in state variable
            //         stateValue = value;
            //       });
            //     },

            //     ///triggers once city selected in dropdown
            //     onCityChanged: (value) {
            //       setState(() {
            //         ///store value in city variable
            //         cityValue = value;
            //       });
            //     },
            //   ),
            // ),

            TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorManager.primaryColor)),
              onPressed: () {
                searchResult.clear();

                onSearch();
                onSearchcity();
              },
              child:
                  textStyle2(" search        ", TextAlign.center, Colors.white),
            ),
            const Divider(
              color: ColorManager.primaryColor,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: searchResult.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              //
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BussinessProfileofotherusers(
                                            searchResult[index]['id']),
                                  ));
                            },
                            child: _searchControler.text != null
                                ? cityValue == null
                                    ? searchResult != null
                                        ? ListTile(
                                            title: Text(
                                              searchResult[index]
                                                      ['businessName']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color:
                                                      ColorManager.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(searchResult[index]
                                                    ['email']
                                                .toString()),
                                          )
                                        : const Center(
                                            child: Text(
                                            "No user found",
                                          ))
                                    : SizedBox()
                                : cityValue.toString().trim() ==
                                        searchResult[index]['city']
                                    ? ListTile(
                                        title: Text(
                                          searchResult[index]['businessName']
                                              .toString(),
                                          style: const TextStyle(
                                              color: ColorManager.primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(searchResult[index]
                                                ['email']
                                            .toString()),
                                      )
                                    : SizedBox(),
                          ),
                          const Divider(
                            color: ColorManager.primaryColor,
                          )
                        ],
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
