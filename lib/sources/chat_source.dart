import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_motor/models/chat.dart';

class ChatSource {
  static openChatRoom(String uid, String userName) async {
    final doc =
        await FirebaseFirestore.instance.collection('CS').doc(uid).get();
    if (doc.exists) {
      await FirebaseFirestore.instance.collection('CS').doc(uid).update({
        'newFromCS': false,
      });
      return;
    }

    await FirebaseFirestore.instance.collection('CS').doc(uid).set({
      'roomId': uid,
      'name': userName,
      'lastMessage': 'Welcome to Motobike',
      'newFromUser': false,
      'newFromCS': true,
    });

    await FirebaseFirestore.instance
        .collection('CS')
        .doc(uid)
        .collection('chats')
        .add({
      'roomId': uid,
      'name': userName,
      'lastMessage': 'Welcome to Motobike',
      'newFromUser': false,
      'newFromCS': true,
    });

    await FirebaseFirestore.instance
        .collection('CS')
        .doc(uid)
        .collection('chats')
        .add({
      'roomId': uid,
      'message': 'Welcome to Motobike',
      'receiverId': uid,
      'senderId': 'cs',
      'bikeDetail': null,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> send(Chat chat, String uid) async {
     await FirebaseFirestore.instance
        .collection('CS')
        .doc(uid)
        .update({
      'lastMessage': 'chat.message',
      'newFromUser': true,
      'newFromCS': false,
    });
    FirebaseFirestore.instance
        .collection('CS')
        .doc(uid)
        .collection('chats')
        .add({
      'roomId': chat.roomId,
      'message': chat.message,
      'receiverId': chat.receiverId,
      'senderId': chat.senderId,
      'bikeDetail': chat.bikeDetail,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
