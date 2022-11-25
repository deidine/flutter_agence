import 'package:flutter/material.dart';
import '../Pages/Fourniseurs.dart';
import '../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            //margin: const EdgeInsets.only(bottom: kDefaultPadding * 1.6),
            height: size.height * 0.25,
            child: Stack(
              children: <Widget>[
                Container(

                  padding: const EdgeInsets.only(
                    left: 20 + kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: kDefaultPadding,
                    top: 20 + kDefaultPadding,
                  ),
                  height: size.height * 0.22 - 38,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(1),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Accueil',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold,
                        fontSize: 40),
                      ),
                      const Spacer(),
                      //Image.asset("images/logo.png"),
                      const Icon(Icons.home,size: 50, color: Colors.white,),


                    ],
                  ),
                ),
                /*
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
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
                */
              ],
            ),
          ),
          //TitleWithMoreBtn(title: "Recomended", press: () {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              children: const<Widget>[
                 TitleWithCustomUnderline(text: "Categories",),
                Spacer(),

              ],
            ),
          ),
          const SizedBox(height: 17,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    RecomendPlantCard(
                      image: "assets/images/p.jpg",
                      title: "Plombies",
                      press:() {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                           return const Fourniseurs(cat: '1', Title: 'Plombies');
                       }));
                        },
                    ),
                    RecomendPlantCard(
                      image: 'assets/images/m.jpg',
                      title: "Menuisers",
                      press: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return const Fourniseurs(cat: '4', Title: 'Menuisers');
                        }));
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    RecomendPlantCard(
                      image: "assets/images/e.jpg",
                      title: "Electriciens",
                      press:() {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return const Fourniseurs(cat: '2', Title: 'Electriciens');
                        }));
                      },
                    ),
                    RecomendPlantCard(
                      image: 'assets/images/pai.jpg',
                      title: "Peindres",
                      press: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return const Fourniseurs(cat: '3', Title: 'Peindres');
                        }));
                      },
                    ),
                  ],
                ),

              ],
            ),
          ),

          //TitleWithMoreBtn(title: "Featured Plants", press: () {}),

          //FeaturedPlants(),
          const SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(right: kDefaultPadding / 4),
              height: 7,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    Key? key,
    required this.image,
    required this.title,
      this.press,
  }) : super(key: key);

  final String image, title;

   final press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2.2,
        bottom: kDefaultPadding * 0,
      ),
      width: size.width * 0.4,
      child: InkWell(
        onTap: press,
        child: Column(
          children: <Widget>[
            Container(color: Colors.white,
                child: Image.asset(image, width: 180, height: 150,fit: BoxFit.contain,)),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
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
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "$title\n".toUpperCase(),
                              style: Theme.of(context).textTheme.button),

                        ],
                      ),
                    ),
                    const Spacer(),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
