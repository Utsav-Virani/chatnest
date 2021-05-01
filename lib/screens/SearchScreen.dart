import 'package:chatnest/Helpers/HelperWidgets.dart';
import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchTextController = new TextEditingController();

  QuerySnapshot _searchResult;

  _searchUser(userName) async {
    // print(userName);
    FirebaseFirestore.instance
        .collection("UserData")
        .where("name", isEqualTo: userName)
        .get()
        .then((value) {
      setState(() {
        _searchResult = value;
      });
    });
  }

  Widget SearchResultList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _searchResult.docs.length,
        itemBuilder: (context, index) {
          return SearchResultCard(
            name: _searchResult.docs[index].data()["name"],
            email: _searchResult.docs[index].data()["email"],
            id: _searchResult.docs[index].id,
          );
        });
  }

  Widget SearchResultCard({String name, final String email, final String id}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, title: "Add Friends"),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorPalette['primary'],
              ),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 45,
                      child: TextFormField(
                        controller: _searchTextController,
                        onChanged: (val) {
                          _searchUser(val);
                        },
                        style: TextStyle(
                          color: ColorPalette['white_3'],
                        ),
                        textAlignVertical: TextAlignVertical.bottom,
                        autovalidateMode: AutovalidateMode.disabled,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefix: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.02),
                          ),
                          hintStyle: TextStyle(
                            color: ColorPalette['white_1'],
                          ),
                          suffix: SvgPicture.asset(
                            'assets/svgs/search.svg',
                            width: 24,
                            alignment: Alignment.center,
                            height: 24,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorPalette['white_3'],
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorPalette['white_3'],
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          focusColor: ColorPalette['white_2'],
                        ),
                        cursorColor: ColorPalette['white_2'],
                      ),
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.05,
                    //   child: SvgPicture.asset(
                    //     'assets/svgs/search.svg',
                    //     width: 20,
                    //     height: 20,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: _searchResult.docs.length > 0
                    ? SearchResultList()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Lottie.asset("assets/Animation/sad.json"),
                          ),
                          Text(
                            "No Userfound",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
