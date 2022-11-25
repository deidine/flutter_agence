import 'package:flutter/material.dart';



class HomePage1 extends StatelessWidget {
  const HomePage1({Key? key}) : super(key: key);
  static const String routeName = '/users';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(// height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(height: 300,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0,top: 2),
                child: Container(
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: const DecorationImage(image: AssetImage("images/p5.JPG"),
                      fit: BoxFit.cover,
                    ),
                  ),

                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.clear_rounded,size: 50,color: Theme.of(context).accentColor,),
                      const Icon(Icons.favorite,size: 50,color: Colors.white,),
                      Icon(Icons.watch_later,size: 50,color: Theme.of(context).primaryColor,),

                    ],
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

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final bool hasGradient = false;
  final Color color;
  final IconData icon;

  const ChoiceButton({
    Key? key,
    required this.width,
    required this.height,
    required this.size,
    required hasGradient,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Icon(icon,size: size,color: color, )
    );
  }
}
