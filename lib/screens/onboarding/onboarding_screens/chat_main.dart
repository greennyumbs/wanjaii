import 'package:flutter/material.dart';
import 'package:flutter_dating_app/screens/onboarding/onboarding_screens/individual_chat_page.dart';

class ChatMain extends StatefulWidget {
  const ChatMain({super.key});

  @override
  State<ChatMain> createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    FirstPage(),
    SecondPage(),
    ChatPage(),
    PeoplePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Navigation Example'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/phone.png'),
            label: 'Phone',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/inactive.png'),
            label: 'Inactive',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/chat.png'),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/people.png'),
            label: 'People',
          ),
        ],
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('First Page'),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Second Page'),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Messages',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                  'assets/images/filter.png'), // Use the filter icon here
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            'New Matches',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildChatUser(context, 'You', 'assets/images/person1.png'),
              _buildChatUser(context, 'Emma', 'assets/images/person2.png'),
              _buildChatUser(context, 'Ava', 'assets/images/person3.png'),
              _buildChatUser(context, 'Emelie', 'assets/images/person4.png'),
              // _buildChatUser(context, 'Elizabeth', 'assets/images/person5.png'),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            'Messages',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
              children: [
                ChatTile(
                  name: 'Emma',
                  image: 'assets/images/person2.png',
                  message: 'I\'m good, thanks!',
                ),
                ChatTile(
                  name: 'Ava',
                  image: 'assets/images/person3.png',
                  message: 'What\'s up?',
                ),
                ChatTile(
                  name: 'Emelie',
                  image: 'assets/images/person4.png',
                  message: 'Sticker',
                ),
                ChatTile(
                  name: 'Elizabeth',
                  image: 'assets/images/person5.png',
                  message: 'OK,see you then',
                ),
                // Add more ChatTile widgets for additional messages
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatUser(BuildContext context, String name, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualChatPage(personName: name),
          ),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage(imagePath),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String image;
  final String message;

  ChatTile({required this.name, required this.image, required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: AssetImage(image),
      ),
      title: Text(name),
      subtitle: Text(message),
      onTap: () {
        // Handle tapping on the chat tile
      },
    );
  }
}

class PeoplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('People Page'),
    );
  }
}
