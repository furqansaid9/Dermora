// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/primary_questions/models/concerns.dart';
import 'package:frontenddermora/screens/primary_questions/components/reusableButton.dart';
import 'package:frontenddermora/screens/quiz/intro.dart';
import 'package:frontenddermora/services/api_service.dart';
import 'package:frontenddermora/util/styles.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class SkinConcerns extends StatefulWidget {
  const SkinConcerns({Key? key}) : super(key: key);

  @override
  State<SkinConcerns> createState() => _SkinConcernsState();
}

List<StaggeredTile> _staggeredTiles = <StaggeredTile>[
  StaggeredTile.count(
    4,
    1,
  ),
  StaggeredTile.count(
    4,
    1,
  ),
  StaggeredTile.count(
    3,
    1.1,
  ),
  StaggeredTile.count(
    5,
    1,
  ),
  StaggeredTile.count(
    4,
    1.2,
  ),
  StaggeredTile.count(
    3,
    1,
  ),
  StaggeredTile.count(
    8,
    1,
  ),
  StaggeredTile.count(
    4,
    1,
  ),
  StaggeredTile.count(
    4,
    1,
  ),
  StaggeredTile.count(
    4,
    1.1,
  ),
  StaggeredTile.count(
    3,
    1.2,
  ),
  StaggeredTile.count(
    3,
    1,
  ),
  StaggeredTile.count(
    5,
    1,
  ),
  StaggeredTile.count(
    7,
    1,
  ),
];

class _SkinConcernsState extends State<SkinConcerns> {
  List<Widget> _tiles = <Widget>[];
  List<Concern> concerns = <Concern>[];
  List<Concern> chosenConcerns = <Concern>[];

  @override
  void initState() {
    super.initState();
    concerns.add(Concern("Acne & Blemishes", false));
    concerns.add(Concern("Uneven Texture", false));
    concerns.add(Concern("Dark Circles", false));
    concerns.add(Concern("Anti-Aging", false));
    concerns.add(Concern("Fine Lines & Wrinkles", false));
    concerns.add(Concern("Black Heads", false));
    concerns.add(Concern("Dark Spots", false));
    concerns.add(Concern("Dullness", false));
    concerns.add(Concern("Dryness", false));
    concerns.add(Concern("Loss of  Firmness", false));
    concerns.add(Concern("Visible Pores", false));
    concerns.add(Concern("Puffiness", false));
    concerns.add(Concern("Oiliness", false));
    concerns.add(Concern("Redness", false));
    for (int i = 0; i < concerns.length; i++) {
      _tiles.add(ReuseableButton(concerns[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kSecBlue),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(screenWidth * 0.05, 0, screenWidth * 0.05, 0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 70, 0, 50),
                  child: Text(
                    "What are your skin concerns ?",
                    style: GoogleFonts.poppins(textStyle: normalStyle),
                  ),
                ),
              ),
              Expanded(
                child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    crossAxisCount: 8,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 1.0,
                    itemCount: _tiles.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: kSecBlue,
                        onTap: () {
                          print(concerns[index].name);
                          print(concerns[index].isSelected);

                          setState(() {
                            if (concerns[index].isSelected) {
                              concerns[index].isSelected = false;
                            } else {
                              concerns[index].isSelected = true;
                            }
                            _tiles[index] = ReuseableButton(concerns[index]);
                          });
                          print(concerns[index].isSelected);
                        },
                        child: _tiles[index],
                      );
                    },
                    staggeredTileBuilder: (index) => _staggeredTiles[index]),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          Color(0xFF9DCEFF),
                          Color(0XFF92A3FD),
                        ],
                      ),
                      color: Colors.deepPurple.shade300,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99.0),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(Size(315, 60)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        // elevation: MaterialStateProperty.all(3),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () async {
                        for (var concern in concerns) {
                          if (concern.isSelected) {
                            setState(() {
                              chosenConcerns.add(concern);
                            });
                          }
                        }
                        var response =
                            await APIService.updateConcerns(chosenConcerns);
                        if (response) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainQuiz()),
                          );
                        } else {
                          AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            title: Text("Something went wrong"),
                            titleTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                            actionsOverflowButtonSpacing: 20,
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Close"),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(kSecBlue)),
                              ),
                            ],
                            content: Text("Please Try Again"),
                          );
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
