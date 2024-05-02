import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medosedo_vendor/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/model/body/notification.dart';
import '../../../provider/splash_provider.dart';
import '../../../utill/notification_dialog.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false)
        .getAllNotification(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
        ),
        body: Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
          return profileProvider.allNotifications.isEmpty
              ? Center(child: Text('ليس لديك اي اشعارات'))
              : ListView.builder(
                  padding: EdgeInsets.only(top: 8),
                  itemCount: profileProvider.allNotifications.length,
                  itemBuilder: (context, index) {
                    NotificationModel noti =
                        profileProvider.allNotifications[index];
                    return InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) =>
                              NotificationDialog(notificationModel: noti)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Material(
                          elevation: 5,
                          child: Container(
                              // padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(8),
                              height: MediaQuery.of(context).size.width / 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Image.network(
                                        '${Provider.of<SplashProvider>(context).configModel!.baseUrls!.notificationImageUrl}/${noti.image}',
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                6, errorBuilder:
                                            (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/image/bell.png',
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                6,
                                      );
                                    }),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              noti.title ?? '',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                            DateFormat.yMMMMEEEEd()
                                                .format(noti.createdAt!),
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ]),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    );
                  });
        }));
  }
}
