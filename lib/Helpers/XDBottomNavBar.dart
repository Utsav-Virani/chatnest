import 'package:chatnest/screens/MyProfileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XDBottomNavBar extends StatefulWidget {
  XDBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  _XDBottomNavBarState createState() => _XDBottomNavBarState();
}

class _XDBottomNavBarState extends State<XDBottomNavBar> {
  bool isLogoClicked = false;
  bool isSettingClicked = false;
  bool isPersonClicked = false;
  // bool onLogoTap = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //! Bottom Nav Background
        Pinned.fromPins(
          Pin(start: 0.0, end: 0.0),
          Pin(size: 80.0, end: 0.0),
          child:
              // Adobe XD layer: 'Path 5604' (shape)
              SvgPicture.string(
            _svg_7an9rp,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),

        //! App Logo

        !isLogoClicked
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isLogoClicked = !isLogoClicked;
                    isSettingClicked = false;
                    isPersonClicked = false;
                  });
                },
                child: Pinned.fromPins(
                  Pin(size: 65.0, middle: 0.4986),
                  Pin(size: 65.0, middle: 0.6569),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.elliptical(9999.0, 9999.0)),
                            color: const Color(0xffff7847),
                            border: Border.all(
                                width: 2.0, color: const Color(0xff171c26)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x4dff7847),
                                offset: Offset(4, 4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 36.6, middle: 0.5176),
                        Pin(size: 34.7, middle: 0.5165),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'New Layer' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(size: 10.4, middle: 0.2336),
                                    Pin(size: 10.4, start: 0.0),
                                    child: SvgPicture.string(
                                      _svg_esh31h,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 22.8, start: 0.0),
                                    Pin(size: 23.3, end: 0.0),
                                    child: SvgPicture.string(
                                      _svg_ioczbg,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 10.4, middle: 0.766),
                                    Pin(size: 10.4, start: 0.0),
                                    child: SvgPicture.string(
                                      _svg_ubhrwr,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 22.8, end: 0.0),
                                    Pin(size: 23.3, end: 0.0),
                                    child: SvgPicture.string(
                                      _svg_f7ykqm,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Pinned.fromPins(
                Pin(size: 190.0, middle: 0.5),
                Pin(size: 155.0, start: 0.0),
                child: Stack(
                  children: <Widget>[
                    Pinned.fromPins(
                      Pin(size: 70.0, middle: 0.5),
                      Pin(size: 70.0, end: 0.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isLogoClicked = !isLogoClicked;
                            isSettingClicked = false;
                            isPersonClicked = false;
                          });
                        },
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(9999.0, 9999.0)),
                                  color: const Color(0xff171c26),
                                  border: Border.all(
                                      width: 2.0,
                                      color: const Color(0xffff7847)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x1a292929),
                                      offset: Offset(4, 4),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 36.6, middle: 0.5),
                              Pin(size: 34.7, middle: 0.5),
                              child: Stack(
                                children: <Widget>[
                                  Pinned.fromPins(
                                    Pin(start: 0.0, end: 0.0),
                                    Pin(start: 0.0, end: 0.0),
                                    child:
                                        // Adobe XD layer: 'New Layer' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromPins(
                                          Pin(size: 10.4, middle: 0.2336),
                                          Pin(size: 10.4, start: 0.0),
                                          child: SvgPicture.string(
                                            _svg_yf4j62,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 22.8, start: 0.0),
                                          Pin(size: 23.3, end: 0.0),
                                          child: SvgPicture.string(
                                            _svg_uj8mw3,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 10.4, middle: 0.766),
                                          Pin(size: 10.4, start: 0.0),
                                          child: SvgPicture.string(
                                            _svg_8hzc56,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Pinned.fromPins(
                                          Pin(size: 22.8, end: 0.0),
                                          Pin(size: 23.3, end: 0.0),
                                          child: SvgPicture.string(
                                            _svg_6ljv0z,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Pinned.fromPins(
                      Pin(start: 0.0, end: 0.0),
                      Pin(size: 85.0, start: 0.0),
                      child: Stack(
                        children: <Widget>[
                          //! Chat Logo
                          Pinned.fromPins(
                            Pin(size: 50.0, middle: 0.5),
                            Pin(size: 50.0, start: 0.0),
                            child: Stack(
                              children: <Widget>[
                                Pinned.fromPins(
                                  Pin(start: 0.0, end: 0.0),
                                  Pin(start: 0.0, end: 0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(9999.0, 9999.0)),
                                      color: const Color(0xffff7847),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x1a292929),
                                          offset: Offset(4, 4),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Pinned.fromPins(
                                  Pin(size: 21.5, middle: 0.4911),
                                  Pin(size: 21.5, middle: 0.4911),
                                  child:
                                      // Adobe XD layer: 'Iconly/Light-Outlin…' (group)
                                      Stack(
                                    children: <Widget>[
                                      Pinned.fromPins(
                                        Pin(
                                            startFraction: 0.0,
                                            endFraction: 0.0),
                                        Pin(
                                            startFraction: 0.0,
                                            endFraction: 0.0),
                                        child:
                                            // Adobe XD layer: 'Chat' (group)
                                            Stack(
                                          children: <Widget>[
                                            Pinned.fromPins(
                                              Pin(
                                                  startFraction: 0.0,
                                                  endFraction: 0.0),
                                              Pin(
                                                  startFraction: 0.0,
                                                  endFraction: 0.0),
                                              child:
                                                  // Adobe XD layer: 'Combined Shape' (shape)
                                                  SvgPicture.string(
                                                _svg_53raek,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //! Call Logo
                          Pinned.fromPins(
                            Pin(size: 50.0, start: 0.0),
                            Pin(size: 50.0, end: 0.0),
                            child: Stack(
                              children: <Widget>[
                                Pinned.fromPins(
                                  Pin(start: 0.0, end: 0.0),
                                  Pin(start: 0.0, end: 0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(9999.0, 9999.0)),
                                      color: const Color(0xffff7847),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x1a292929),
                                          offset: Offset(4, 4),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Pinned.fromPins(
                                  Pin(size: 20.5, middle: 0.5085),
                                  Pin(size: 20.5, middle: 0.5085),
                                  child:
                                      // Adobe XD layer: 'Iconly/Light-Outlin…' (group)
                                      Stack(
                                    children: <Widget>[
                                      Pinned.fromPins(
                                        Pin(
                                            startFraction: 0.0,
                                            endFraction: 0.0),
                                        Pin(
                                            startFraction: 0.0,
                                            endFraction: 0.0),
                                        child:
                                            // Adobe XD layer: 'Call' (group)
                                            Stack(
                                          children: <Widget>[
                                            Pinned.fromPins(
                                              Pin(
                                                  startFraction: 0.0,
                                                  endFraction: 0.0),
                                              Pin(
                                                  startFraction: 0.0,
                                                  endFraction: 0.0),
                                              child:
                                                  // Adobe XD layer: 'Fill 1' (shape)
                                                  SvgPicture.string(
                                                _svg_hgxv9o,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //! Send Logo
                          Pinned.fromPins(
                            Pin(size: 50.0, end: 0.0),
                            Pin(size: 50.0, end: 0.0),
                            child: Stack(
                              children: <Widget>[
                                Pinned.fromPins(
                                  Pin(start: 0.0, end: 0.0),
                                  Pin(start: 0.0, end: 0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(9999.0, 9999.0)),
                                      color: const Color(0xffff7847),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x1a292929),
                                          offset: Offset(4, 4),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Pinned.fromPins(
                                  Pin(size: 19.5, middle: 0.459),
                                  Pin(size: 19.5, middle: 0.5246),
                                  child:
                                      // Adobe XD layer: 'Iconly/Light-Outlin…' (group)
                                      Stack(
                                    children: <Widget>[
                                      Pinned.fromPins(
                                        Pin(
                                            startFraction: 0.0,
                                            endFraction: 0.0),
                                        Pin(
                                            startFraction: 0.0,
                                            endFraction: 0.0),
                                        child:
                                            // Adobe XD layer: 'Send' (group)
                                            Stack(
                                          children: <Widget>[
                                            Pinned.fromPins(
                                              Pin(
                                                  startFraction: 0.0,
                                                  endFraction: 0.0),
                                              Pin(
                                                  startFraction: 0.0,
                                                  endFraction: 0.0),
                                              child:
                                                  // Adobe XD layer: 'Fill 1' (shape)
                                                  SvgPicture.string(
                                                _svg_yw24h1,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

        //! Setting ICON Light
        Pinned.fromPins(
          Pin(size: 50.0, start: 57.0),
          Pin(size: 60.0, end: 19.5),
          child: isSettingClicked
              ? Stack(
                  children: <Widget>[
                    Pinned.fromPins(
                      Pin(size: 15.0, middle: 0.483),
                      Pin(size: 1.0, start: 0.0),
                      child: SvgPicture.string(
                        _svg_hgrdrv,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Pinned.fromPins(
                      Pin(start: 0.0, end: 0.0),
                      Pin(start: 0.5, end: 0.0),
                      child: SvgPicture.string(
                        _svg_hyjlix,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                )
              : Stack(),
        ),

        //! Setting ICON
        GestureDetector(
          onTap: () {
            setState(() {
              isSettingClicked = true;
              isPersonClicked = false;
              isLogoClicked = false;
            });
          },
          child: Pinned.fromPins(
            Pin(size: 50.0, start: 57.0),
            Pin(size: 52.1, end: 11.4),
            child:
                // Adobe XD layer: 'Iconly/Light-Outlin…' (group)
                Padding(
              padding: EdgeInsets.all(10.0),
              child: Stack(
                children: <Widget>[
                  Pinned.fromPins(
                    Pin(size: 30.0, middle: 0.125),
                    Pin(size: 32.1, middle: 0.0625),
                    child:
                        // Adobe XD layer: 'Setting' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromPins(
                          Pin(start: 0.0, end: 0.0),
                          Pin(start: 0.0, end: 0.0),
                          child:
                              // Adobe XD layer: 'Combined Shape' (shape)
                              SvgPicture.string(
                            _svg_jhlusc,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //! PROFILE ICON Light
        Pinned.fromPins(
          Pin(size: 50.0, end: 55.0),
          Pin(size: 60.0, end: 19.5),
          child: isPersonClicked
              ? Stack(
                  children: <Widget>[
                    Pinned.fromPins(
                      Pin(size: 15.0, middle: 0.483),
                      Pin(size: 1.0, start: 0.0),
                      child: SvgPicture.string(
                        _svg_hgrdrv,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Pinned.fromPins(
                      Pin(start: 0.0, end: 0.0),
                      Pin(start: 0.5, end: 0.0),
                      child: SvgPicture.string(
                        _svg_hyjlix,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                )
              : Stack(),
        ),

        //! PROFILE ICON
        GestureDetector(
          onTap: () {
            setState(() {
              isPersonClicked = true;
              isSettingClicked = false;
              isLogoClicked = false;
            });
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(seconds: 0),
                pageBuilder: (context, animation1, animation2) => MyProfile(),
              ),
            );
          },
          child: Pinned.fromPins(
            Pin(size: 46.5, end: 56.9),
            Pin(size: 52.0, end: 11.4),
            child:
                // Adobe XD layer: 'Iconly/Light-Outlin…' (group)
                Padding(
              padding: EdgeInsets.all(10.0),
              child: Stack(
                children: <Widget>[
                  Pinned.fromPins(
                    Pin(size: 26.5, middle: 0.125),
                    Pin(size: 32.0, middle: 0.5),
                    child:
                        // Adobe XD layer: 'Profile' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromPins(
                          Pin(start: 0.0, end: 0.0),
                          Pin(start: 0.0, end: 0.0),
                          child:
                              // Adobe XD layer: 'Combined Shape' (shape)
                              SvgPicture.string(
                            _svg_kavnnp,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //! App Logo
        // Pinned.fromPins(
        //   Pin(size: 190.0, middle: 0.5),
        //   Pin(size: 155.0, start: 0.0),
        //   child: Stack(
        //     children: <Widget>[
        //       Pinned.fromPins(
        //         Pin(size: 70.0, middle: 0.5),
        //         Pin(size: 70.0, end: 0.0),
        //         child: Stack(
        //           children: <Widget>[
        //             Pinned.fromPins(
        //               Pin(start: 0.0, end: 0.0),
        //               Pin(start: 0.0, end: 0.0),
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.all(
        //                       Radius.elliptical(9999.0, 9999.0)),
        //                   color: const Color(0xff171c26),
        //                   border: Border.all(
        //                       width: 2.0, color: const Color(0xffff7847)),
        //                   boxShadow: [
        //                     BoxShadow(
        //                       color: const Color(0x1a292929),
        //                       offset: Offset(4, 4),
        //                       blurRadius: 6,
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             Pinned.fromPins(
        //               Pin(size: 36.6, middle: 0.5),
        //               Pin(size: 34.7, middle: 0.5),
        //               child: Stack(
        //                 children: <Widget>[
        //                   Pinned.fromPins(
        //                     Pin(start: 0.0, end: 0.0),
        //                     Pin(start: 0.0, end: 0.0),
        //                     child:
        //                         // Adobe XD layer: 'New Layer' (group)
        //                         Stack(
        //                       children: <Widget>[
        //                         Pinned.fromPins(
        //                           Pin(size: 10.4, middle: 0.2336),
        //                           Pin(size: 10.4, start: 0.0),
        //                           child: SvgPicture.string(
        //                             _svg_yf4j62,
        //                             allowDrawingOutsideViewBox: true,
        //                             fit: BoxFit.fill,
        //                           ),
        //                         ),
        //                         Pinned.fromPins(
        //                           Pin(size: 22.8, start: 0.0),
        //                           Pin(size: 23.3, end: 0.0),
        //                           child: SvgPicture.string(
        //                             _svg_uj8mw3,
        //                             allowDrawingOutsideViewBox: true,
        //                             fit: BoxFit.fill,
        //                           ),
        //                         ),
        //                         Pinned.fromPins(
        //                           Pin(size: 10.4, middle: 0.766),
        //                           Pin(size: 10.4, start: 0.0),
        //                           child: SvgPicture.string(
        //                             _svg_8hzc56,
        //                             allowDrawingOutsideViewBox: true,
        //                             fit: BoxFit.fill,
        //                           ),
        //                         ),
        //                         Pinned.fromPins(
        //                           Pin(size: 22.8, end: 0.0),
        //                           Pin(size: 23.3, end: 0.0),
        //                           child: SvgPicture.string(
        //                             _svg_6ljv0z,
        //                             allowDrawingOutsideViewBox: true,
        //                             fit: BoxFit.fill,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Pinned.fromPins(
        //         Pin(start: 0.0, end: 0.0),
        //         Pin(size: 85.0, start: 0.0),
        //         child: Stack(
        //           children: <Widget>[
        //             //! Chat Logo
        //             Pinned.fromPins(
        //               Pin(size: 50.0, middle: 0.5),
        //               Pin(size: 50.0, start: 0.0),
        //               child: Stack(
        //                 children: <Widget>[
        //                   Pinned.fromPins(
        //                     Pin(start: 0.0, end: 0.0),
        //                     Pin(start: 0.0, end: 0.0),
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.all(
        //                             Radius.elliptical(9999.0, 9999.0)),
        //                         color: const Color(0xffff7847),
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: const Color(0x1a292929),
        //                             offset: Offset(4, 4),
        //                             blurRadius: 6,
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                   Pinned.fromPins(
        //                     Pin(size: 21.5, middle: 0.4911),
        //                     Pin(size: 21.5, middle: 0.4911),
        //                     child:
        //                         // Adobe XD layer: 'Iconly/Light-Outlin…' (group)
        //                         Stack(
        //                       children: <Widget>[
        //                         Pinned.fromPins(
        //                           Pin(startFraction: 0.0, endFraction: 0.0),
        //                           Pin(startFraction: 0.0, endFraction: 0.0),
        //                           child:
        //                               // Adobe XD layer: 'Chat' (group)
        //                               Stack(
        //                             children: <Widget>[
        //                               Pinned.fromPins(
        //                                 Pin(
        //                                     startFraction: 0.0,
        //                                     endFraction: 0.0),
        //                                 Pin(
        //                                     startFraction: 0.0,
        //                                     endFraction: 0.0),
        //                                 child:
        //                                     // Adobe XD layer: 'Combined Shape' (shape)
        //                                     SvgPicture.string(
        //                                   _svg_53raek,
        //                                   allowDrawingOutsideViewBox: true,
        //                                   fit: BoxFit.fill,
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),

        //             //! Call Logo
        //             Pinned.fromPins(
        //               Pin(size: 50.0, start: 0.0),
        //               Pin(size: 50.0, end: 0.0),
        //               child: Stack(
        //                 children: <Widget>[
        //                   Pinned.fromPins(
        //                     Pin(start: 0.0, end: 0.0),
        //                     Pin(start: 0.0, end: 0.0),
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.all(
        //                             Radius.elliptical(9999.0, 9999.0)),
        //                         color: const Color(0xffff7847),
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: const Color(0x1a292929),
        //                             offset: Offset(4, 4),
        //                             blurRadius: 6,
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                   Pinned.fromPins(
        //                     Pin(size: 20.5, middle: 0.5085),
        //                     Pin(size: 20.5, middle: 0.5085),
        //                     child:
        //                         // Adobe XD layer: 'Iconly/Light-Outlin…' (group)
        //                         Stack(
        //                       children: <Widget>[
        //                         Pinned.fromPins(
        //                           Pin(startFraction: 0.0, endFraction: 0.0),
        //                           Pin(startFraction: 0.0, endFraction: 0.0),
        //                           child:
        //                               // Adobe XD layer: 'Call' (group)
        //                               Stack(
        //                             children: <Widget>[
        //                               Pinned.fromPins(
        //                                 Pin(
        //                                     startFraction: 0.0,
        //                                     endFraction: 0.0),
        //                                 Pin(
        //                                     startFraction: 0.0,
        //                                     endFraction: 0.0),
        //                                 child:
        //                                     // Adobe XD layer: 'Fill 1' (shape)
        //                                     SvgPicture.string(
        //                                   _svg_hgxv9o,
        //                                   allowDrawingOutsideViewBox: true,
        //                                   fit: BoxFit.fill,
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),

        //             //! Send Logo
        //             Pinned.fromPins(
        //               Pin(size: 50.0, end: 0.0),
        //               Pin(size: 50.0, end: 0.0),
        //               child: Stack(
        //                 children: <Widget>[
        //                   Pinned.fromPins(
        //                     Pin(start: 0.0, end: 0.0),
        //                     Pin(start: 0.0, end: 0.0),
        //                     child: Container(
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.all(
        //                             Radius.elliptical(9999.0, 9999.0)),
        //                         color: const Color(0xffff7847),
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: const Color(0x1a292929),
        //                             offset: Offset(4, 4),
        //                             blurRadius: 6,
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                   Pinned.fromPins(
        //                     Pin(size: 19.5, middle: 0.459),
        //                     Pin(size: 19.5, middle: 0.5246),
        //                     child:
        //                         // Adobe XD layer: 'Iconly/Light-Outlin…' (group)
        //                         Stack(
        //                       children: <Widget>[
        //                         Pinned.fromPins(
        //                           Pin(startFraction: 0.0, endFraction: 0.0),
        //                           Pin(startFraction: 0.0, endFraction: 0.0),
        //                           child:
        //                               // Adobe XD layer: 'Send' (group)
        //                               Stack(
        //                             children: <Widget>[
        //                               Pinned.fromPins(
        //                                 Pin(
        //                                     startFraction: 0.0,
        //                                     endFraction: 0.0),
        //                                 Pin(
        //                                     startFraction: 0.0,
        //                                     endFraction: 0.0),
        //                                 child:
        //                                     // Adobe XD layer: 'Fill 1' (shape)
        //                                     SvgPicture.string(
        //                                   _svg_yw24h1,
        //                                   allowDrawingOutsideViewBox: true,
        //                                   fit: BoxFit.fill,
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

const String _svg_esh31h =
    '<svg viewBox="6.1 0.0 10.4 10.4" ><path transform="translate(-101.16, -46.5)" d="M 111.8055801391602 46.5462760925293 C 108.9667663574219 46.92368698120117 106.9696350097656 49.5284538269043 107.3419723510742 52.36794281005859 C 107.7143173217773 55.20743179321289 110.3155212402344 57.2092170715332 113.1556701660156 56.84194183349609 C 115.9958114624023 56.47465896606445 118.0022430419922 53.87702560424805 117.6400299072266 51.03622817993164 C 117.2627792358398 48.17843246459961 114.6444320678711 46.15955352783203 111.8055801391602 46.5462760925293 Z M 112.8942642211914 49.13016510009766 C 113.4372711181641 49.21150588989258 113.9376525878906 49.4715461730957 114.3162689208984 49.86916732788086 C 114.8105545043945 50.34736251831055 115.0896148681641 51.00566482543945 115.0896148681641 51.69339752197266 C 115.0896148681641 52.38113021850586 114.8105316162109 53.0394287109375 114.3162689208984 53.51762771606445 C 113.5740737915039 54.25032043457031 112.4655151367188 54.46789169311523 111.5014343261719 54.07008743286133 C 110.5373382568359 53.67227554321289 109.90478515625 52.73628997802734 109.8952255249023 51.69339752197266 C 109.8933029174805 51.00490570068359 110.1734237670898 50.34566497802734 110.6703872680664 49.86916732788086 C 110.8260650634766 49.70535659790039 111.0027313232422 49.56287002563477 111.1957855224609 49.44540786743164 C 111.7106552124023 49.15305328369141 112.3088760375977 49.04232406616211 112.8942642211914 49.13103866577148 Z" fill="#292929" stroke="none" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ioczbg =
    '<svg viewBox="0.0 11.4 22.8 23.3" ><path transform="translate(-35.0, -171.53)" d="M 45.41654205322266 182.9446258544922 C 41.11005401611328 183.2693481445313 37.4391975402832 185.5009918212891 35.83201217651367 188.7739105224609 C 35.56585311889648 189.281982421875 35.36335372924805 189.8209228515625 35.22910690307617 190.3785247802734 C 35.04306411743164 191.1140747070313 35 191.4758148193359 35 192.2949066162109 C 35 193.1139984130859 35.04306411743164 193.4766235351563 35.22910308837891 194.2156066894531 C 35.36348342895508 194.773193359375 35.56597900390625 195.3120880126953 35.83201217651367 195.8201904296875 C 36.48220825195313 197.1263732910156 37.42868804931641 198.2624969482422 38.59592819213867 199.1379241943359 L 38.89306640625 199.3678741455078 L 38.90857315063477 202.7941436767578 L 38.924072265625 206.2169647216797 L 42.78872299194336 203.9594879150391 L 46.65336990356445 201.6994323730469 L 47.17961883544922 201.6624145507813 C 47.7705078125 201.6222991943359 48.35878372192383 201.5501251220703 48.94184494018555 201.4462127685547 C 52.62474822998047 200.7407989501953 55.57986831665039 198.6754150390625 56.981201171875 195.8219299316406 C 57.24649810791016 195.3134918212891 57.44894790649414 194.7746734619141 57.58411407470703 194.2173309326172 C 57.76929092407227 193.4783325195313 57.81235122680664 193.1165924072266 57.81235122680664 192.2966461181641 C 57.81235122680664 191.4766693115234 57.76929092407227 191.1157989501953 57.58411407470703 190.3768005371094 C 57.45391464233398 189.842529296875 57.26289367675781 189.3249664306641 57.01478576660156 188.8342132568359 C 56.78654861450195 188.3579254150391 56.45839691162109 187.8006591796875 56.4118766784668 187.8006591796875 C 56.36537551879883 187.8006591796875 55.65394592285156 188.2089080810547 55.39124298095703 188.3915100097656 C 55.04940414428711 188.6261138916016 54.72499847412109 188.8851928710938 54.42055892944336 189.1666870117188 L 54.20695877075195 189.3578796386719 L 54.3240966796875 189.5404815673828 C 54.64742279052734 190.0747680664063 54.88623809814453 190.6558380126953 55.03208160400391 191.2630615234375 C 55.27324676513672 192.4318542480469 55.12509918212891 193.4860992431641 54.56525802612305 194.5962982177734 C 53.92273330688477 195.8762054443359 52.79356384277344 196.9364318847656 51.26303482055664 197.6969604492188 C 49.90304946899414 198.3748168945313 48.41558837890625 198.7365570068359 46.75241851806641 198.7917022705078 L 46.17103958129883 198.8106231689453 L 45.73177719116211 199.0638732910156 C 45.49406051635742 199.2033996582031 44.95660781860352 199.5091400146484 44.53801727294922 199.7442932128906 C 44.11943054199219 199.9794158935547 43.28569030761719 200.4557189941406 42.68278121948242 200.8019714355469 L 41.58290481567383 201.4350128173828 L 41.57343292236328 199.5711517333984 L 41.56395721435547 197.7098846435547 L 41.39169311523438 197.623779296875 C 40.3161735534668 197.0800933837891 39.38378524780273 196.2908020019531 38.66999053955078 195.3198089599609 C 38.36437225341797 194.8583679199219 38.11539077758789 194.3618621826172 37.92841720581055 193.8409729003906 C 37.49776458740234 192.5179901123047 37.60628890991211 191.2716979980469 38.24967956542969 189.9917907714844 C 39.24189376831055 188.0185546875 41.41236877441406 186.5595092773438 44.17971801757813 186.0057067871094 C 44.97814559936523 185.8455047607422 45.4415283203125 185.8050384521484 46.40617752075195 185.8050384521484 C 47.37083435058594 185.8050384521484 47.8350715637207 185.8455047607422 48.63263702392578 186.0057067871094 C 49.08908462524414 186.0920257568359 49.53870391845703 186.2112121582031 49.97798156738281 186.3623046875 C 50.08388519287109 186.4016571044922 50.19202041625977 186.4347381591797 50.30183029174805 186.4613342285156 C 50.30183029174805 186.4613342285156 50.37331771850586 186.3708953857422 50.45685958862305 186.2692565917969 C 50.96028137207031 185.6591949462891 51.53318786621094 185.1100158691406 52.16395950317383 184.6328125 L 52.52226257324219 184.3640747070313 L 52.13984298706055 184.1814880371094 C 50.12612533569336 183.2202758789063 47.69554138183594 182.7749786376953 45.41654205322266 182.9446258544922 Z" fill="#292929" stroke="none" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ubhrwr =
    '<svg viewBox="20.1 0.0 10.4 10.4" ><path transform="translate(-252.09, -46.63)" d="M 276.9089660644531 46.65397262573242 C 275.6876220703125 46.79866790771484 274.6560668945313 47.27468109130859 273.8143310546875 48.08200454711914 C 273.02880859375 48.8326301574707 272.497802734375 49.81023025512695 272.2958374023438 50.87778091430664 C 272.2036743164063 51.33771133422852 272.19677734375 52.27481079101563 272.2803344726563 52.71062088012695 C 272.3856506347656 53.29347610473633 272.5873413085938 53.85469055175781 272.877197265625 54.37121200561523 C 273.6308288574219 55.71296691894531 274.9393920898438 56.65260696411133 276.4515991210938 56.93788146972656 C 277.0827941894531 57.03693771362305 277.7255859375 57.03693771362305 278.3567810058594 56.93788146972656 C 279.868896484375 56.65281677246094 281.17724609375 55.71308517456055 281.9302978515625 54.37121200561523 C 282.2205200195313 53.8548583984375 282.4223022460938 53.2935791015625 282.5272216796875 52.71062850952148 C 282.6133422851563 52.27481079101563 282.6047058105469 51.33771133422852 282.5116882324219 50.87778091430664 C 282.0810546875 48.73745346069336 280.5057373046875 47.15438842773438 278.3714294433594 46.7245979309082 C 277.8870544433594 46.65707015991211 277.3975830078125 46.63343048095703 276.9089660644531 46.65396499633789 Z M 277.8064575195313 49.26629257202148 C 278.3493041992188 49.34800338745117 278.849609375 49.60798263549805 279.2284545898438 50.00529098510742 C 279.7222900390625 50.48372650146484 280.0010375976563 51.14192962646484 280.0010375976563 51.82951736450195 C 280.0010375976563 52.5171012878418 279.7222900390625 53.17530822753906 279.2284545898438 53.65374755859375 C 278.4859924316406 54.38618850708008 277.3775329589844 54.60359954833984 276.4134216308594 54.20587158203125 C 275.4493408203125 53.80813598632813 274.8165893554688 52.87237930297852 274.8065795898438 51.82951736450195 C 274.8042907714844 51.14096450805664 275.0845031738281 50.48160934448242 275.5816650390625 50.00529098510742 C 275.7373962402344 49.84147644042969 275.9140014648438 49.6989860534668 276.1070861816406 49.58152770996094 C 276.6220703125 49.28868103027344 277.2206420898438 49.17764663696289 277.806396484375 49.26629257202148 Z" fill="#292929" stroke="none" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_f7ykqm =
    '<svg viewBox="13.8 11.4 22.8 23.3" ><path transform="translate(-186.28, -171.57)" d="M 210.5265197753906 182.9789733886719 C 208.2234191894531 183.1512145996094 206.0245056152344 183.8885040283203 204.2648773193359 185.082275390625 C 202.77197265625 186.0922698974609 201.6640625 187.3331298828125 200.9411315917969 188.8047943115234 C 200.6761169433594 189.3133697509766 200.4736633300781 189.8521423339844 200.3382263183594 190.4093933105469 C 200.1530456542969 191.1483917236328 200.1099700927734 191.5101470947266 200.1099700927734 192.3292541503906 C 200.0995330810547 192.6910095214844 200.1179809570313 193.0530548095703 200.1651000976563 193.4119110107422 C 200.2559814453125 193.958984375 200.3916625976563 194.4976654052734 200.5707855224609 195.0225219726563 C 200.8237762451172 195.667236328125 201.1411743164063 196.2847595214844 201.5182037353516 196.86572265625 C 201.5431671142578 196.8993072509766 202.0496063232422 196.6211090087891 202.4578704833984 196.3489227294922 C 202.8344116210938 196.0988006591797 203.1893615722656 195.817626953125 203.5189971923828 195.5082855224609 L 203.7446441650391 195.2981567382813 L 203.6128692626953 195.0957336425781 C 203.3799285888672 194.7063446044922 203.1852111816406 194.2953033447266 203.0315093994141 193.8683624267578 C 202.8614501953125 193.3733062744141 202.7817993164063 192.8516540527344 202.7963562011719 192.3283996582031 C 202.7850646972656 192.0246124267578 202.8090362548828 191.7205352783203 202.8678588867188 191.4223022460938 C 203.0883331298828 190.3112030029297 203.6367034912109 189.3201446533203 204.512939453125 188.4490814208984 C 205.8910064697266 187.0709991455078 207.8892211914063 186.1735382080078 210.2018127441406 185.8918914794922 C 210.638427734375 185.8472442626953 211.077392578125 185.8297119140625 211.5161743164063 185.8393707275391 C 212.4808044433594 185.8393707275391 212.9441833496094 185.8798370361328 213.7426300048828 186.0400390625 C 214.7243041992188 186.2231750488281 215.6726989746094 186.5536193847656 216.5556335449219 187.0202026367188 C 217.7614135742188 187.6454925537109 218.7605590820313 188.5291900634766 219.3979034423828 189.5308837890625 C 219.640625 189.9290161132813 219.8426208496094 190.3506011962891 220.0008239746094 190.7892303466797 C 220.170166015625 191.2844696044922 220.2494964599609 191.8060302734375 220.2350921630859 192.3292541503906 C 220.246826171875 192.6329193115234 220.2237091064453 192.9369354248047 220.1661682128906 193.2353363037109 C 219.9428100585938 194.3458251953125 219.3944549560547 195.3374633789063 218.5210876464844 196.2102508544922 C 217.97119140625 196.7594146728516 217.3427734375 197.2238464355469 216.6564025878906 197.5883178710938 L 216.3566436767578 197.7433624267578 L 216.3506317138672 199.6046295166016 L 216.3394317626953 201.4693450927734 L 215.2421264648438 200.8423156738281 C 214.6392211914063 200.497802734375 213.8037872314453 200.019775390625 213.3869018554688 199.7846527099609 C 212.9700317382813 199.5494995117188 212.4308624267578 199.2437591552734 212.1931304931641 199.1042022705078 L 211.7538757324219 198.8509826660156 L 211.1725158691406 198.8320465087891 C 210.0930023193359 198.802978515625 209.0233917236328 198.6178741455078 207.9969024658203 198.2825317382813 L 207.7316131591797 198.1964111328125 L 207.53955078125 198.4315490722656 C 207.0406799316406 199.0413360595703 206.4720764160156 199.5905609130859 205.8453674316406 200.0680236816406 C 205.6817169189453 200.1946105957031 205.5421905517578 200.3031463623047 205.5361633300781 200.3091583251953 C 205.5301208496094 200.3152160644531 206.1046295166016 200.5994262695313 206.4947814941406 200.7570495605469 C 207.8056793212891 201.2833099365234 209.1200256347656 201.5735473632813 210.7272033691406 201.6941375732422 L 211.2689514160156 201.7311706542969 L 215.1336059570313 203.9912414550781 L 218.9982452392578 206.2486877441406 L 219.0137634277344 202.8258972167969 L 219.0292816162109 199.4022369384766 L 219.2463226318359 199.2385864257813 C 220.4952087402344 198.2911529541016 221.4598541259766 197.1421813964844 222.0937652587891 195.8528137207031 C 222.3590240478516 195.3443603515625 222.5614776611328 194.8055572509766 222.6966857910156 194.2482299804688 C 222.8827209472656 193.5092315673828 222.9257659912109 193.1474761962891 222.9257659912109 192.3275146484375 C 222.9257659912109 191.5075531005859 222.8827209472656 191.1466827392578 222.6966857910156 190.4076995849609 C 222.5619964599609 189.8501892089844 222.3595123291016 189.3113098144531 222.0937652587891 188.8030853271484 C 220.9413604736328 186.4612121582031 218.7140350341797 184.6214752197266 215.8596801757813 183.6533660888672 C 214.1423950195313 183.0854034423828 212.3311462402344 182.8563537597656 210.5265197753906 182.9789733886719 Z" fill="#292929" stroke="none" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_7an9rp =
    '<svg viewBox="0.0 122.0 428.0 80.0" ><path transform="translate(-0.47, -2103.98)" d="M 428.2559509277344 2268.9111328125 C 425.5418701171875 2244.8828125 396.8680114746094 2225.97705078125 361.889892578125 2225.97705078125 L 310.6158447265625 2225.97705078125 C 287.8968505859375 2225.97705078125 266.9728698730469 2234.243408203125 254.6600189208984 2247.627197265625 C 244.5020904541016 2258.66796875 234.4138488769531 2271.97705078125 214.2780456542969 2271.97705078125 C 192.0310668945313 2271.97705078125 180.3690032958984 2257.05322265625 170.9559478759766 2244.0361328125 C 162.9088745117188 2232.9072265625 146.4900360107422 2225.97705078125 128.6900024414063 2225.97705078125 L 67.04607391357422 2225.97705078125 C 32.06792449951172 2225.97705078125 3.394073963165283 2244.8828125 0.6799956560134888 2268.9111328125 L 0.4679999649524689 2268.9111328125 L 0.4679999649524689 2272.64501953125 L 0.4679999649524689 2272.64501953125 L 0.4679999649524689 2305.97705078125 L 428.4679260253906 2305.97705078125 L 428.4679260253906 2272.64501953125 L 428.4679260253906 2272.64501953125 L 428.4679260253906 2268.9111328125 L 428.2559509277344 2268.9111328125 Z" fill="#171c26" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_hgrdrv =
    '<svg viewBox="16.9 0.0 15.0 1.0" ><path transform="translate(16.9, 0.0)" d="M 0 0 L 15 0" fill="none" stroke="#ff7847" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_hyjlix =
    '<svg viewBox="0.0 0.5 50.0 59.5" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#33ff7847" stop-opacity="0.2" /><stop offset="1.0" stop-color="#00803c24" stop-opacity="0.0" /></linearGradient></defs><path transform="translate(5.0, 0.5)" d="M -4.999500274658203 59.49990081787109 L 0.0009000000427477062 18.30780029296875 L 11.90070056915283 0 L 26.90010070800781 0 L 39.99663925170898 18.30780029296875 L 40.0004997253418 18.30780029296875 L 45.00090026855469 59.49990081787109 L -4.999500274658203 59.49990081787109 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jhlusc =
    '<svg viewBox="0.0 0.0 30.0 32.1" ><path transform="translate(0.0, 0.0)" d="M 14.02256965637207 32.09531021118164 C 11.73756408691406 32.09531021118164 9.87819766998291 30.24539947509766 9.87819766998291 27.97030639648438 C 9.875397682189941 27.68731307983398 9.791389465332031 27.39455795288086 9.642976760864258 27.14641761779785 C 9.402154922485352 26.72820472717285 9.003119468688965 26.41872215270996 8.548078536987305 26.29743957519531 C 8.4024658203125 26.2584056854248 8.249852180480957 26.23888969421387 8.095837593078613 26.23888969421387 C 7.776609897613525 26.23888969421387 7.464381694793701 26.32253265380859 7.191357612609863 26.47866630554199 C 6.562701225280762 26.82718086242676 5.850037097930908 27.0125904083252 5.131773471832275 27.0125904083252 C 4.752339363098145 27.0125904083252 4.375705242156982 26.96100807189941 4.013072490692139 26.8592414855957 C 2.96437931060791 26.56230926513672 2.055697917938232 25.84576606750488 1.523650288581848 24.89223098754883 L 0.5519632697105408 23.22354888916016 C -0.5849385857582092 21.25932693481445 0.09272215515375137 18.74166488647461 2.061298370361328 17.60829925537109 C 2.618548154830933 17.28766822814941 2.965779066085815 16.68961715698242 2.965779066085815 16.0483512878418 C 2.965779066085815 15.40569305419922 2.618548154830933 14.80764484405518 2.061298370361328 14.48701190948486 C 0.09272215515375137 13.34807014465332 -0.5849385857582092 10.82343864440918 0.5505630970001221 8.860610008239746 L 1.604857444763184 7.136163711547852 C 2.332922697067261 5.87593936920166 3.7036452293396 5.093873977661133 5.183577537536621 5.093873977661133 C 5.903241634368896 5.093873977661133 6.614505767822266 5.282071590423584 7.238961696624756 5.64034366607666 C 7.507785797119141 5.797871589660645 7.797611236572266 5.880121231079102 8.098638534545898 5.882908821105957 C 9.073125839233398 5.882908821105957 9.87819766998291 5.086904525756836 9.893598556518555 4.108277797698975 C 9.887998580932617 3.02230978012085 10.31503677368164 1.992103576660156 11.09490585327148 1.210039019584656 C 11.87757682800293 0.4293687343597412 12.91646957397461 0 14.02256965637207 0 L 15.97154426574707 0 C 17.08324432373047 0 18.16693878173828 0.4544617235660553 18.94400978088379 1.246284484863281 C 19.71967697143555 2.043683528900146 20.1467170715332 3.136622190475464 20.11451721191406 4.242107391357422 C 20.1173152923584 4.497219085693359 20.20272445678711 4.785788059234619 20.34973526000977 5.032536029815674 C 20.59475517272949 5.447963714599609 20.98539161682129 5.744897365570068 21.45023345947266 5.866180419921875 C 21.60004615783691 5.902425765991211 21.75266075134277 5.921942234039307 21.90387535095215 5.921942234039307 C 22.22590255737305 5.921942234039307 22.53953170776367 5.836905479431152 22.81255531311035 5.675195217132568 C 23.4426097869873 5.316923141479492 24.1580753326416 5.127331256866455 24.87914085388184 5.127331256866455 C 26.36187171936035 5.127331256866455 27.73959732055664 5.917760372161865 28.47466278076172 7.189137935638428 L 29.44354820251465 8.860610008239746 C 29.47294998168945 8.912188529968262 29.49255180358887 8.954010009765625 29.50935554504395 8.993043899536133 C 30.00779914855957 9.931241989135742 30.12120819091797 11.01581764221191 29.82718467712402 12.04741668701172 C 29.53315734863281 13.08041095733643 28.86249923706055 13.94611930847168 27.93841552734375 14.48422431945801 C 27.66118812561035 14.64175319671631 27.4329662322998 14.86758804321289 27.27895545959473 15.13664150238037 C 27.0395336151123 15.54928016662598 26.97092819213867 16.0483512878418 27.09133720397949 16.50420761108398 C 27.2159481048584 16.96842956542969 27.51417541503906 17.35597610473633 27.93141174316406 17.59296417236328 C 28.87789726257324 18.13525199890137 29.58216094970703 19.04696464538574 29.86218643188477 20.09668731689453 C 30.14361190795898 21.14501571655273 29.98959732055664 22.28674507141113 29.44074630737305 23.22633934020996 L 28.4074535369873 24.93963050842285 C 27.67378807067871 26.1956729888916 26.30166816711426 26.97634506225586 24.82873725891113 26.97634506225586 C 24.1048698425293 26.97634506225586 23.3922061920166 26.7867546081543 22.76495170593262 26.42569160461426 C 22.50592803955078 26.27652931213379 22.20490074157715 26.19288635253906 21.89687347412109 26.18452262878418 L 21.88847351074219 26.18452262878418 C 21.43903160095215 26.18452262878418 20.97138786315918 26.38108253479004 20.64096069335938 26.70868682861328 C 20.29932975769043 27.04743957519531 20.11311340332031 27.49911499023438 20.11591339111328 27.98006439208984 C 20.10471534729004 30.24958229064941 18.2453441619873 32.09531021118164 15.97154426574707 32.09531021118164 L 14.02256965637207 32.09531021118164 Z M 9.152932167053223 24.05301284790039 C 10.20442676544189 24.33600616455078 11.11730861663818 25.0372142791748 11.65915775299072 25.97541427612305 C 12.01338958740234 26.57206726074219 12.2052059173584 27.25794219970703 12.21220779418945 27.95915031433105 C 12.21220779418945 28.95869064331055 13.02427864074707 29.7728157043457 14.02256965637207 29.7728157043457 L 15.97154426574707 29.7728157043457 C 16.96563148498535 29.7728157043457 17.77770614624023 28.96844863891602 17.78190422058105 27.98006439208984 C 17.77630424499512 26.88294219970703 18.20614242553711 25.8471622467041 18.99161148071289 25.06509590148926 C 19.76028251647949 24.29976081848145 20.79357528686523 23.86063385009766 21.82686614990234 23.86063385009766 C 21.86186981201172 23.86063385009766 21.89687347412109 23.86063385009766 21.93187522888184 23.86202621459961 C 22.63053894042969 23.87875556945801 23.32080078125 24.06834983825684 23.92565536499023 24.40988922119141 C 24.20148086547852 24.5660228729248 24.51370620727539 24.64966773986816 24.82873725891113 24.64966773986816 C 25.47419166564941 24.64966773986816 26.07624816894531 24.30812454223633 26.3996753692627 23.75747299194336 L 27.4329662322998 22.04278755187988 C 27.66679000854492 21.64129829406738 27.72979736328125 21.15059280395508 27.6065845489502 20.69612884521484 C 27.48477363586426 20.23748588562012 27.17954444885254 19.84018135070801 26.76930809020996 19.60876655578613 C 25.80882453918457 19.05672264099121 25.12276268005371 18.16592216491699 24.83713722229004 17.10225868225098 C 24.55571174621582 16.05671691894531 24.70972442626953 14.91637992858887 25.25857353210449 13.9739990234375 C 25.61840629577637 13.35225200653076 26.14065170288086 12.83366394042969 26.76930809020996 12.47399711608887 C 27.6177864074707 11.98050212860107 27.90901184082031 10.88477611541748 27.41896820068359 10.02882671356201 C 27.39936637878418 9.998157501220703 27.38116645812988 9.961912155151367 27.3643627166748 9.922877311706543 L 26.45288276672363 8.348991394042969 C 26.13085174560547 7.792763233184814 25.52879905700684 7.447038173675537 24.88193893432617 7.447038173675537 C 24.56831359863281 7.447038173675537 24.25888442993164 7.529286861419678 23.98445892333984 7.684027194976807 C 23.35720443725586 8.053451538085938 22.6417407989502 8.250012397766113 21.91507339477539 8.250012397766113 C 21.5622444152832 8.250012397766113 21.20941162109375 8.204009056091309 20.86498260498047 8.113395690917969 C 19.79528427124023 7.83737325668335 18.89780426025391 7.162651538848877 18.34055519104004 6.213299751281738 C 17.98212242126465 5.615250110626221 17.78890609741211 4.92658805847168 17.78190422058105 4.221196174621582 C 17.79590606689453 3.70121431350708 17.61388969421387 3.22026538848877 17.2708568572998 2.867569446563721 C 16.93482780456543 2.521844387054443 16.46158599853516 2.323888540267944 15.97154426574707 2.323888540267944 L 14.02256965637207 2.323888540267944 C 13.54232501983643 2.323888540267944 13.08868598937988 2.51069164276123 12.74845409393311 2.848052978515625 C 12.40822410583496 3.18959641456604 12.22340774536133 3.639875650405884 12.2276086807251 4.118036270141602 C 12.19400501251221 6.372221946716309 10.33603858947754 8.206798553466797 8.084636688232422 8.206798553466797 C 7.366373538970947 8.198433876037598 6.66631031036377 8.004658699035645 6.062856674194336 7.644993782043457 C 5.798233032226563 7.49443531036377 5.495805740356445 7.416368961334229 5.187777996063232 7.416368961334229 C 4.538120269775391 7.416368961334229 3.933265686035156 7.762094020843506 3.611236810684204 8.321110725402832 L 2.558342933654785 10.04555511474609 C 2.071099042892456 10.88895797729492 2.37212610244751 11.9791088104248 3.230402708053589 12.47678565979004 C 4.507317066192627 13.21284580230713 5.299788951873779 14.58180809020996 5.299788951873779 16.0483512878418 C 5.299788951873779 17.51629257202148 4.505917072296143 18.88385963439941 3.22760272026062 19.61992073059082 C 2.37212610244751 20.1134147644043 2.078099966049194 21.2077465057373 2.572344303131104 22.05951309204102 L 3.553831577301025 23.74492645263672 C 3.7974534034729 24.18126487731934 4.188088893890381 24.49353408813477 4.652929782867432 24.6231803894043 C 4.812544822692871 24.66779136657715 4.979159355163574 24.69009590148926 5.148574829101563 24.69009590148926 C 5.460802555084229 24.69009590148926 5.766030311584473 24.61202812194824 6.033453941345215 24.46425819396973 C 6.646708965301514 24.10598564147949 7.357972621917725 23.9163932800293 8.091638565063477 23.9163932800293 C 8.452871322631836 23.9163932800293 8.809902191162109 23.96239852905273 9.152932167053223 24.05301284790039 Z M 9.736785888671875 16.0483512878418 C 9.736785888671875 13.15569019317627 12.09879684448242 10.80252647399902 15.00405597686768 10.80252647399902 C 17.90791511535645 10.80252647399902 20.27132797241211 13.15569019317627 20.27132797241211 16.0483512878418 C 20.27132797241211 18.93962097167969 17.90791511535645 21.29138946533203 15.00405597686768 21.29138946533203 C 12.09879684448242 21.29138946533203 9.736785888671875 18.93962097167969 9.736785888671875 16.0483512878418 Z M 12.07079410552979 16.0483512878418 C 12.07079410552979 17.65848541259766 13.38551139831543 18.96889686584473 15.00405597686768 18.96889686584473 C 16.62120246887207 18.96889686584473 17.93871879577637 17.65848541259766 17.93871879577637 16.0483512878418 C 17.93871879577637 14.4368257522583 16.62120246887207 13.12641620635986 15.00405597686768 13.12641620635986 C 13.38551139831543 13.12641620635986 12.07079410552979 14.4368257522583 12.07079410552979 16.0483512878418 Z" fill="#bababa" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_kavnnp =
    '<svg viewBox="0.0 0.0 26.5 32.0" ><path transform="translate(0.0, 0.0)" d="M 0 26.04728698730469 C 0 20.73810958862305 7.565767288208008 20.1250114440918 13.25628471374512 20.1250114440918 C 16.5338306427002 20.1250114440918 26.50955772399902 20.1250114440918 26.50955772399902 26.07917404174805 C 26.50955772399902 31.38545036315918 18.9452953338623 32 13.25628471374512 32 C 9.977232933044434 32 0 32 0 26.04728698730469 Z M 2.510877132415771 26.04728698730469 C 2.510877132415771 28.39532852172852 6.125816822052002 29.58528518676758 13.25628471374512 29.58528518676758 C 20.38373947143555 29.58528518676758 23.99868202209473 28.40547180175781 23.99868202209473 26.07917404174805 C 23.99868202209473 23.73113441467285 20.38373947143555 22.54117393493652 13.25628471374512 22.54117393493652 C 6.125816822052002 22.54117393493652 2.510877132415771 23.72098922729492 2.510877132415771 26.04728698730469 Z M 13.2035665512085 17.10154914855957 C 10.83879566192627 17.09430313110352 8.615606307983398 16.20001792907715 6.945202827453613 14.58248138427734 C 5.274799823760986 12.96494197845459 4.360520839691162 10.82126903533936 4.368052005767822 8.547151565551758 C 4.368052005767822 3.833680629730225 8.355029106140137 0 13.25628471374512 0 C 18.15603637695313 0 22.14150810241699 3.836579322814941 22.14150810241699 8.551498413085938 C 22.14150810241699 13.26642036437988 18.15603637695313 17.10154914855957 13.25628471374512 17.10154914855957 Z M 6.758431434631348 8.551498413085938 C 6.746381759643555 11.98514366149902 9.639840126037598 14.78974437713623 13.20808601379395 14.80278873443604 L 13.25628471374512 15.9536190032959 L 13.25628471374512 14.80278873443604 C 14.991455078125 14.80134105682373 16.62119102478027 14.15055847167969 17.84725952148438 12.96928882598877 C 19.0748291015625 11.78657531738281 19.75112724304199 10.21831703186035 19.75112724304199 8.551498413085938 C 19.75112724304199 5.104810237884521 16.83808708190918 2.300208330154419 13.25628471374512 2.300208330154419 C 9.672974586486816 2.300208330154419 6.758431434631348 5.104810237884521 6.758431434631348 8.551498413085938 Z" fill="#bababa" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_yf4j62 =
    '<svg viewBox="6.1 0.0 10.4 10.4" ><path transform="translate(-101.16, -46.5)" d="M 111.8055801391602 46.5462760925293 C 108.9667663574219 46.92368698120117 106.9696350097656 49.5284538269043 107.3419723510742 52.36794281005859 C 107.7143173217773 55.20743179321289 110.3155212402344 57.2092170715332 113.1556701660156 56.84194183349609 C 115.9958114624023 56.47465896606445 118.0022430419922 53.87702560424805 117.6400299072266 51.03622817993164 C 117.2627792358398 48.17843246459961 114.6444320678711 46.15955352783203 111.8055801391602 46.5462760925293 Z M 112.8942642211914 49.13016510009766 C 113.4372711181641 49.21150588989258 113.9376525878906 49.4715461730957 114.3162689208984 49.86916732788086 C 114.8105545043945 50.34736251831055 115.0896148681641 51.00566482543945 115.0896148681641 51.69339752197266 C 115.0896148681641 52.38113021850586 114.8105316162109 53.0394287109375 114.3162689208984 53.51762771606445 C 113.5740737915039 54.25032043457031 112.4655151367188 54.46789169311523 111.5014343261719 54.07008743286133 C 110.5373382568359 53.67227554321289 109.90478515625 52.73628997802734 109.8952255249023 51.69339752197266 C 109.8933029174805 51.00490570068359 110.1734237670898 50.34566497802734 110.6703872680664 49.86916732788086 C 110.8260650634766 49.70535659790039 111.0027313232422 49.56287002563477 111.1957855224609 49.44540786743164 C 111.7106552124023 49.15305328369141 112.3088760375977 49.04232406616211 112.8942642211914 49.13103866577148 Z" fill="#ff7847" stroke="none" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_uj8mw3 =
    '<svg viewBox="0.0 11.4 22.8 23.3" ><path transform="translate(-35.0, -171.53)" d="M 45.41654205322266 182.9446258544922 C 41.11005401611328 183.2693481445313 37.4391975402832 185.5009918212891 35.83201217651367 188.7739105224609 C 35.56585311889648 189.281982421875 35.36335372924805 189.8209228515625 35.22910690307617 190.3785247802734 C 35.04306411743164 191.1140747070313 35 191.4758148193359 35 192.2949066162109 C 35 193.1139984130859 35.04306411743164 193.4766235351563 35.22910308837891 194.2156066894531 C 35.36348342895508 194.773193359375 35.56597900390625 195.3120880126953 35.83201217651367 195.8201904296875 C 36.48220825195313 197.1263732910156 37.42868804931641 198.2624969482422 38.59592819213867 199.1379241943359 L 38.89306640625 199.3678741455078 L 38.90857315063477 202.7941436767578 L 38.924072265625 206.2169647216797 L 42.78872299194336 203.9594879150391 L 46.65336990356445 201.6994323730469 L 47.17961883544922 201.6624145507813 C 47.7705078125 201.6222991943359 48.35878372192383 201.5501251220703 48.94184494018555 201.4462127685547 C 52.62474822998047 200.7407989501953 55.57986831665039 198.6754150390625 56.981201171875 195.8219299316406 C 57.24649810791016 195.3134918212891 57.44894790649414 194.7746734619141 57.58411407470703 194.2173309326172 C 57.76929092407227 193.4783325195313 57.81235122680664 193.1165924072266 57.81235122680664 192.2966461181641 C 57.81235122680664 191.4766693115234 57.76929092407227 191.1157989501953 57.58411407470703 190.3768005371094 C 57.45391464233398 189.842529296875 57.26289367675781 189.3249664306641 57.01478576660156 188.8342132568359 C 56.78654861450195 188.3579254150391 56.45839691162109 187.8006591796875 56.4118766784668 187.8006591796875 C 56.36537551879883 187.8006591796875 55.65394592285156 188.2089080810547 55.39124298095703 188.3915100097656 C 55.04940414428711 188.6261138916016 54.72499847412109 188.8851928710938 54.42055892944336 189.1666870117188 L 54.20695877075195 189.3578796386719 L 54.3240966796875 189.5404815673828 C 54.64742279052734 190.0747680664063 54.88623809814453 190.6558380126953 55.03208160400391 191.2630615234375 C 55.27324676513672 192.4318542480469 55.12509918212891 193.4860992431641 54.56525802612305 194.5962982177734 C 53.92273330688477 195.8762054443359 52.79356384277344 196.9364318847656 51.26303482055664 197.6969604492188 C 49.90304946899414 198.3748168945313 48.41558837890625 198.7365570068359 46.75241851806641 198.7917022705078 L 46.17103958129883 198.8106231689453 L 45.73177719116211 199.0638732910156 C 45.49406051635742 199.2033996582031 44.95660781860352 199.5091400146484 44.53801727294922 199.7442932128906 C 44.11943054199219 199.9794158935547 43.28569030761719 200.4557189941406 42.68278121948242 200.8019714355469 L 41.58290481567383 201.4350128173828 L 41.57343292236328 199.5711517333984 L 41.56395721435547 197.7098846435547 L 41.39169311523438 197.623779296875 C 40.3161735534668 197.0800933837891 39.38378524780273 196.2908020019531 38.66999053955078 195.3198089599609 C 38.36437225341797 194.8583679199219 38.11539077758789 194.3618621826172 37.92841720581055 193.8409729003906 C 37.49776458740234 192.5179901123047 37.60628890991211 191.2716979980469 38.24967956542969 189.9917907714844 C 39.24189376831055 188.0185546875 41.41236877441406 186.5595092773438 44.17971801757813 186.0057067871094 C 44.97814559936523 185.8455047607422 45.4415283203125 185.8050384521484 46.40617752075195 185.8050384521484 C 47.37083435058594 185.8050384521484 47.8350715637207 185.8455047607422 48.63263702392578 186.0057067871094 C 49.08908462524414 186.0920257568359 49.53870391845703 186.2112121582031 49.97798156738281 186.3623046875 C 50.08388519287109 186.4016571044922 50.19202041625977 186.4347381591797 50.30183029174805 186.4613342285156 C 50.30183029174805 186.4613342285156 50.37331771850586 186.3708953857422 50.45685958862305 186.2692565917969 C 50.96028137207031 185.6591949462891 51.53318786621094 185.1100158691406 52.16395950317383 184.6328125 L 52.52226257324219 184.3640747070313 L 52.13984298706055 184.1814880371094 C 50.12612533569336 183.2202758789063 47.69554138183594 182.7749786376953 45.41654205322266 182.9446258544922 Z" fill="#ff7847" stroke="none" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_8hzc56 =
    '<svg viewBox="20.1 0.0 10.4 10.4" ><path transform="translate(-252.09, -46.63)" d="M 276.9089660644531 46.65397262573242 C 275.6876220703125 46.79866790771484 274.6560668945313 47.27468109130859 273.8143310546875 48.08200454711914 C 273.02880859375 48.8326301574707 272.497802734375 49.81023025512695 272.2958374023438 50.87778091430664 C 272.2036743164063 51.33771133422852 272.19677734375 52.27481079101563 272.2803344726563 52.71062088012695 C 272.3856506347656 53.29347610473633 272.5873413085938 53.85469055175781 272.877197265625 54.37121200561523 C 273.6308288574219 55.71296691894531 274.9393920898438 56.65260696411133 276.4515991210938 56.93788146972656 C 277.0827941894531 57.03693771362305 277.7255859375 57.03693771362305 278.3567810058594 56.93788146972656 C 279.868896484375 56.65281677246094 281.17724609375 55.71308517456055 281.9302978515625 54.37121200561523 C 282.2205200195313 53.8548583984375 282.4223022460938 53.2935791015625 282.5272216796875 52.71062850952148 C 282.6133422851563 52.27481079101563 282.6047058105469 51.33771133422852 282.5116882324219 50.87778091430664 C 282.0810546875 48.73745346069336 280.5057373046875 47.15438842773438 278.3714294433594 46.7245979309082 C 277.8870544433594 46.65707015991211 277.3975830078125 46.63343048095703 276.9089660644531 46.65396499633789 Z M 277.8064575195313 49.26629257202148 C 278.3493041992188 49.34800338745117 278.849609375 49.60798263549805 279.2284545898438 50.00529098510742 C 279.7222900390625 50.48372650146484 280.0010375976563 51.14192962646484 280.0010375976563 51.82951736450195 C 280.0010375976563 52.5171012878418 279.7222900390625 53.17530822753906 279.2284545898438 53.65374755859375 C 278.4859924316406 54.38618850708008 277.3775329589844 54.60359954833984 276.4134216308594 54.20587158203125 C 275.4493408203125 53.80813598632813 274.8165893554688 52.87237930297852 274.8065795898438 51.82951736450195 C 274.8042907714844 51.14096450805664 275.0845031738281 50.48160934448242 275.5816650390625 50.00529098510742 C 275.7373962402344 49.84147644042969 275.9140014648438 49.6989860534668 276.1070861816406 49.58152770996094 C 276.6220703125 49.28868103027344 277.2206420898438 49.17764663696289 277.806396484375 49.26629257202148 Z" fill="#ff7847" stroke="none" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_6ljv0z =
    '<svg viewBox="13.8 11.4 22.8 23.3" ><path transform="translate(-186.28, -171.57)" d="M 210.5265197753906 182.9789733886719 C 208.2234191894531 183.1512145996094 206.0245056152344 183.8885040283203 204.2648773193359 185.082275390625 C 202.77197265625 186.0922698974609 201.6640625 187.3331298828125 200.9411315917969 188.8047943115234 C 200.6761169433594 189.3133697509766 200.4736633300781 189.8521423339844 200.3382263183594 190.4093933105469 C 200.1530456542969 191.1483917236328 200.1099700927734 191.5101470947266 200.1099700927734 192.3292541503906 C 200.0995330810547 192.6910095214844 200.1179809570313 193.0530548095703 200.1651000976563 193.4119110107422 C 200.2559814453125 193.958984375 200.3916625976563 194.4976654052734 200.5707855224609 195.0225219726563 C 200.8237762451172 195.667236328125 201.1411743164063 196.2847595214844 201.5182037353516 196.86572265625 C 201.5431671142578 196.8993072509766 202.0496063232422 196.6211090087891 202.4578704833984 196.3489227294922 C 202.8344116210938 196.0988006591797 203.1893615722656 195.817626953125 203.5189971923828 195.5082855224609 L 203.7446441650391 195.2981567382813 L 203.6128692626953 195.0957336425781 C 203.3799285888672 194.7063446044922 203.1852111816406 194.2953033447266 203.0315093994141 193.8683624267578 C 202.8614501953125 193.3733062744141 202.7817993164063 192.8516540527344 202.7963562011719 192.3283996582031 C 202.7850646972656 192.0246124267578 202.8090362548828 191.7205352783203 202.8678588867188 191.4223022460938 C 203.0883331298828 190.3112030029297 203.6367034912109 189.3201446533203 204.512939453125 188.4490814208984 C 205.8910064697266 187.0709991455078 207.8892211914063 186.1735382080078 210.2018127441406 185.8918914794922 C 210.638427734375 185.8472442626953 211.077392578125 185.8297119140625 211.5161743164063 185.8393707275391 C 212.4808044433594 185.8393707275391 212.9441833496094 185.8798370361328 213.7426300048828 186.0400390625 C 214.7243041992188 186.2231750488281 215.6726989746094 186.5536193847656 216.5556335449219 187.0202026367188 C 217.7614135742188 187.6454925537109 218.7605590820313 188.5291900634766 219.3979034423828 189.5308837890625 C 219.640625 189.9290161132813 219.8426208496094 190.3506011962891 220.0008239746094 190.7892303466797 C 220.170166015625 191.2844696044922 220.2494964599609 191.8060302734375 220.2350921630859 192.3292541503906 C 220.246826171875 192.6329193115234 220.2237091064453 192.9369354248047 220.1661682128906 193.2353363037109 C 219.9428100585938 194.3458251953125 219.3944549560547 195.3374633789063 218.5210876464844 196.2102508544922 C 217.97119140625 196.7594146728516 217.3427734375 197.2238464355469 216.6564025878906 197.5883178710938 L 216.3566436767578 197.7433624267578 L 216.3506317138672 199.6046295166016 L 216.3394317626953 201.4693450927734 L 215.2421264648438 200.8423156738281 C 214.6392211914063 200.497802734375 213.8037872314453 200.019775390625 213.3869018554688 199.7846527099609 C 212.9700317382813 199.5494995117188 212.4308624267578 199.2437591552734 212.1931304931641 199.1042022705078 L 211.7538757324219 198.8509826660156 L 211.1725158691406 198.8320465087891 C 210.0930023193359 198.802978515625 209.0233917236328 198.6178741455078 207.9969024658203 198.2825317382813 L 207.7316131591797 198.1964111328125 L 207.53955078125 198.4315490722656 C 207.0406799316406 199.0413360595703 206.4720764160156 199.5905609130859 205.8453674316406 200.0680236816406 C 205.6817169189453 200.1946105957031 205.5421905517578 200.3031463623047 205.5361633300781 200.3091583251953 C 205.5301208496094 200.3152160644531 206.1046295166016 200.5994262695313 206.4947814941406 200.7570495605469 C 207.8056793212891 201.2833099365234 209.1200256347656 201.5735473632813 210.7272033691406 201.6941375732422 L 211.2689514160156 201.7311706542969 L 215.1336059570313 203.9912414550781 L 218.9982452392578 206.2486877441406 L 219.0137634277344 202.8258972167969 L 219.0292816162109 199.4022369384766 L 219.2463226318359 199.2385864257813 C 220.4952087402344 198.2911529541016 221.4598541259766 197.1421813964844 222.0937652587891 195.8528137207031 C 222.3590240478516 195.3443603515625 222.5614776611328 194.8055572509766 222.6966857910156 194.2482299804688 C 222.8827209472656 193.5092315673828 222.9257659912109 193.1474761962891 222.9257659912109 192.3275146484375 C 222.9257659912109 191.5075531005859 222.8827209472656 191.1466827392578 222.6966857910156 190.4076995849609 C 222.5619964599609 189.8501892089844 222.3595123291016 189.3113098144531 222.0937652587891 188.8030853271484 C 220.9413604736328 186.4612121582031 218.7140350341797 184.6214752197266 215.8596801757813 183.6533660888672 C 214.1423950195313 183.0854034423828 212.3311462402344 182.8563537597656 210.5265197753906 182.9789733886719 Z" fill="#ff7847" stroke="none" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_53raek =
    '<svg viewBox="0.0 0.0 21.5 21.5" ><path transform="translate(0.0, 0.0)" d="M 6.219000339508057 20.50469970703125 C 5.796900272369385 20.33550071716309 5.398200035095215 20.17530059814453 5.113800048828125 20.17530059814453 C 4.785300254821777 20.17710113525391 4.345200061798096 20.32830047607422 3.920400142669678 20.47500038146973 C 3.43530011177063 20.64150047302246 2.886300086975098 20.83049964904785 2.357100009918213 20.83049964904785 C 1.871100068092346 20.83049964904785 1.476899981498718 20.67210006713867 1.151100039482117 20.34810066223145 C 0.3492000102996826 19.5452995300293 0.7190999984741211 18.45899963378906 1.017000079154968 17.58690071105957 C 1.163699984550476 17.15850067138672 1.315800070762634 16.71570014953613 1.315800070762634 16.37730026245117 C 1.315800070762634 16.10009956359863 1.182600021362305 15.74820041656494 0.9783000349998474 15.24240016937256 C -0.9009000062942505 11.18249988555908 -0.0288000013679266 6.321599960327148 3.148200035095215 3.147300004959106 C 5.17680025100708 1.117799997329712 7.875900268554688 0 10.74870014190674 0 C 13.62240028381348 0 16.32240104675293 1.117799997329712 18.34920120239258 3.146399974822998 C 20.37689971923828 5.173200130462646 21.49380111694336 7.873200416564941 21.49380111694336 10.74779987335205 C 21.49380111694336 13.62240028381348 20.37689971923828 16.32240104675293 18.34920120239258 18.35009956359863 C 17.33760070800781 19.36260032653809 16.14960098266602 20.15010070800781 14.81760025024414 20.69280052185059 C 13.51170063018799 21.22470092773438 12.13469982147217 21.49380111694336 10.72440052032471 21.49380111694336 C 9.152999877929688 21.49380111694336 7.637400150299072 21.16080093383789 6.219000339508057 20.50469970703125 Z M 6.814800262451172 19.12770080566406 C 8.052300453186035 19.70009994506836 9.370800018310547 19.99080085754395 10.73430061340332 19.99080085754395 C 11.94930076599121 19.99080085754395 13.13460063934326 19.75860023498535 14.25600051879883 19.30230140686035 C 15.39900016784668 18.83609962463379 16.41959953308105 18.15929985046387 17.28899955749512 17.2898998260498 C 20.89529991149902 13.68179988861084 20.89529991149902 7.812900066375732 17.28899955749512 4.206600189208984 C 15.54390048980713 2.46150016784668 13.22100067138672 1.500300049781799 10.74960041046143 1.500300049781799 C 8.277299880981445 1.500300049781799 5.953500270843506 2.462399959564209 4.208400249481201 4.208400249481201 C 1.475100040435791 6.939000129699707 0.7308000326156616 11.13390064239502 2.355299949645996 14.64840030670166 C 2.581200122833252 15.20730018615723 2.815200090408325 15.78600025177002 2.815200090408325 16.37730026245117 C 2.815200090408325 16.96230125427246 2.614500045776367 17.55089950561523 2.43720006942749 18.07019996643066 L 2.434499979019165 18.07740020751953 C 2.289600133895874 18.50310134887695 2.070899963378906 19.14570045471191 2.212200164794922 19.28700065612793 C 2.241899967193604 19.31760025024414 2.296800136566162 19.33290100097656 2.375100135803223 19.33290100097656 C 2.627099990844727 19.33290100097656 3.078900098800659 19.17720031738281 3.409200191497803 19.06380081176758 L 3.430800199508667 19.05660057067871 L 3.456900119781494 19.04759979248047 C 3.964500188827515 18.87479972839355 4.539599895477295 18.6786003112793 5.108400344848633 18.67500114440918 C 5.688899993896484 18.67500114440918 6.236100196838379 18.89459991455078 6.814800262451172 19.12770080566406 Z M 13.69260025024414 11.16270065307617 C 13.69260025024414 10.61009979248047 14.13540077209473 10.16279983520508 14.68710041046143 10.16279983520508 L 14.69610023498535 10.16279983520508 C 15.24870014190674 10.16279983520508 15.69600009918213 10.61009979248047 15.69600009918213 11.16270065307617 C 15.69600009918213 11.71530055999756 15.24870014190674 12.16260051727295 14.69610023498535 12.16260051727295 C 14.14440059661865 12.16260051727295 13.69260025024414 11.71530055999756 13.69260025024414 11.16270065307617 Z M 9.683100700378418 11.16270065307617 C 9.683100700378418 10.61009979248047 10.12590026855469 10.16279983520508 10.67850017547607 10.16279983520508 L 10.6875 10.16279983520508 C 11.23920059204102 10.16279983520508 11.68739986419678 10.61009979248047 11.68739986419678 11.16270065307617 C 11.68739986419678 11.71530055999756 11.23920059204102 12.16260051727295 10.6875 12.16260051727295 C 10.1358003616333 12.16260051727295 9.683100700378418 11.71530055999756 9.683100700378418 11.16270065307617 Z M 5.674499988555908 11.16270065307617 C 5.674499988555908 10.61009979248047 6.117300033569336 10.16279983520508 6.669000148773193 10.16279983520508 L 6.677999973297119 10.16279983520508 C 7.230600357055664 10.16279983520508 7.677900314331055 10.61009979248047 7.677900314331055 11.16270065307617 C 7.677900314331055 11.71530055999756 7.230600357055664 12.16260051727295 6.677999973297119 12.16260051727295 C 6.12630033493042 12.16260051727295 5.674499988555908 11.71530055999756 5.674499988555908 11.16270065307617 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_hgxv9o =
    '<svg viewBox="0.0 0.0 20.5 20.5" ><path transform="translate(0.0, 0.0)" d="M 15.58979511260986 20.50020599365234 L 15.58978462219238 20.50020599365234 L 15.56189441680908 20.50020599365234 C 13.06920528411865 20.50020599365234 9.819825172424316 18.515625 5.90400505065918 14.60159587860107 C 1.971104860305786 10.66959571838379 -0.0152951693162322 7.410225868225098 -5.169677933736239e-06 4.914005756378174 C 0.009014829993247986 3.262595653533936 0.8733648061752319 2.419735670089722 1.198754787445068 2.102435827255249 C 1.212614774703979 2.084945678710938 1.254254817962646 2.043805837631226 1.2791348695755 2.019225835800171 L 1.294204831123352 2.004305839538574 C 2.716124773025513 0.580585777759552 3.682904720306396 -0.0001442507928004488 4.631155014038086 -0.0001442507928004488 L 4.657505035400391 -4.250793608662207e-06 C 5.774244785308838 0.01530574914067984 6.568844795227051 0.8511357307434082 7.574844837188721 1.909335732460022 C 7.826774597167969 2.175865650177002 8.097635269165039 2.460905790328979 8.395195007324219 2.757595777511597 C 9.855104446411133 4.21751594543457 9.439364433288574 5.407615661621094 9.105304718017578 6.363885879516602 C 8.740884780883789 7.406745910644531 8.426175117492676 8.307375907897949 10.31220436096191 10.1934061050415 C 11.33851528167725 11.21824550628662 12.14321517944336 11.67526531219482 12.92136478424072 11.67526531219482 C 13.35170459747314 11.67526531219482 13.7341251373291 11.54038619995117 14.13900470733643 11.39759540557861 C 14.57268524169922 11.24581527709961 15.06423473358154 11.07379531860352 15.60205459594727 11.07379531860352 C 16.34968566894531 11.07379531860352 17.05103492736816 11.41110610961914 17.74619483947754 12.10499572753906 C 18.04587554931641 12.40467548370361 18.33086395263672 12.67578601837158 18.58230400085449 12.91499614715576 C 19.64582443237305 13.92634582519531 20.48580551147461 14.72512531280518 20.50019454956055 15.84539604187012 C 20.51187515258789 16.79937553405762 19.9324951171875 17.77300643920898 18.50039482116699 19.20599555969238 L 17.86589431762695 18.77580642700195 L 18.40230560302734 19.30049514770508 C 18.08221435546875 19.62876510620117 17.23758506774902 20.4912166595459 15.58979511260986 20.50020599365234 Z M 2.357394933700562 3.063105821609497 C 2.348464727401733 3.073775768280029 2.302604913711548 3.121585845947266 2.248194932937622 3.175205707550049 C 2.00690484046936 3.409325838088989 1.504814863204956 3.896475791931152 1.500304818153381 4.92210578918457 C 1.492194771766663 6.353565692901611 2.433544874191284 9.010746002197266 6.964194774627686 13.54049587249756 C 11.47824478149414 18.0527458190918 14.13072490692139 18.9998950958252 15.56100463867188 18.9998950958252 L 15.58169460296631 18.9998950958252 C 16.60004425048828 18.99541664123535 17.09038543701172 18.49569511413574 17.32603454589844 18.25554656982422 C 17.39748573303223 18.18230628967285 17.45618438720703 18.12660598754883 17.5004940032959 18.09000587463379 C 18.50130462646484 17.08285522460938 19.00610542297363 16.3339958190918 19.00080490112305 15.86429595947266 C 18.9945240020752 15.3777961730957 18.39068412780762 14.80310535430908 17.55493545532227 14.00771617889404 L 17.54819488525391 14.00131607055664 C 17.27755546569824 13.74432563781738 16.98797416687012 13.4680757522583 16.68510437011719 13.16520595550537 C 16.26450538635254 12.74555587768555 15.9478645324707 12.57438564300537 15.59219455718994 12.57438564300537 C 15.31339454650879 12.57438564300537 15.01397514343262 12.67982578277588 14.63489437103271 12.81330585479736 C 14.1449146270752 12.98485565185547 13.5897045135498 13.1792459487915 12.92256450653076 13.17930603027344 C 11.74809455871582 13.17940616607666 10.54744529724121 12.54949569702148 9.251995086669922 11.25359535217285 C 6.699224948883057 8.701725959777832 7.271114826202393 7.064935684204102 7.688694953918457 5.869795799255371 C 7.990864753723145 5.006485939025879 8.128774642944336 4.61245584487915 7.334994792938232 3.817805767059326 C 7.05058479309082 3.534205675125122 6.797894954681396 3.269015789031982 6.553534984588623 3.012545824050903 L 6.488094806671143 2.943905830383301 L 6.481684684753418 2.9371657371521 C 5.692044734954834 2.107175827026367 5.121524810791016 1.507485747337341 4.637704849243164 1.500305771827698 L 4.630494594573975 1.500305771827698 C 4.152744770050049 1.500305771827698 3.409704923629761 2.010785818099976 2.358904838562012 3.06091570854187 C 2.357424736022949 3.061365842819214 2.355304718017578 3.064185857772827 2.354404926300049 3.065395832061768 L 2.357394933700562 3.063105821609497 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_yw24h1 =
    '<svg viewBox="0.0 0.0 19.5 19.5" ><path transform="translate(0.0, 0.0)" d="M 12.8952054977417 19.49940490722656 C 12.19607543945313 19.49940490722656 11.55681610107422 19.13973426818848 11.18519592285156 18.53730392456055 L 7.307995796203613 12.24630451202393 L 0.9521957635879517 8.271904945373535 C 0.2665457725524902 7.842124938964844 -0.09072422236204147 7.077224731445313 0.01979577913880348 6.275704860687256 C 0.1293457746505737 5.474734783172607 0.6794058084487915 4.835364818572998 1.455305814743042 4.607104778289795 L 16.91099548339844 0.08190476894378662 C 17.09625625610352 0.02750477008521557 17.28765487670898 -8.523010183125734e-05 17.47986602783203 -8.523010183125734e-05 C 18.01762580871582 -8.523010183125734e-05 18.52484512329102 0.2102647721767426 18.90810585021973 0.592204749584198 C 19.4324951171875 1.120214819908142 19.62665557861328 1.890974760055542 19.4148063659668 2.603704690933228 L 14.84189605712891 18.04770469665527 C 14.61333560943604 18.82428550720215 13.97328567504883 19.37330436706543 13.17149543762207 19.48050498962402 C 13.06835556030273 19.49340438842773 12.98056602478027 19.49940490722656 12.8952054977417 19.49940490722656 Z M 13.58328533172607 5.172964572906494 C 13.78205585479736 5.172964572906494 13.96950531005859 5.249754905700684 14.1110954284668 5.389204978942871 C 14.25381565093994 5.530194759368896 14.33292579650879 5.718394756317139 14.33384609222412 5.919144630432129 C 14.33477592468262 6.119704723358154 14.2575855255127 6.308344841003418 14.11649608612061 6.450304985046387 L 8.804696083068848 11.81790447235107 L 12.46229553222656 17.75070571899414 C 12.58776569366455 17.95556449890137 12.76871585845947 17.99858474731445 12.89841556549072 17.99859428405762 C 12.92340564727783 17.99859428405762 12.94836616516113 17.99694442749023 12.97260570526123 17.99370384216309 C 13.09812545776367 17.97592544555664 13.32117557525635 17.90412521362305 13.40459537506104 17.62290382385254 L 17.97749519348145 2.177104711532593 C 18.05790519714355 1.903364777565002 17.91177558898926 1.718974828720093 17.84520530700684 1.65240478515625 C 17.81016540527344 1.616374731063843 17.68041610717773 1.49887478351593 17.48175621032715 1.49887478351593 C 17.4329948425293 1.49887478351593 17.38297653198242 1.506014823913574 17.33309555053711 1.520104765892029 L 1.876495838165283 6.046204566955566 C 1.585365772247314 6.132194995880127 1.520195722579956 6.377594947814941 1.505695819854736 6.479104995727539 C 1.492305755615234 6.581774711608887 1.488995790481567 6.838114738464355 1.746895790100098 7.000204563140869 L 7.748095989227295 10.75320434570313 L 13.05000591278076 5.395504951477051 C 13.19176578521729 5.251994609832764 13.3811559677124 5.172964572906494 13.58328533172607 5.172964572906494 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
