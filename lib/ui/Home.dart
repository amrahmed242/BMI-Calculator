import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return new HomeState();
  }
}


class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  
  final TextEditingController _hightController=new TextEditingController();
  final TextEditingController _weightController=new TextEditingController();
  int _weightRadioValue=0;
  int _hightRadioValue=0;
  double weightmultiplier=1.0;
  double hightmultiplier=0.01;
  int bmiResult=0;
  String info="";
  Color stateColor=Colors.white;

  AnimationController animController;
  Animation<double> animation;
    
  @override
  void initState(){
    super.initState();
    
    animController=AnimationController(
      duration: Duration(milliseconds: 1000),
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

  final formula= new FadeTransition(
      opacity: animation,
      child: new SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, -0.8),end: Offset.zero).animate(animController),
        child: new Container(
              child: new Column(
                children: <Widget>[

                  new TextField(
                    keyboardType: TextInputType.number,
                    style: textStyle.copyWith(fontSize: 16.0,fontStyle: FontStyle.normal),
                    controller: _weightController ,
                    cursorColor: Colors.white,
                    decoration: new InputDecoration(
                      labelText: "Weight",
                      labelStyle: textStyle.copyWith(fontSize: 19.0,fontStyle: FontStyle.normal),
                      hintText: "Enter your weight",
                      hintStyle: new TextStyle(color: Colors.white70),
                      icon: new Icon(Icons.accessibility_new,color: Colors.white),
                    ),
                  ),
                  new Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                        value: 0,
                        groupValue: _weightRadioValue,
                        onChanged: handleWeightRadioValueChange,
                        ),
                        new Text("KG",style: new TextStyle(fontSize: 17.0),),
                        new Radio(
                        value: 1,
                        groupValue: _weightRadioValue,
                        onChanged: handleWeightRadioValueChange,
                        ),
                        new Text("POUNDS",style: new TextStyle(fontSize: 17.0),),
                        
                    ]
                  ),
                                    
                  new TextField(
                    keyboardType: TextInputType.number,
                    style: textStyle.copyWith(fontSize: 16.0,fontStyle: FontStyle.normal),
                    controller: _hightController ,
                    cursorColor: Colors.white,
                    decoration: new InputDecoration(
                      labelText: "Hight",
                      labelStyle: textStyle.copyWith(fontSize: 19.0,fontStyle: FontStyle.normal),
                      hintText: "Enter your hight",
                      hintStyle: new TextStyle(color: Colors.white70),
                      icon: new Icon(Icons.line_weight,color: Colors.white,),
                    ),
                  ),
                  new Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio<int>(
                        value: 0,
                        groupValue: _hightRadioValue,
                        onChanged: handleHightRadioValueChange
                        ),
                        new Text("CM",style: new TextStyle(fontSize: 17.0),),
                        new Radio<int>(
                        value: 1,
                        groupValue: _hightRadioValue,
                        onChanged: handleHightRadioValueChange
                        ),
                        new Text("meters",style: new TextStyle(fontSize: 17.0),),
                        
                    ]
                  ),

              ]
            )
    ),
  )
  );

  final result = new Text(bmiResult==0? '$info' : '$info'+' $bmiResult',textAlign: TextAlign.center,
   style: textStyle.copyWith(fontSize: 20.0,fontStyle: FontStyle.italic),);

  final analysis = new Text(bmiResult >=10 ? state(bmiResult) : "" ,textAlign: TextAlign.center,
   style: textStyle.copyWith(fontSize: 22.0,fontStyle: FontStyle.italic,color: stateColor,fontWeight: FontWeight.w100),);

  final sperator = FadeTransition(
    opacity: animation,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(width: 20.0,height: 1.7,color: Colors.white),
        Padding(padding: EdgeInsets.symmetric(horizontal: 7.0),
        child: Text("Copyright © 2018 fitness corp,  All rights reserved", style: textStyle.copyWith(fontSize: 12.5),)),
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
          ListView(
             children: <Widget>[
               SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top:70.2),),
                    Opacity(child: logo,opacity: .95,),
                    Padding(padding: EdgeInsets.only(top:50.2),),
                    formula,
                    Padding(padding: EdgeInsets.only(top:50.2),),
                    button("CALCULATE", calculateBMI),
                    Padding(padding: EdgeInsets.only(top:40.2),),
                    result,
                    analysis,
                    Padding(padding: EdgeInsets.only(top:25.2),),
                    sperator

                  ],
                ),
              ),
            ),
             ]
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

  handleWeightRadioValueChange(int value){

setState(() {  
      _weightRadioValue=value;
       
      switch (value) {
      
        case 0:
         weightmultiplier=1.0;
          break;
       
        case 1:
        weightmultiplier=0.45;
         break;
      }

    });
  }

  handleHightRadioValueChange(int value){

setState(() {  
      _hightRadioValue=value;
      
      switch (value) {
      
        case 0:
         hightmultiplier=0.01;
          break;
       
        case 1:
        hightmultiplier=1.0;        
          break;
      }
    });
  }
  
  calculateBMI(){
    double weight=0.0;
    double hight=0.0;
     
      setState(() { 

        if(_weightController.text.isNotEmpty && double.parse(_weightController.text) > 0.0 && _hightController.text.isNotEmpty &&  double.parse(_hightController.text) > 0.0){
          weight=double.parse(_weightController.text);
          hight=double.parse(_hightController.text);
          double weightF=weight*weightmultiplier;
          double hightF=hight*hightmultiplier;
          if((weightF/(hightF*hightF))>=10 && (weightF/(hightF*hightF))<=100){
            info="your current BMI ratio is";
            bmiResult=(weightF/(hightF*hightF)).round();
            }else{
              bmiResult=0;
              info="please enter correct values";
              }
      
      } else {
        info="please enter correct values";
      }

      });

  }

  String state(int bmi){
     
    if( bmi < 18.5 ) { stateColor=Colors.red; return "( Underweight )"; }
    else if( bmi >= 18.5 && bmi <= 24.99 ) { stateColor=Colors.green.shade400; return "( Healty Weight )"; }
    else if( bmi >= 25 && bmi <= 29.99 ) { stateColor=Colors.yellow; return "( Overweight )"; }
    else if( bmi >= 30 ) { stateColor=Colors.red; return "( Obese )"; }
    
  }

}

const TextStyle textStyle=TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.italic
    ,fontFamily: 'BebasNeue');