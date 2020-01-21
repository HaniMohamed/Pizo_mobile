import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pizo/models/profile.dart';
import 'package:pizo/resources/apis/profile_api.dart';
import 'package:pizo/resources/constants.dart';
import 'package:pizo/resources/sharedprefs.dart';
import 'package:pizo/ui/widgets/app_header.dart';

Constants cons = new Constants();

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePage();
  }
}

class _ProfilePage extends State<ProfilePage> {
  Profile profile;
  List<String> titles = [
    "My Profile",
  ];
  String _name = "Doctor's full name";
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final mailController = TextEditingController();

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  getData() {
    SharedPrefs().getSharedToken().then((token) {
      ProfileAPI().getProfileData(token).then((prof) {
        setState(() {
          profile = prof;

          if (profile.getName() != null) {
            nameController.text = profile.getName().toString();
            _name = profile.getName().toString();
          }
          if (profile.getPhone() != null)
            phoneController.text = profile.getPhone().toString();
          if (profile.getEmail() != null)
            mailController.text = profile.getEmail().toString();
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade200,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AppHeader(titles),
                Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.indigo.withAlpha(240),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 110,
                          height: 110,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 100.0,
                                height: 100.0,
                                child: CachedNetworkImage(
                                  imageUrl: profile != null
                                      ? profile.getPicsUploaded() == 1
                                          ? profile.getImg()
                                          : "https://previews.123rf.com/images/cowpland/cowpland1706/cowpland170600027/80179639-doctor-vector-icon.jpg"
                                      : "https://previews.123rf.com/images/cowpland/cowpland1706/cowpland170600027/80179639-doctor-vector-icon.jpg",
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: new Border.all(
                                          color: Colors.white, width: 1),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: FloatingActionButton(
                                    backgroundColor: Colors.blue,
                                    mini: true,
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            _name,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Basic Info",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Expanded(
                        child: new Container(
                          margin: EdgeInsets.all(5),
                          height: 1.0,
                          color: Colors.grey.withAlpha(50),
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                ),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      children: <Widget>[
                        cusTextField(
                            nameController,
                            "your name",
                            "Name",
                            TextInputType.text,
                            Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            false),
                        cusTextField(
                            mailController,
                            "example@example.com",
                            "Email",
                            TextInputType.emailAddress,
                            Icon(
                              Icons.mail,
                              color: Colors.grey,
                            ),
                            false),
                        cusTextField(
                            phoneController,
                            "01xxxxxxxxx",
                            "Phone",
                            TextInputType.phone,
                            Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                            false),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned.fill(
              bottom: 15,
              right: 15,
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    SharedPrefs().getSharedToken().then((token) {
                      ProfileAPI()
                          .updateData(token, mailController.text,
                              nameController.text, phoneController.text)
                          .then((error) {
                        if (error == "0") {
                          getData();
                        }
                      });
                    });
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget cusTextField(TextEditingController controller, String hint,
      String label, TextInputType type, Icon myIcon, bool secure) {
    return TextField(
      controller: controller,
      keyboardType: type,
      obscureText: secure,
      decoration: new InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        labelText: label,
        prefixIcon: myIcon,
        prefixStyle: TextStyle(color: Colors.blue, fontSize: 12),
        labelStyle: TextStyle(color: Colors.blue, fontSize: 12),
        hintStyle: TextStyle(color: Colors.blue, fontSize: 12),
        suffixStyle: const TextStyle(color: Colors.blue, fontSize: 12),
      ),
    );
  }
}
