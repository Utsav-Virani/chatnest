import 'package:chatnest/Helpers/colorpanel.dart';
import 'package:chatnest/Helpers/countryCodes.dart';
import 'package:flutter/material.dart';

class CountrySelecter extends StatefulWidget {
  @override
  _CountrySelecterState createState() => _CountrySelecterState();
}

class _CountrySelecterState extends State<CountrySelecter> {
  // ignore: top_level_function_literal_block
  final codeToCountryEmoji = (code) {
    const int flagOffset = 0x1F1E6;
    const int asciiOffset = 0x41;
    final char1 = code.codeUnitAt(0) - asciiOffset + flagOffset;
    final char2 = code.codeUnitAt(1) - asciiOffset + flagOffset;
    return String.fromCharCode(char1) + String.fromCharCode(char2);
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: AppBar(
        // foregroundColor: ColorPalette['swatch_14'],
        backgroundColor: ColorPalette['primary'],
        title: Text("Select Country"),
        centerTitle: true,
        elevation: 10,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: country.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Map<String, String> _countryData = {
                  "name": country[index]['name'],
                  "code": country[index]['p_code'],
                };
                Navigator.of(context).pop(_countryData);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: ColorPalette['gray_0']),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Color(0xFF000000).withOpacity(0.2),
                  //     blurRadius: 5.0,
                  //     spreadRadius: 1.0,
                  //     offset: Offset(
                  //       4.0,
                  //       4.0,
                  //     ),
                  //   )
                  // ],
                ),
                child: ListTile(
                  leading: Text(
                    codeToCountryEmoji(country[index]['code']),
                    style: TextStyle(fontSize: 20),
                  ),
                  title: Text(country[index]['name']),
                  subtitle: Text(
                    country[index]['code'],
                    style: TextStyle(
                      color: ColorPalette['gray_3'],
                    ),
                  ),
                  trailing: Text(country[index]['p_code']),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
