import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatefulWidget {
  PhotoDetailScreen({Key key}) : super(key: key);

  @override
  PhotoDetailScreenState createState() => PhotoDetailScreenState();
}

class PhotoDetailScreenState extends State<PhotoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images1/children.jpg'),
                fit: BoxFit.cover),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(.4),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Food Donation to childrens",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
