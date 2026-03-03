import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  static final String id = "chat_view";


  //! بنستخدم ScrollController عشان نتحكم في سلوك السكرول بتاع ال ListView
  final ScrollController scrollController = ScrollController();

  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called messages that references the firestore collection
  final CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollectionName,
  );

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    //! لازم اكدله انى باعت arguments من ال login view و ال register view عشان اقدر استخدمهم في ال chat bubbles بعد كده
    String? userEmail = ModalRoute.of(context)!.settings.arguments as String?;
    // بنستخدمها عشان نجيب ال arguments اللي جايين من ال login view & ال register view (اللي هو ال user email) عشان نقدر نستخدمه في ال chat bubbles بعد كده




    // استخدمنا StreamBuilder بدلاً من FutureBuilder لمراقبة البيانات لحظياً
    return StreamBuilder<QuerySnapshot>(
      // استخدمنا snapshots() بدلاً من get() لفتح قناة اتصال مستمرة
      // أضفت لك orderBy لترتيب الرسائل حسب الوقت
      stream: messages.orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          
          //! list of messages that we will get from firebase and display in the chat bubbles
          List<MessageModel> messagesList = [];

          // تحويل المستندات إلى قائمة من الموديل الخاص بنا
          //! we will convert the data we get from firebase to a list of MessageModel objects
          for(int i=0;i<snapshot.data!.docs.length;i++){
            messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }

          
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor.shade700,
              automaticallyImplyLeading: false,

              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(kLogo), width: 30, height: 30),
                  SizedBox(width: 10),
                  Text("Chat", style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),

            //!TODO: implement the chat bubbles here
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController, // بنربط ال ListView بال ScrollController اللي عملناه عشان نقدر نتحكم في سلوك السكرول بتاعها
                    reverse: true, // بنخليها تبدأ من تحت لفوق عشان الرسائل الجديدة تظهر تحت
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].senderEmail == userEmail
                          ? ChatBubble(
                              message: messagesList[index],
                            )
                          : ChatBubbleForMyFriend(
                              message: messagesList[index],
                            );
                    },
                  ),
                ),

                TextField(
                  controller: controller,
                  onSubmitted: (enteredMessage) {
                    // 1. Create a new document in the messages collection
                    // 2. Set the data of the document to the entered message and a timestamp
                    messages
                        .add({
                          kMessageFieldName: enteredMessage,
                          //! مهم جداً: لازم نستخدم serverTimestamp عشان نضمن ان التوقيت هيكون متزامن مع السيرفر مش مع الجهاز
                          'timestamp': FieldValue.serverTimestamp(),
                          // ignore: avoid_print

                          kSenderEmailFieldName: userEmail, // بنضيف البريد الإلكتروني للمرسل مع كل رسالة في قاعدة البيانات
                        })
                        .then((value) => print("Message Added"))
                        // ignore: avoid_print
                        .catchError(
                          (error) => print("Failed to add message: $error"),
                        );


                    // بعد ما نضيف الرسالة الجديدة، بنخلي ال ListView ترجع لأول السكرول عشان تظهر الرسالة الجديدة
                    scrollController.animateTo(
                      0, // بنخليها ترجع لأول السكرول عشان تظهر الرسالة الجديدة
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );

                    controller
                        .clear(); // بنمسح النص اللي في ال TextField بعد ما نرسل الرسالة
                  },

                  decoration: InputDecoration(
                    hintText: "Type your message here",
                    suffixIcon: Icon(Icons.send),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}


// shrinkWrap: true, // بتخليها تاخد مساحة العناصر فقط
            // physics:
            //     NeverScrollableScrollPhysics(), // بنقفل السكرول بتاعها عشان ميعملش تعارض مع سكرول خارجي
            // itemCount: 10,