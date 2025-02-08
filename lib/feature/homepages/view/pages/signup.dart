import 'package:flutter/material.dart';
import 'package:task/feature/homepages/view/pages/login.dart';
import 'package:task/feature/homepages/view/widgets/bottombar.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true; 
  
 
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
   
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

 
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                 Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/a simple white color tick image with a purple background.png"),fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(20)
                  ),
                 )
                ],
              ),
              SizedBox(height: 20,),
              Center(child: Text("Let's get started!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email Address",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    validator: emailValidator,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    validator: passwordValidator,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                     border: const OutlineInputBorder(),
                      hintText: 'Enter your password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => CustomNavBar()));
                    print('Form is valid');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 106, 81, 206),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(child: Text("or signup with")),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
               
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color.fromARGB(255, 24, 107, 175),
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.facebook,color: Colors.white,),)),
                    SizedBox(width: 10,),
                   CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.red,
                    child: IconButton(onPressed: () { }, icon:Icon(Icons.g_mobiledata_rounded,color: Colors.white,))),
                       SizedBox(width: 10,),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.apple,color: Colors.white,))),
                 
                ],
              ),
              SizedBox(height: 100,),
              Row(
mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    "Already have an account?",),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()),);
                      
                    }, child:Text("Log in",style: TextStyle(color: Color.fromARGB(255, 106, 81, 206)),))
                ],
              )
            ],
          ),
          
          
        ),
      ),
    );
  }
}