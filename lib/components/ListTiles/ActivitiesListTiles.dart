import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahayogihaath/constants.dart';
import 'package:sahayogihaath/timeline.dart';

import '../../models/activitymodel.dart';
import '../../theme/theme.dart';
import '../../theme/text_styles.dart';
import '../../theme/light_color.dart';
import '../../theme/extention.dart';
import '../../routes.dart';

class ActivitiesListTiles extends StatelessWidget {
  final List<Activity> listprovider;
  final int itemCount;
  final double heightPercent;
  final String activityID;
  final String description;

  ActivitiesListTiles({
    this.listprovider,
    this.itemCount,
    this.heightPercent,
    this.activityID,
    this.description,
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
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          itemBuilder: (context, index) {
            DateTime date = listprovider[index].time.toDate();
            String timeline = Timeline.setDate(date);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeline,
                  style: kTransactionCardBoxText,
                ),
                SizedBox(
                  height: AppTheme.fullHeight(context) * 0.007,
                ),
                Container(
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
                          child: Image.network(listprovider[index].image,
                              fit: BoxFit.fill),
                        ),
                      ),
                      title: Text(
                        listprovider[index].title,
                        style: TextStyles.title.bold,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listprovider[index].description.length > 25
                                ? listprovider[index].authorName
                                : listprovider[index].description,
                            style: TextStyles.bodySm.subTitleColor.bold,
                          ),
                          Text(
                            DateFormat('dd MMM yyyy')
                                .format(listprovider[index].time.toDate()),
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
                ),
                SizedBox(
                  height: AppTheme.fullHeight(context) * 0.02,
                ),
              ],
            );
          }),
    );
  }
}
