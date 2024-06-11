import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  ChatUser mySelf = ChatUser(id: '1', firstName: 'bawer');
  ChatUser bot = ChatUser(id: '2', firstName: 'gemini');
  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];
  final ourUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyBD63pB7Xyq85S4nijajy7OJbyGFpmF5NQ'; // Replace with your API key
  final header = {'Content-Type': 'application/json'};
  List<String> categories = [];

  // Function to get categories from Firestore
  Future<void> getCategories() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    categories = querySnapshot.docs
        .map((doc) => (doc['name'] as String).trim().toUpperCase())
        .toList();
    print("Categories loaded: $categories");
  }

  // Function to get book recommendations based on genre
  Future<void> getBookRecommendations(String genre) async {
    typing.add(bot);
    setState(() {});

    var data = {
      "contents": [
        {
          "parts": [
            {"text": "Recommend me some books in the genre of $genre"}
          ]
        }
      ]
    };

    try {
      final response = await http.post(
        Uri.parse(ourUrl),
        headers: header,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        String recommendation =
            result['candidates'][0]['content']['parts'][0]['text'];
        ChatMessage responseMessage = ChatMessage(
          text: 'I recommend the following books in $genre: $recommendation',
          user: bot,
          createdAt: DateTime.now(),
        );
        allMessages.insert(0, responseMessage);
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error: $e");
    }

    typing.remove(bot);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Fetch categories when the widget initializes
    getCategories().then((_) {
      // Create a message asking user to choose a category
      ChatMessage categoryMessage = ChatMessage(
        text:
            'I am a book chatbot. Choose one of these categories according to your interests: ${categories.join(', ')}',
        user: bot,
        createdAt: DateTime.now(),
      );
      allMessages.add(categoryMessage);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Bot'),
      ),
      body: DashChat(
        typingUsers: typing,
        currentUser: mySelf,
        onSend: (ChatMessage message) {
          allMessages.insert(0, message);
          String userInput = message.text.trim().toUpperCase();
          print("User input: $userInput");
          print("Categories: $categories");

          if (categories.contains(userInput)) {
            getBookRecommendations(userInput);
          } else {
            ChatMessage errorMessage = ChatMessage(
              text:
                  'Please choose one of the listed categories: ${categories.join(', ')}',
              user: bot,
              createdAt: DateTime.now(),
            );
            allMessages.insert(0, errorMessage);
            setState(() {});
          }
        },
        messages: allMessages,
      ),
    );
  }
}
