import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/message_model.dart';

class VoiceMessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sesli mesaj gönderme fonksiyonu
  Future<void> sendVoiceMessage(
      String receiverId, String voiceMessageUrl) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final String currentUserId = currentUser.uid;
    final String currentUserEmail = currentUser.email.toString();
    final Timestamp timestamp = Timestamp.now();
    VoiceMessage newVoiceMessage = VoiceMessage(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      voiceMessageUrl: voiceMessageUrl,
      timestamp: timestamp,
    );
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore
        .collection('voice_chat_rooms')
        .doc(chatRoomId)
        .collection('voice_messages')
        .add(newVoiceMessage.toMap());
  }

  // Sesli mesajları almak için Stream
  Stream<QuerySnapshot> getVoiceMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection('voice_chat_rooms')
        .doc(chatRoomId)
        .collection('voice_messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

// Sesli Mesaj Modeli
class VoiceMessage {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String voiceMessageUrl;
  final Timestamp timestamp;

  VoiceMessage({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.voiceMessageUrl,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'voiceMessageUrl': voiceMessageUrl,
      'timestamp': timestamp,
    };
  }
}
