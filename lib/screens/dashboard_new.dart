// import 'package:flutter/material.dart';
// import 'dart:math';
// import '../theme/extention.dart';
// import '../theme/light_color.dart';
// import '../theme/text_styles.dart';
// import '../theme/theme.dart';

// class ActivitiesList extends StatefulWidget {
//   static const id = "activities_list";
//   @override
//   _ActivitiesListState createState() => _ActivitiesListState();
// }

// class _ActivitiesListState extends State<ActivitiesList> {
//   //appbar
//   Widget _appBar() {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Theme.of(context).backgroundColor,
//       leading: Icon(
//         Icons.short_text,
//         size: 30,
//         color: Colors.black,
//       ),
//       actions: <Widget>[
//         ClipRRect(
//           borderRadius: BorderRadius.all(
//             Radius.circular(13),
//           ),
//           child: Container(
//             // height: 40,
//             // width: 40,
//             decoration: BoxDecoration(
//               color: Theme.of(context).backgroundColor,
//             ),
//             child: Image.asset("assets/children.png", fit: BoxFit.fill),
//           ),
//         ).p(8),
//       ],
//     );
//   }

//   Widget _header() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text("Hello,", style: TextStyles.title.subTitleColor),
//         Text("Peter Parker", style: TextStyles.h1Style),
//       ],
//     ).p16;
//   }

//   Widget _searchField() {
//     return Container(
//       height: 55,
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(13)),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             color: LightColor.grey.withOpacity(.3),
//             blurRadius: 15,
//             offset: Offset(5, 5),
//           )
//         ],
//       ),
//       child: TextField(
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           border: InputBorder.none,
//           hintText: "Search",
//           hintStyle: TextStyles.body.subTitleColor,
//           suffixIcon: SizedBox(
//               width: 50,
//               child: Icon(Icons.search, color: LightColor.purple)
//                   .alignCenter
//                   .ripple(() {}, borderRadius: BorderRadius.circular(13))),
//         ),
//       ),
//     );
//   }

//   Widget _category() {
//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("Category", style: TextStyles.title.bold),
//               Text(
//                 "See All",
//                 style: TextStyles.titleNormal
//                     .copyWith(color: Theme.of(context).primaryColor),
//               ).p(8).ripple(() {})
//             ],
//           ),
//         ),
//         SizedBox(
//           height: AppTheme.fullHeight(context) * .28,
//           width: AppTheme.fullWidth(context),
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: <Widget>[
//               _categoryCard("Chemist & Drugist", "350 + Stores",
//                   color: LightColor.green, lightColor: LightColor.lightGreen),
//               _categoryCard("Covid - 19 Specilist", "899 Doctors",
//                   color: LightColor.skyBlue, lightColor: LightColor.lightBlue),
//               _categoryCard("Cardiologists Specilist", "500 + Doctors",
//                   color: LightColor.orange, lightColor: LightColor.lightOrange)
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _categoryCard(String title, String subtitle,
//       {Color color, Color lightColor}) {
//     TextStyle titleStyle = TextStyles.title.bold.white;
//     TextStyle subtitleStyle = TextStyles.body.bold.white;
//     if (AppTheme.fullWidth(context) < 392) {
//       titleStyle = TextStyles.body.bold.white;
//       subtitleStyle = TextStyles.bodySm.bold.white;
//     }
//     return AspectRatio(
//       aspectRatio: 6 / 8,
//       child: Container(
//         height: 280,
//         width: AppTheme.fullWidth(context) * .3,
//         margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//               offset: Offset(4, 4),
//               blurRadius: 10,
//               color: lightColor.withOpacity(.8),
//             )
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           child: Container(
//             child: Stack(
//               children: <Widget>[
//                 Positioned(
//                   top: -20,
//                   left: -20,
//                   child: CircleAvatar(
//                     backgroundColor: lightColor,
//                     radius: 60,
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Flexible(
//                       child: Text(title, style: titleStyle).hP8,
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Flexible(
//                       child: Text(
//                         subtitle,
//                         style: subtitleStyle,
//                       ).hP8,
//                     ),
//                   ],
//                 ).p16
//               ],
//             ),
//           ),
//         ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
//       ),
//     );
//   }

//   Widget _doctorsList() {
//     return SliverList(
//       delegate: SliverChildListDelegate(
//         [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("Top Doctors", style: TextStyles.title.bold),
//               IconButton(
//                   icon: Icon(
//                     Icons.sort,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   onPressed: () {})
//               // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
//             ],
//           ).hP16,
//           getdoctorWidgetList()
//         ],
//       ),
//     );
//   }

//   Widget getdoctorWidgetList() {
//     return Column(
//         children: doctorDataList.map((x) {
//       return _doctorTile(x);
//     }).toList());
//   }

//   Widget _doctorTile(DoctorModel model) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             offset: Offset(4, 4),
//             blurRadius: 10,
//             color: LightColor.grey.withOpacity(.2),
//           ),
//           BoxShadow(
//             offset: Offset(-3, 0),
//             blurRadius: 15,
//             color: LightColor.grey.withOpacity(.1),
//           )
//         ],
//       ),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//         child: ListTile(
//           contentPadding: EdgeInsets.all(0),
//           leading: ClipRRect(
//             borderRadius: BorderRadius.all(Radius.circular(13)),
//             child: Container(
//               height: 55,
//               width: 55,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: randomColor(),
//               ),
//               child: Image.asset(
//                 model.image,
//                 height: 50,
//                 width: 50,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           title: Text(model.name, style: TextStyles.title.bold),
//           subtitle: Text(
//             model.type,
//             style: TextStyles.bodySm.subTitleColor.bold,
//           ),
//           trailing: Icon(
//             Icons.keyboard_arrow_right,
//             size: 30,
//             color: Theme.of(context).primaryColor,
//           ),
//         ),
//       ).ripple(() {
//         Navigator.pushNamed(context, "/DetailPage", arguments: model);
//       }, borderRadius: BorderRadius.all(Radius.circular(20))),
//     );
//   }

//   Color randomColor() {
//     var random = Random();
//     final colorList = [
//       Theme.of(context).primaryColor,
//       LightColor.orange,
//       LightColor.green,
//       LightColor.grey,
//       LightColor.lightOrange,
//       LightColor.skyBlue,
//       LightColor.titleTextColor,
//       Colors.red,
//       Colors.brown,
//       LightColor.purpleExtraLight,
//       LightColor.skyBlue,
//     ];
//     var color = colorList[random.nextInt(colorList.length)];
//     return color;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appBar(),
//       backgroundColor: Theme.of(context).backgroundColor,
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 _header(),
//                 _searchField(),
//                 _category(),
//               ],
//             ),
//           ),
//           _doctorsList()
//         ],
//       ),
//     );
//   }
// }

//  Container(
//               decoration: cGreyBoxDecoration,
//               padding: EdgeInsets.symmetric(horizontal: size.width*0.035, vertical: size.height*0.02),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   OverviewDetail(info: 'Rs. 1500.0', title: 'Total Donation'),
//                   OverviewDetail(info: '3', title: 'Organization'),
//                   Padding(
//                     padding: EdgeInsets.only(right: size.width*0.028),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Color(0xffffffff), width: 4, style: BorderStyle.solid),
//                         borderRadius: BorderRadius.all(Radius.circular(size.width*0.116)),
//                       ),
//                       child: CircleAvatar(
//                         backgroundColor: Colors.blue,
//                         backgroundImage: NetworkImage(user['profile_image']),
//                         radius: size.width*0.093
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
