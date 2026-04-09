import 'package:flutter/material.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/ChatScreens/ChatScreen.dart';

class Mainchatscreen extends StatefulWidget {
  const Mainchatscreen({super.key});

  @override
  State<Mainchatscreen> createState() => _MainchatscreenState();
}

class _MainchatscreenState extends State<Mainchatscreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _allChats = [
    {
      'id': '1',
      'name': 'Skin Specialist',
      'message': 'Have a good one!',
      'time': '3:02 PM',
      'image': 'assets/images/profile1.png',
      'hasUnread': false,
      'unreadCount': 0,
      'isSeen': true,
    },
    {
      'id': '2',
      'name': 'Health care',
      'message': 'Hello, Are you available for toni...',
      'time': '2:58 PM',
      'image': 'assets/images/profile1.png',
      'hasUnread': true,
      'unreadCount': 2,
      'isSeen': false,
    },
    {
      'id': '3',
      'name': 'Mental Health Doc',
      'message': 'Have a good one!',
      'time': '3:02 PM',
      'image': 'assets/images/profile1.png',
      'hasUnread': false,
      'unreadCount': 0,
      'isSeen': true,
    },
  ];

  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredChats {
    if (_searchText.isEmpty) return _allChats;
    return _allChats.where((chat) {
      final name = (chat['name'] ?? '').toString().toLowerCase();
      final message = (chat['message'] ?? '').toString().toLowerCase();
      return name.contains(_searchText) || message.contains(_searchText);
    }).toList();
  }

  void _deleteChat(String id) {
    setState(() {
      _allChats.removeWhere((chat) => chat['id'] == id);
    });
  }

  Widget _searchBar(Size size) {
    return Container(
      height: size.height * 0.058,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.06),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: const Color(0xFF9D9D9D),
            size: size.width * 0.065,
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: TextField(
              controller: _searchController,
              textAlignVertical: TextAlignVertical.center, // ✅ important
              style: TextStyle(
                fontSize: size.width * 0.037,
                fontFamily: "poppin",
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: 'Search...',
                isDense: true, // ✅ important (removes extra height)
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintStyle: TextStyle(
                  fontSize: size.width * 0.027,
                  fontFamily: "poppin",
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFABABAB),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(Size size) {
    return Row(
      children: [
        Text(
          'Recent chats',
          style: TextStyle(
            fontSize: size.width * 0.032,
            fontFamily: "poppin",
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        Icon(
          Icons.add,
          color: const Color(0xFF3E8DDD),
          size: size.width * 0.06,
        ),
        SizedBox(width: size.width * 0.01),
        Text(
          'New message',
          style: TextStyle(
            fontSize: size.width * 0.029,
            fontFamily: "poppin",
            fontWeight: FontWeight.w700,
            color: const Color(0xFF3E8DDD),
          ),
        ),
      ],
    );
  }

  Widget _deleteBackground(Size size) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: size.width * 0.045),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      child: Container(
        width: size.width * 0.16,
        height: size.height * 0.08,
        decoration: BoxDecoration(
          color: const Color(0xFFF7DEDB),
          borderRadius: BorderRadius.circular(size.width * 0.05),
        ),
        child: Icon(
          Icons.delete_outline_rounded,
          color: const Color(0xFFF04A3A),
          size: size.width * 0.08,
        ),
      ),
    );
  }

  Widget _seenIcon(Size size) {
    return Icon(
      Icons.done_all,
      color: const Color(0xFF3D4DDA),
      size: size.width * 0.04,
    );
  }

  Widget _chatTile(
      Map<String, dynamic> chat,
      Size size, {
        required VoidCallback onTap,
      }) {
    final bool hasUnread = chat['hasUnread'] == true;
    final bool isSeen = chat['isSeen'] == true;
    final int unreadCount = chat['unreadCount'] ?? 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.092,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.045,
          vertical: size.height * 0.018,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.05),
          border: Border.all(
            color: const Color(0xFFE8E8E8),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: size.width * 0.12,
              height: size.width * 0.12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(chat['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: size.width * 0.025),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                            fontFamily: "poppin",
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            height: 1.1,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        chat['time'],
                        style: TextStyle(
                          fontSize: size.width * 0.025,
                          fontFamily: "poppin",
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.008),
                  Row(
                    children: [
                      if (isSeen) ...[
                        _seenIcon(size),
                        SizedBox(width: size.width * 0.015),
                      ],
                      Expanded(
                        child: Text(
                          chat['message'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: size.width * 0.023,
                            fontFamily: "poppin",
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF444444),
                            height: 1.1,
                          ),
                        ),
                      ),
                      if (hasUnread) ...[
                        SizedBox(width: size.width * 0.02),
                        Container(
                          width: size.width * 0.045,
                          height: size.width * 0.045,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3E8DDD),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$unreadCount',
                              style: TextStyle(
                                fontSize: size.width * 0.018,
                                fontFamily: "poppin",
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final chats = _filteredChats;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),
              Text(
                'Chats',
                style: TextStyle(
                  fontSize: size.width * 0.062,
                  fontFamily: "poppinbold",
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF222222),
                  height: 1.1,
                ),
              ),
              SizedBox(height: size.height * 0.027),

              _searchBar(size),
              SizedBox(height: size.height * 0.03),

              _sectionHeader(size),
              SizedBox(height: size.height * 0.017),

              if (chats.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  child: Center(
                    child: Text(
                      'No chats found',
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontFamily: "poppin",
                        color: const Color(0xFF888888),
                      ),
                    ),
                  ),
                )
              else
                ...List.generate(chats.length, (index) {
                  final chat = chats[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.01),
                    child: Dismissible(
                      key: ValueKey(chat['id']),
                      direction: DismissDirection.endToStart,
                      background: _deleteBackground(size),
                      onDismissed: (_) {
                        _deleteChat(chat['id']);
                      },
                      child: _chatTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Chatscreen()));
                          },
                          chat, size),
                    ),
                  );
                }),

              SizedBox(height: size.height * 0.12),
            ],
          ),
        ),
      ),
    );
  }
}