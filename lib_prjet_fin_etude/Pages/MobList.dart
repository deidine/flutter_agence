import 'package:awn_stage2/Pages/profile_page.dart';
import 'package:awn_stage2/domain/request.dart';
import 'package:flutter/material.dart';

import '../Pages1/contactus1.dart';
import '../constants.dart';
import 'mobDetails.dart';


class MobList extends StatelessWidget {

  final id;
  final username;
  final tel;
  final password;
  final id_cat;
  final img;
  final des;
  final cat_name;
  final lastname;

    const MobList(
       {Key? key, this.id,
      this.username,
      this.tel,
      this.password,
      this.id_cat,
      this.lastname,
      this.cat_name,
      this.img,
      this.des}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        Container(color: kPrimaryColor,
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: Container(
            alignment: Alignment.center,
            margin:
            const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            padding:
            const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: kPrimaryColor.withOpacity(0.5),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,

                      // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                    ),
                  ),
                ),
                //SvgPicture.asset("assets/icons/search.svg"),
                const Icon(
                  Icons.search,
                  size: 25,
                )
              ],
            ),
          ),
        ),
        Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 55,
                                  width: 55,
                                  child: CircleAvatar(
                                    radius: null,
                                    child: ClipRRect(child: Image.network(urlBaseImg+img,
                                      height: 76,
                                      width: 76,
                                      fit: BoxFit.cover,
                                    ),
                                      borderRadius: BorderRadius.circular(100.0),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      username +' ' + lastname,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10,),
                                    Text('  '+
                                        'vcv',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                    return ProfilePage(cat_name_D: cat_name,id_D: id.toString(), des_D: des, id_cat_D: id_cat.toString(), img_D: img, password_D: password, tel_D: tel.toString(), lastname_D: lastname, username_D: username);

                                  }));
                                },
                                color: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Text(
                                  "Invite",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
      ],
    );
  }
}
