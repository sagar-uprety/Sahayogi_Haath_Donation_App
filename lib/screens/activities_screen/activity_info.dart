import 'package:flutter/material.dart';
import '../../theme/extention.dart';
import '../../theme/light_color.dart';
import '../../theme/text_styles.dart';
import '../../theme/theme.dart';

import '../../components/RoundedButton.dart';

class ActivityInfo extends StatefulWidget {
  static const id = "activity_info";

  @override
  _ActivityInfoState createState() => _ActivityInfoState();
}

class _ActivityInfoState extends State<ActivityInfo> {
  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(color: Theme.of(context).primaryColor),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Container(
              height: AppTheme.fullHeight(context) * 0.42,
              child: Image.asset(
                'assets/images1/children.jpg',
                fit: BoxFit.fill,
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: AppTheme.fullHeight(context) * .5,
                  padding: EdgeInsets.only(
                      left: 19,
                      right: 19,
                      top: 16), //symmetric(horizontal: 19, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Demo Activity", //name //avoid overflow problem
                                style: titleStyle,
                              ),
                              IconButton(
                                  icon: Icon(
                                    // model.isfavourite ? Icons.favorite : Icons.favorite_border, //ambigious
                                    Icons.favorite,
                                    // color: model.isfavourite ? Colors.red : LightColor.grey,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    // setState(() {
                                    //   model.isfavourite = !model.isfavourite;
                                    // });
                                  })
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Org Name",
                                style: TextStyles.bodySm.subTitleColor.bold,
                              ),
                              Text(
                                "Published On: 08/20/2020",
                                style: TextStyles.bodySm.subTitleColor.bold,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Text(
                          "Lorem IpsumLorem ipsum dolor sit amet, lobortis tristique", //test this for multiline and paragraph
                          textAlign: TextAlign.justify,
                          style: TextStyles.body,
                          maxLines: 100,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
                bottom: 10,
                left: AppTheme.fullWidth(context) * .08,
                right: AppTheme.fullWidth(context) * .08,
                child: RoundButton(
                  text: "Donate",
                  onPress: () {},
                )),
            _appbar(),
          ],
        ),
      ),
    );
  }
}
