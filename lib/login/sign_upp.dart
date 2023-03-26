







import 'package:blogui/login/sign_inn.dart';
import 'package:blogui/login/sign_upp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {



  TextEditingController _password = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _confirmpassword =TextEditingController();


  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();



  bool passwordVisible=false;
  bool passwordVisible1=false;


  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(left: 35,top: 70),
                child: Text("Create An\nAccount",
                  style: TextStyle(color: Colors.white,fontSize: 28),
                )
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height*0.2,
                right: 35,left: 35,),
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                      ),
                      TextFormField(
                        controller: _userNameTextController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan)
                            ),

                            fillColor: Colors.transparent,
                            filled: true,
                            labelText: 'First Name',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: "Enter Your First Name",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        validator: (String? value) {
                          if(value.toString().isEmpty)
                          {
                            return "Please enter a First Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan)
                            ),

                            fillColor: Colors.transparent,
                            filled: true,
                            labelText: 'Second Name',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: "Enter Your Second Name",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        validator: (String? value) {
                          if(value.toString().isEmpty)
                          {
                            return "Please enter a Second Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(

                        controller: _emailTextController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan)
                            ),


                            fillColor: Colors.transparent,
                            filled: true,
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: "Enter Your Email",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        validator: (String? value) {
                          if(value.toString().isEmpty)
                          {
                            return "Please enter Email";
                          }
                          if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!))
                          {
                            return "Please enter a valid Email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _passwordTextController,
                        keyboardType: TextInputType.text,
                        obscureText: passwordVisible,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          fillColor: Colors.transparent,
                          filled: true,
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "Enter Your Password",
                          suffixIcon: IconButton(
                            color: Colors.white,
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                    () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                          ),
                          alignLabelWithHint: false,
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (String? value) {
                          if(value.toString().isEmpty)
                          {
                            return "Please enter password";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _confirmpassword,
                        obscureText: passwordVisible1,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          fillColor: Colors.transparent,
                          filled: true,
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "Confirm Your Password",
                          suffixIcon: IconButton(
                            color: Colors.white,
                            icon: Icon(passwordVisible1
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                    () {
                                  passwordVisible1 = !passwordVisible1;
                                },
                              );
                            },
                          ),
                          alignLabelWithHint: false,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,

                        validator: (String? value) {
                          if(value.toString().isEmpty)
                          {
                            return "Please enter confirm password";
                          }
                          if(_passwordTextController.text != _confirmpassword.text)
                          {
                            return "Password do not match";
                          }
                          return null;
                        },

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sign Up",style: TextStyle(
                              color:Colors.white,
                              fontSize: 25,fontWeight: FontWeight.w700),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: IconButton(
                                color: Colors.white,
                                onPressed: (){
                                  if(_formkey.currentState!.validate())
                                  {
                                    return;
                                  }
                                  else
                                  {
                                    print("Unsuccessfull");
                                  }
                                },
                                icon: InkWell(
                                    onTap: ()  async {
                                      try {
                                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                            email:_emailTextController.text,
                                            password:_passwordTextController.text
                                        ).then((value){
                                          print("Created New Account");
                                          FirebaseFirestore.instance.collection('users').add(
                                              {
                                                'username':_userNameTextController.text,
                                                'email':_emailTextController.text,
                                                "password":_passwordTextController.text,
                                                'createdTime':DateTime.now(),
                                                'about':'about',
                                                'profile': "https://cdn.dribbble.com/users/5534/screenshots/14230133/profile_4x.jpg"
                                              }).then((value) => value.update({
                                            'id':value.id
                                          }));
                                          Navigator.push(context,MaterialPageRoute(builder: (context) => Sign_in()));
                                          return value;
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          print('The password provided is too weak.');
                                          const snackBar = SnackBar(
                                            content: Text('The password provided is too weak'),
                                          );

                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                        } else if (e.code == 'email-already-in-use') {
                                          print('The account already exists for that email.');


                                          const snackBar = SnackBar(
                                            content: Text('The account already exists'),
                                          );

                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);



                                        }
                                      } catch (e) {
                                        print(e);
                                      }

                                    },
                                    child: Icon(Icons.arrow_forward))
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15,left: 42),
                            child: Text("Don't have an account ?",style: TextStyle(
                                color: Colors.white,fontWeight: FontWeight.w100
                            ),),                         ),
                          Padding(
                            padding:  EdgeInsets.only(top: 15,left: 5),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_in()));
                              },
                              child: Text("Sign Up",style: TextStyle(
                                  color: Colors.white,fontWeight: FontWeight.w900
                              ),),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
