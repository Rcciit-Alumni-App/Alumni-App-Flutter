import 'package:flutter/material.dart';
import 'package:frontend/components/background_add_details_page.dart';
import 'package:frontend/components/button.dart';
import 'package:frontend/components/button2.dart';
import 'package:frontend/components/button4.dart';
import 'package:frontend/components/edu_history.dart';
import 'package:frontend/components/socials.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/higher_studies_model.dart';

class RegisterStudentDomain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterStudentDomainState();
  }
}

class _RegisterStudentDomainState extends State<RegisterStudentDomain> {
  
  List<Socials> domainList = List.empty(growable: true);
  List<Socials> socialsList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    onAddDomain();
    onAddSocials();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackgroundAddDetailsPage(),
      Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton2(
                  label: "Skip",
                  onPressed: () {},
                ),
                SizedBox(
                  width: 25.0,
                ),
                CustomButton4(
                  label: "Next",
                  onPressed: () {
                    onSave();
                  },
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Registered as Student",
                  style: kRegisterHeading,
                ),
                Text(
                  "Please set your profile",
                  style: kRegisterSubHeading,
                ),
                SizedBox(
                  height: 100.0,
                ),
                
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          // Higher Studies List
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(), // Disable scrolling
                            itemCount: domainList.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: domainList[index],
                              );
                            },
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomButton2(
                              height: 35,
                              width: 100,
                              label: "Add more",
                              onPressed: () {
                                onAddDomain();
                              },
                            ),
                          ),
                          // Socials List
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(), // Disable scrolling
                            itemCount: socialsList.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: socialsList[index],
                              );
                            },
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomButton2(
                              height: 35,
                              width: 100,
                              label: "Add more",
                              onPressed: () {
                                onAddSocials();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          )),
    ]);
  }

  onSave() {

    // --------------------------------------- HANDLE VALIDATION HERE---------------------------------------------

    // List<Map?> data = higherStudiesForms
    //     .map((e) => {
    //           'name': e.contactModel.name,
    //           'startDate': e.contactModel.startDate,
    //         })
    //     .toList();

    // print(data);


    // print(domainList);
    // print(socialsList);

  }


  onAddDomain() {
    // setState(() {
    //   HigherStudiesModel _higherStudiesModel = HigherStudiesModel(id: higherStudiesForms.length);
    //   higherStudiesForms.add(HigherStudiesFormWidget(
    //     index: higherStudiesForms.length,
    //     contactModel: _higherStudiesModel,
    //     onRemove: () => onRemove(_higherStudiesModel),
    //   ));
    // });


      setState(() {
      domainList.add(
        Socials(
          label: 'Domain of Interest',
          hintText: 'Domain',  
        )
      );
    });


  }

  onAddSocials() {
    setState(() {
      socialsList.add(
        Socials(
          label: 'Social',
          hintText: 'Link',  
        )
      );
    });
  }
}
