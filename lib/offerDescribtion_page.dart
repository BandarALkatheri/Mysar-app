import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskyfinaly/common/custom_button.dart';
import 'package:taskyfinaly/common/showErrorSnackBar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OfferDescriptionPage extends StatefulWidget {
  final String imageUrl;
  final String price;
  final String description;
  final String location;
  final String fullDescription;
  final String title;

  const OfferDescriptionPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.location,
    required this.fullDescription,
  });

  @override
  State<OfferDescriptionPage> createState() => _OfferDescriptionPageState();
}

class _OfferDescriptionPageState extends State<OfferDescriptionPage> {
  final TextEditingController _commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final bool _isTyping = false;

  Future<void> _submitComment() async {
    final user = _auth.currentUser;
    if (user != null && _commentController.text.isNotEmpty) {
      final userEmail = user.email;
      final now = DateTime.now();

      // Check how many comments the user has already made for this offer
      final commentsSnapshot = await _firestore
          .collection('offers')
          .doc(widget.title)
          .collection('comments')
          .where('email', isEqualTo: userEmail)
          .get();

      if (commentsSnapshot.docs.length < 3) {
        await _firestore
            .collection('offers')
            .doc(widget.title)
            .collection('comments')
            .add({
          'email': userEmail ?? 'غير معروف',
          'time': now,
          'comment': _commentController.text,
          // Initialize the like count
        });

        _commentController.clear();

        showErrorSnackBar(context, 'تم إرسال تعليقك بنجاح!');
      } else {
        showErrorSnackBar(
            context, 'لا يمكنك إضافة أكثر من 3 تعليقات على نفس الخدمة.');
      }
    } else {
      showErrorSnackBar(context, 'يرجى تسجيل الدخول وإدخال تعليق لإرساله.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'السعر: ${widget.price}',
                      style: const TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            final call =
                                Uri.parse('tel:${widget.fullDescription}');
                            if (await canLaunchUrl(call)) {
                              await launchUrl(call);
                            } else {
                              throw 'Could not launch $call';
                            }
                          } catch (e) {
                            showErrorSnackBar(
                                context, 'Error launching phone call: $e');
                          }
                        },
                        child: const Text(
                          'اطلب الآن',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'المهندس',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Helvetica',
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'الموقع',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.location,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Helvetica',
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'تفاصيل إضافية',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Helvetica',
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // نموذج التعليقات
                const Text(
                  'أضف تعليقك',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: 'اكتب تعليقك هنا...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _submitComment,
                  child: const Text('إرسال التعليق'),
                ),

                const SizedBox(height: 20),

                // عرض التعليقات
                const Text(
                  'التعليقات',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('offers')
                      .doc(widget.title)
                      .collection('comments')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: Text('لا توجد تعليقات بعد.'));
                    }
                    final comments = snapshot.data!.docs;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment =
                            comments[index].data() as Map<String, dynamic>;
                        final email = comment['email'] ?? 'غير معروف';
                        final time = (comment['time'] as Timestamp).toDate();
                        final commentText = comment['comment'] ?? '';

                        return Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 26, 0.1),
                                  blurRadius: 0,
                                  spreadRadius: 0.5,
                                  offset: Offset(
                                    0,
                                    1,
                                  ),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white38),
                          child: ListTile(
                            title: Text(email),
                            subtitle: Text(commentText),
                            trailing: Text('${time.hour}:${time.minute}'),
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
