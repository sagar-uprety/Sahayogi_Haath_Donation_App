import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}
class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }
   Widget getBody(){
    return SafeArea(child: SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
      child: Column(
        children: <Widget>[
           SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Text("Photos",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
            // SvgPicture.asset("assets/images/forward_icon.svg")
          ],),
          SizedBox(height: 30,),
          Column(
            children: <Widget>[
                Row(
                children: <Widget>[
                  Container(
                  width: (MediaQuery.of(context).size.width - 80) / 2,
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: AssetImage("assets/images1/children.jpg"),fit: BoxFit.cover)
                  ),
                ),
                 SizedBox(width: 20,),
                  Container(
                  width: (MediaQuery.of(context).size.width - 80) / 2,
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: AssetImage("assets/images1/children.jpg"),fit: BoxFit.cover)
                  ),
                ),
                ],
                ),
                SizedBox(height: 20,),
                  Row(
                children: <Widget>[
                Container(
                width: (MediaQuery.of(context).size.width - 80) / 2,
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: AssetImage("assets/images1/janko.jpg"),fit: BoxFit.cover)
                  ),
                ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: <Widget>[
                  Container(
                  width: (MediaQuery.of(context).size.width - 80) / 2,
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: AssetImage("assets/images1/jelleke.jpg"),fit: BoxFit.cover)
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                                   width: (MediaQuery.of(context).size.width - 80) / 2,
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: AssetImage("assets/images1/pham.jpg"),fit: BoxFit.cover)
                  ),
                ),
                ],
              ),
            ],
          )
        ],
      ),
       
      ),
    ),
    );
   }
}
   