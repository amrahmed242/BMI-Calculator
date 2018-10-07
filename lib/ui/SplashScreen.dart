import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Home.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return new SplashScreenState();
  }
}


class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;

  @override
  void initState(){
    super.initState();
    
    animController=AnimationController(
      duration: Duration(milliseconds: 1400),
      vsync: this 
    );

    animation = Tween(begin: 0.0,end: 0.97).animate(animController)
    ..addListener(() {setState(() {});});

    animController.forward();
  }

    @override
    void dispose(){
      super.dispose();
      animController.dispose();
    }





  @override
  Widget build(BuildContext context) {

//////////vars//////////
 
  final background = Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/backgroundd.jpg"),
            fit: BoxFit.cover)),
  );

  final greenOpacity = Container(color: Color(0xAA69F0CF),);

  final logo =FadeTransition(
      opacity: animation,
      child: new ScaleTransition(
      scale: animation,
      child: new Image.asset("assets/images/logo2.png", width: 105.5, height: 105.5)),
  );

  final desception= new FadeTransition(
      opacity: animation,
      child: new SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, -0.8),end: Offset.zero).animate(animController),
        child: Text(
        "BMI Calculator hepls you know your body weight condetion.",
        style:textStyle.copyWith(fontSize: 22.0), 
          textAlign: TextAlign.center,),
    ),
  );

  final separetor = FadeTransition(
    opacity: animation,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(width: 20.0,height: 1.7,color: Colors.white),
        Padding(padding: EdgeInsets.symmetric(horizontal: 7.0),
        child: Text("Copyright © 2018 fitness corp,  All rights reserved", style: textStyle,)),
      ],
    ),
  );

/////////////////////////////


    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          background,
          greenOpacity,
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top:70.2),),
                  Opacity(child: logo,opacity: .95,),
                  Padding(padding: EdgeInsets.only(top:50.2),),
                  desception,
                  Padding(padding: EdgeInsets.only(top:210.2),),
                  button("lets start !", () {Navigator.pushReplacement(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new Home()));}),
                  Padding(padding: EdgeInsets.only(top:70.2),),
                  separetor,

                ],
              ),
            ),
          )
        ],
      ),
    );
  }


Widget button(String label,Function onTap){

    return FadeTransition(
      opacity: animation,
          child: SlideTransition(
        position: Tween<Offset>(begin: Offset(0.0, -0.6),end: Offset.zero).animate(animController),
            child: new Material(
          color: Color(0xBB00D699),
          borderRadius: BorderRadius.circular(30.0),
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.white24,
            highlightColor: Colors.white10,
            child: Container(
              padding: EdgeInsets.symmetric(vertical:12.0 ),
              child: Center(child: new Text(label,style: textStyle.copyWith(fontSize: 18.0),)),
            ),
          ),
        ),
      ),
    );
  
  }

}


const TextStyle textStyle=TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.italic
    ,fontFamily: 'BebasNeue');