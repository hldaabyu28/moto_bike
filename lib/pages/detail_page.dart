import 'package:d_session/d_session.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rent_motor/common/info.dart';
import 'package:rent_motor/controllers/detail_controller.dart';
import 'package:rent_motor/models/account.dart';
import 'package:rent_motor/models/bike.dart';
import 'package:rent_motor/models/chat.dart';
import 'package:rent_motor/sources/chat_source.dart';
import 'package:rent_motor/widgets/button_primary.dart';
import 'package:rent_motor/widgets/failed_ui.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.bikeId});
  final String bikeId;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final detailcontroller = Get.put(DetailController());

  late final Account account;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      detailcontroller.fetchBike(widget.bikeId);
    });
    DSession.getUser().then((value) {
      account = Account.fromJson(Map.from(value!));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          buildHeader(),
          const Gap(30),
          Obx(() {
            String status = detailcontroller.status;
            if (status == '') return const SizedBox();
            if (status == 'loading') {
              return const Center(child: CircularProgressIndicator());
            }
            if (status != 'success') {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: FailedUI(message: status),
              );
            }
            Bike bike = detailcontroller.bike;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      bike.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff070623)),
                    ),
                  ),
                  const Gap(10),
                  buildStats(bike),
                  Gap(30),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset(
                        'assets/ellipse.png',
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ExtendedImage.network(
                          bike.image,
                          height: 250,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    ],
                  ),
                  const Gap(30),
                  Text(
                    'About',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff070623)),
                  ),
                  Gap(10),
                  Text(
                    bike.about,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff070623)),
                  ),
                  const Gap(30),
                  builPrice(bike),
                  const Gap(30),
                  buildSendMessage(bike),
                  Gap(100)
                ],
              ),
            );
          })
        ],
      ),
    );
  }

  Widget buildSendMessage(Bike bike){
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: const Color(0xFFFFFFFF),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: (){
          String uid = account.uid;
          Chat chat = Chat(
            roomId: uid, 
            message: 'Ready ?', 
            receiverId: 'cs', 
            senderId: uid,
            bikeDetail: {
              'image' : bike.image,
              'name' : bike.name,
              'category' : bike.category,
              'id' : bike.id,
            },
          );
          Info.netral('Loading...');
          ChatSource.openChatRoom(uid, account.name).then((value) {
            ChatSource.send(chat, uid).then((value) {
              Navigator.pushNamed(
                context, 
                '/chatting', 
                arguments: {
                  'uid' : uid,
                  'userName' : account.name,
                });
            });
          });
        },
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/ic_message.png',
                height: 24,
                width: 24,
              ),
              Gap(10),
              Text(
                'Send Message',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF070623),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }

  Widget builPrice(Bike bike) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      height: 88,
      decoration: BoxDecoration(
        color: const Color(0xff070623),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
           Expanded(
             child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    NumberFormat.currency(
                      decimalDigits: 0,
                      locale: 'en_US',
                      symbol: '\$',
                    ).format(bike.price),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffffffff),
                    ),
                  ),
                  const Text(
                    '/day',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffffffff),
                    ),
                  ),
                ],
              ),
           ),
            SizedBox(
              width: 132,
              child: ButtonPrimary(
                text: 'Book Now' , 
                onTap: (){
                  Navigator.pushNamed(context, '/booking', arguments: bike);
                }
              ),
            ),
          
        ],
      ),
    );
  }

  Row buildStats(Bike bike) {
    final stats = [
      ['assets/ic_beach.png', bike.level],
      [],
      ['assets/ic_downhill.png', bike.category],
      [],
      ['assets/ic_star.png', '${bike.rating}/5'],
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stats.map((e) {
        if (e.isEmpty) return const Gap(20);
        return Row(
          children: [
            Image.asset(
              e[0],
              height: 24,
              width: 24,
            ),
            const Gap(4),
            Text(
              e[1],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff070623)),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 46,
              width: 46,
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/ic_arrow_back.png',
                height: 24,
                width: 24,
              ),
            ),
          ),
          Expanded(
            child: const Text(
              'Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff070623)),
            ),
          ),
          Container(
            height: 46,
            width: 46,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/ic_favorite.png',
              height: 24,
              width: 24,
            ),
          )
        ],
      ),
    );
  }
}
