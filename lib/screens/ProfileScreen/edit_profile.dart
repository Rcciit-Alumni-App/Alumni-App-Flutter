import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button2.dart';
import 'package:frontend/components/Buttons/button3.dart';
import 'package:frontend/components/Buttons/button4.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/components/edu_history.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/components/Socials/socials.dart';
import 'package:frontend/components/work_exp.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:uuid/uuid.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
    
  final _formKey = GlobalKey<FormState>();
  
  late TabController tabController;

  // Account Tab
  int nextAvailableIdSocial = 0;
  List<Socials?> socialsList = List.empty(growable: true);
  String? full_name, phone_number, year_of_passout;

  // Work Experience Tab
  int nextAvailableIdWork = 0;
  List<WorkExperienceFormWidget> workExperienceForms = List.empty(growable: true);

  // Higher Studies Tab
  int nextAvailableIdStudy = 0;
  List<HigherStudiesFormWidget> higherStudiesForms = List.empty(growable: true);


  @override
  void initState() {
    super.initState();
    onAddSocials(); // Add one such social link
    onAddWorkExperience(); // Add one work experience by default
    onAddHigherStudies() ;// Add one higher study by default
    tabController = TabController(length: 3, vsync: this);
  }


  onAddSocials() {
    setState(() {
      SocialLink _socialLink = SocialLink(id: nextAvailableIdSocial);
      nextAvailableIdSocial++;
      
      socialsList.add(
        Socials(
          socialLinkModel: _socialLink,
          label: 'Social',
          hintText: 'Link',
          onRemove: () => onRemoveSocials(_socialLink),
        )
      );
    });
  }


  onRemoveSocials(SocialLink socialLink) {
    int notNullElements = 0;

    for (Socials? element in socialsList) {
      if (element != null) {
        notNullElements++;
      }
    }

    if (notNullElements == 1) {
      return null;
    }

    setState(() {
      int index = socialsList
          .indexWhere((element) {
            if (element != null) 
              return element.socialLinkModel.id == socialLink.id;
            return false;
          });

      // if (socialsList != null) socialsList.removeAt(index);
      if (socialsList != null) socialsList[index] = null;
    });
  }


  //Delete specific form
  onRemoveWorkExperience(WorkExperience workExperience) {
    if (workExperienceForms.length == 1) {
      return null;
    }

    setState(() {
      int index = workExperienceForms
          .indexWhere((element) => element.workExperience.id == workExperience.id);

      if (workExperienceForms != null) workExperienceForms.removeAt(index);
    });
  }

  onAddWorkExperience() {
    setState(() {
      WorkExperience _workExperience = WorkExperience(id: nextAvailableIdWork);
      nextAvailableIdWork++;

      workExperienceForms.add(WorkExperienceFormWidget(
        index: workExperienceForms.length,
        workExperience: _workExperience,
        onRemove: () => onRemoveWorkExperience(_workExperience),
      ));
    });
  }


  //Delete specific form
  onRemoveHigherStudies(HigherStudy higherStudiesModel) {
    if (higherStudiesForms.length == 1) {
      return null;
    }

    setState(() {
      int index = higherStudiesForms
          .indexWhere((element) => element.higherStudiesModel.id == higherStudiesModel.id);

      if (higherStudiesForms != null) higherStudiesForms.removeAt(index);
    });
  }

  onAddHigherStudies() {
    setState(() {
      HigherStudy _higherStudiesModel = HigherStudy(id: nextAvailableIdStudy);
      nextAvailableIdStudy++;

      higherStudiesForms.add(HigherStudiesFormWidget(
        index: higherStudiesForms.length,
        higherStudiesModel: _higherStudiesModel,
        onRemove: () => onRemoveHigherStudies(_higherStudiesModel),
      ));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundAddDetailsPage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 110, left: 10, right: 10),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage("assets/default-user.jpg"),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TabBar(
                    controller: tabController,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Work Experience',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Higher Studies',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                    labelColor: Theme.of(context).colorScheme.primary,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        width: 1.11053,
                        color: Color(0xFF2F80ED),
                      ),
                    ), // Sets the bottom line color to blue
                    labelStyle: TextStyle(fontSize: 14.0),
                    unselectedLabelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(color: Theme.of(context).colorScheme.primary,),
                ),
                
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [    
                      _buildAccountForm(),
                      _buildWorkExperienceForms(),
                      _buildHigherStudiesForms(),
                    ]
                  ),
                ),
            
                SizedBox(
                  height: 15.0,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                //   child: Divider(
                //     color: Theme.of(context).colorScheme.primary,
            
                //   ),
                // )
              ],
            ),
          ),
          bottomNavigationBar: Bottomnavbar(),
        ),
      ],
    );
  }

  Widget _buildAccountForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Form(
            child: Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: MyTextField(
                      enabled: true,
                      label: "Full Name",
                      onSaved: (value) {
                        setState(() {
                          full_name = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: MyTextField(
                      enabled: false,
                      label: "Personal Email",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: MyTextField(
                      enabled: false,
                      label: "College Email",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: MyTextField(
                      enabled: true,
                      label: "Phone Number",
                      onSaved: (value) {
                        setState(() {
                            phone_number = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: MyTextField(
                      enabled: false,
                      label: "University Roll",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: MyTextField(
                      enabled: false,
                      label: "College Roll",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: MyTextField(
                      enabled: true,
                      label: "Year of Passout",
                      onSaved: (value) {
                        setState(() {
                            year_of_passout = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: MyTextField(
                      enabled: false,
                      label: "Department",
                    ),
                  ),
              
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // Disable scrolling
                    itemCount: socialsList.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: socialsList[index],
                      );
                    },
                  ),
              
                  SizedBox(height: 15),
              
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
              
                  SizedBox(
                    height: 30.0,
                  ),
                
                ],
              ),
            )
          ),
          SizedBox(
            height: 15.0,
          ),
          Align(
            alignment: Alignment.center,
            child: CustomButton3(
              label: "Save",
              onPressed: () {
                if(_formKey.currentState?.validate() ?? false){
                  _formKey.currentState?.save();
                  // updateProfile(full_name!, phone_number!, university_roll!);
                  // // Navigator.pushNamed(context, "/register2");
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWorkExperienceForms() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
            itemCount: workExperienceForms.length,
            itemBuilder: (_, index) {
              return workExperienceForms[index];
            })
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton3(
                label: "Save",
                onPressed: () {
                  // updateProfile();
                },
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
              CustomButton2(
                height: 35,
                label: "Add more",
                onPressed: () {
                  onAddWorkExperience();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHigherStudiesForms() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Disable scrolling
              itemCount: higherStudiesForms.length,
              itemBuilder: (_, index) {
                return higherStudiesForms[index];
              },
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton3(
                label: "Save",
                onPressed: () {
                  // updateProfile();
                },
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
              CustomButton2(
                height: 35,
                label: "Add more",
                onPressed: () {
                  onAddHigherStudies();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
