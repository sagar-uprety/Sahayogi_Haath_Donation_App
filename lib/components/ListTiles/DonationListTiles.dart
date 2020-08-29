import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../theme/text_styles.dart';
import '../../theme/light_color.dart';
import '../../theme/extention.dart';
import '../../routes.dart';

class DonationListTiles extends StatefulWidget {
  final List listprovider;
  final int itemCount;
  final double heightPercent;
  DonationListTiles({
    this.listprovider,
    this.itemCount,
    this.heightPercent,
  });
  @override
  _DonationListTilesState createState() => _DonationListTilesState();
}

class _DonationListTilesState extends State<DonationListTiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.fullHeight(context) *
          widget.heightPercent, //check this. is it perfect?
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: widget.itemCount,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                    widget.listprovider[index].title,
                    style: TextStyles.title.bold,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.listprovider[index].description,
                        style: TextStyles.bodySm.subTitleColor.bold,
                      ),
                      Text(
                        "08/21/2020 (3)",
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
                      arguments: widget.listprovider[index]);
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
