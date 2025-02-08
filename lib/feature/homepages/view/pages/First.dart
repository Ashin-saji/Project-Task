import 'dart:async';


import 'package:flutter/material.dart';
import 'package:task/feature/homepages/view/pages/signup.dart';


class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds:50),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>Signup(),));
    });

  }

  Widget build(BuildContext context) { 
     return Scaffold(
      body: Column(
        children: [
            Column(
                children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 200,top: 100),
                      child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/a simple white color tick image with a purple background.png")),
                              borderRadius: BorderRadius.circular(20)
                          ),
                      ), 
                    ),SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(right: 200),
                      child: Text("Get things done!",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    ),SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 200),
                      child: Text("Just a click away from\n planning your tasks...."),
                    ),
                Padding(
                  padding: const EdgeInsets.only(top: 300,left: 380),
                  child: CircleAvatar(
                    radius: 60,
                      backgroundColor: const Color.fromARGB(255, 106, 81, 206),
                    child: IconButton(onPressed: () {
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>Signup(),));
                    }, icon: Icon(Icons.arrow_forward_outlined,size: 30,color: Colors.white,)),
                  ),
                ),
                   
                ],
            ),
            
        ],
      )
      
    

    );
  }
}