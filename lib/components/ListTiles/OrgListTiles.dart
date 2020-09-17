import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../../theme/text_styles.dart';
import '../../theme/light_color.dart';
import '../../theme/extention.dart';
import '../../routes.dart';

class OrgListTiles extends StatelessWidget {
  final List listprovider;
  final int itemCount;
  final double heightPercent;
  final double hm;
  OrgListTiles({
    this.listprovider,
    this.itemCount,
    this.heightPercent,
    this.hm = 16,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.lightTheme.backgroundColor,
      height: AppTheme.fullHeight(context) *
          heightPercent, //check this. is it perfect?
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: hm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 10,
                    color: LightColor.grey.withOpacity(.2),
                  ),
                  BoxShadow(
                    offset: Offset(-3, 0),
                    blurRadius: 15,
                    color: LightColor.grey.withOpacity(.1),
                  )
                ],
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: ListTile(
                  isThreeLine: true,
                  contentPadding: EdgeInsets.all(0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Container(
                      height: 55,
                      width: 55,
                      //org image
                      child: Image.asset('assets/images1/ben.jpg',
                          fit: BoxFit.fill),
                    ),
                  ),
                  title: Text(
                    listprovider[index].name,
                    style: TextStyles.title.bold,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listprovider[index].address,
                        style: TextStyles.bodySm.subTitleColor.bold,
                      ),
                      Text(
                        listprovider[index].type,
                        style: TextStyles.bodySm.subTitleColor,
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ).ripple(
                () {
                  Navigator.pushNamed(context, Routes.activity_info,
                      arguments: listprovider[index]);
                },
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            );
          }),
    );
  }
}
