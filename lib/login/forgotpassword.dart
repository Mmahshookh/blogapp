import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Forgott extends StatefulWidget {
  const Forgott({Key? key}) : super(key: key);

  @override
  State<Forgott> createState() => _ForgottState();
}

class _ForgottState extends State<Forgott> {
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Image1.jpg"), fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(left: 35, top: 100),
                child: Text("Forgott Password",
                  style: TextStyle(color: Colors.white, fontSize: 33),
                )
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4,
                  right: 35,left: 35),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _emailTextController,
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
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Forgott Password", style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.cyan,
                          child: IconButton(
                            onPressed: () {},
                            color: Colors.white,
                              icon: InkWell(onTap: (){
                                FirebaseAuth.instance.sendPasswordResetEmail(
                                    email: _emailTextController.text).then((value) => Navigator.of(context).pop());
                              },child: Icon(Icons.arrow_forward)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "login");
                            },
                            child: Text("Back To Sign In", style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Colors.cyan,
                            ),)
                        ),
                      ],
                    )
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
