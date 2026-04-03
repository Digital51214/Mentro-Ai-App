import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mentro_ai_app/Widgets/Backbutton.dart';

// ──────────────────────────────────────────────────────────────
//  DATA MODELS
// ──────────────────────────────────────────────────────────────

enum MessageType { text, voice }
enum MessageSender { me, other }

class ChatMessage {
  final String? id;
  final MessageType type;
  final MessageSender sender;
  final String? text;
  final Duration? voiceDuration; // for voice messages
  final String time;
  final String? quotedText; // for replied-to messages
  final String? quotedSender;

  const ChatMessage({
    this.id,
    required this.type,
    required this.sender,
    this.text,
    this.voiceDuration,
    required this.time,
    this.quotedText,
    this.quotedSender,
  });
}

// ──────────────────────────────────────────────────────────────
//  SCREEN WIDGET
// ──────────────────────────────────────────────────────────────

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // ── Static demo messages matching the design image ──────────
  final List<ChatMessage> _messages = const [
    ChatMessage(
      id: '1',
      type: MessageType.text,
      sender: MessageSender.other,
      text: 'Of course, let me know if you\'re on your way',
      time: '16:06',
      quotedText: 'Can I come over?',
      quotedSender: 'You',
    ),
    ChatMessage(
      id: '2',
      type: MessageType.text,
      sender: MessageSender.me,
      text: 'K, I am on my way',
      time: '16:50',
    ),
    ChatMessage(
      id: '3',
      type: MessageType.voice,
      sender: MessageSender.me,
      voiceDuration: Duration(seconds: 20),
      time: '09:13',
    ),
    ChatMessage(
      id: '4',
      type: MessageType.text,
      sender: MessageSender.other,
      text: 'Good morning, did you sleep well?',
      time: '09:05',
    ),
  ];

  // ── Track which voice is currently "playing" ────────────────
  String? _playingId;
  Timer? _voiceTimer;
  double _voiceProgress = 0.0;

  void _toggleVoice(String msgId, Duration duration) {
    if (_playingId == msgId) {
      // pause
      _voiceTimer?.cancel();
      setState(() {
        _playingId = null;
        _voiceProgress = 0.0;
      });
    } else {
      _voiceTimer?.cancel();
      setState(() {
        _playingId = msgId;
        _voiceProgress = 0.0;
      });
      final totalMs = duration.inMilliseconds;
      const tickMs = 100;
      _voiceTimer = Timer.periodic(const Duration(milliseconds: tickMs), (t) {
        setState(() {
          _voiceProgress += tickMs / totalMs;
        });
        if (_voiceProgress >= 1.0) {
          t.cancel();
          setState(() {
            _playingId = null;
            _voiceProgress = 0.0;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _voiceTimer?.cancel();
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ──────────────────────────────────────────────────────────
  //  COLORS
  // ──────────────────────────────────────────────────────────
  static const Color _green = Color(0xFF5DC98A);
  static const Color _blue = Color(0xFF3E8DDD);
  static const Color _lightBlue = Color(0xFFE8F1FB);
  static const Color _greyBg = Color(0xFFF0F0F0);
  static const Color _greyBg2 = Color(0xFFEDEDED);
  static const Color _darkText = Color(0xFF1A1A2E);
  static const Color _subText = Color(0xFF9D9D9D);

  // ──────────────────────────────────────────────────────────
  //  BUILD
  // ──────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(size),
            Expanded(child: _messageList(size)),
            _bottomBar(size),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────
  //  APP BAR
  // ──────────────────────────────────────────────────────────
  Widget _appBar(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.03,
      ),
      child: Row(
        children: [
          // back button
          CustomBackButton(),
          SizedBox(width: size.width * 0.035),
          // name
          Expanded(
            child: Text(
              'Chloe',
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontFamily: 'semibold',
                fontWeight: FontWeight.w700,
                color: _darkText,
              ),
            ),
          ),
          // call button
          _circleBtn(
            size,
            icon: Icons.phone_outlined,
            iconSize: size.width * 0.065,
            iconColor: _blue,
            onTap: () {},
          ),
          SizedBox(width: size.width * 0.03),
          // more button
          _circleBtn(
            size,
            icon: Icons.more_horiz_rounded,
            iconSize: size.width * 0.065,
            iconColor: _blue,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(
      Size size, {
        required IconData icon,
        required VoidCallback onTap,
        double? iconSize,
        Color iconColor = _blue,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.height * 0.058,
        height: size.height * 0.058,
        decoration: const BoxDecoration(
          color: _lightBlue,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: iconSize ?? size.width * 0.065),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────
  //  MESSAGE LIST
  // ──────────────────────────────────────────────────────────
  Widget _messageList(Size size) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.045,
        vertical: size.height * 0.01,
      ),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final msg = _messages[index];
        return Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.018),
          child: _buildMessage(msg, size),
        );
      },
    );
  }

  Widget _buildMessage(ChatMessage msg, Size size) {
    final isMe = msg.sender == MessageSender.me;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: isMe ? _myMessage(msg, size) : _otherMessage(msg, size),
    );
  }

  // ── OTHER person's message ──────────────────────────────
  Widget _otherMessage(ChatMessage msg, Size size) {
    return Container(
      constraints: BoxConstraints(maxWidth: size.width * 0.87),
      padding: EdgeInsets.only(
        left: size.width*0.045,
        right:size.width*0.045,
        top: size.height*0.015,
        bottom: size.height*0.01,
      ),
        // horizontal: size.width * 0.045,
        // vertical: size.height * 0.015,

      decoration: BoxDecoration(
        color: _greyBg2,
        borderRadius: BorderRadius.only(topRight: Radius.circular(size.width * 0.05),topLeft: Radius.circular(size.width * 0.05),bottomRight: Radius.circular(size.width * 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // quoted block
          if (msg.quotedText != null) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: size.width * 0.03),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomRight: Radius.circular(5),topRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
                color: _greyBg,
                border: Border(
                  left: BorderSide(color: _green, width: 3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      msg.quotedSender ?? '',
                      style: TextStyle(
                        fontSize: size.width * 0.025,
                        fontFamily: 'semibold',
                        fontWeight: FontWeight.w600,
                        color: _green,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    Text(
                      msg.quotedText!,
                      style: TextStyle(
                        fontSize: size.width * 0.025,
                        fontFamily: 'regular',
                        fontWeight: FontWeight.w400,
                        color: _darkText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.012),
          ],
          // actual text
          Text(
            msg.text ?? '',
            style: TextStyle(
              fontSize: size.width * 0.026,
              fontFamily: 'regular',
              fontWeight: FontWeight.w400,
              color: _darkText,
            ),
          ),
          SizedBox(height: size.height * 0.008),
          Text(
            msg.time,
            style: TextStyle(
              fontSize: size.width * 0.026,
              fontFamily: 'regular',
              color: _subText,
            ),
          ),
        ],
      ),
    );
  }

  // ── MY messages (green bubble) ──────────────────────────
  Widget _myMessage(ChatMessage msg, Size size) {
    if (msg.type == MessageType.voice) {
      return _myVoiceMessage(msg, size);
    }
    return Container(
      constraints: BoxConstraints(maxWidth: size.width * 0.40),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.045,
        vertical: size.height * 0.016,
      ),
      decoration: BoxDecoration(
        color: _green,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(size.width*0.05),topRight: Radius.circular(size.width*0.05),bottomLeft: Radius.circular(size.width*0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            msg.text ?? '',
            style: TextStyle(
              fontSize: size.width * 0.03,
              fontFamily: 'regular',
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          SizedBox(height: size.height * 0.007),
          Text(
            msg.time,
            style: TextStyle(
              fontSize: size.width * 0.026,
              fontFamily: 'regular',
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // ── VOICE message bubble ────────────────────────────────
  Widget _myVoiceMessage(ChatMessage msg, Size size) {
    final isPlaying = _playingId == msg.id;
    final duration = msg.voiceDuration ?? Duration.zero;
    final totalSec = duration.inSeconds;

    // Format duration label
    String durationLabel() {
      if (isPlaying) {
        final elapsed = (_voiceProgress * totalSec).round();
        final remaining = totalSec - elapsed;
        final m = remaining ~/ 60;
        final s = remaining % 60;
        return '${m.toString().padLeft(1, '0')}:${s.toString().padLeft(2, '0')}';
      }
      final m = totalSec ~/ 60;
      final s = totalSec % 60;
      return '${m.toString().padLeft(1, '0')}:${s.toString().padLeft(2, '0')}';
    }

    return Container(
      constraints: BoxConstraints(maxWidth: size.width * 0.5),
      padding: EdgeInsets.all(size.width * 0.03),
      decoration: BoxDecoration(
        color: _green,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(size.width*0.05),topRight: Radius.circular(size.width*0.05),bottomLeft: Radius.circular(size.width*0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ── inner blue player card ───────────────────────
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.01,
              vertical: size.height * 0.014,
            ),
            decoration: BoxDecoration(
              color: _blue,
              borderRadius: BorderRadius.circular(size.width * 0.01),
            ),
            child: Row(
              children: [
                // play/pause button
                GestureDetector(
                  onTap: () => _toggleVoice(msg.id!, duration),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: size.width * 0.05,
                  ),
                ),
                SizedBox(width: size.width * 0.01),
                // duration text
                Text(
                  durationLabel(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.025,
                    fontFamily: 'regular',
                  ),
                ),
                SizedBox(width: size.width * 0.025),
                // waveform bars
                Expanded(child: _waveform(size, isPlaying)),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.006),
          Text(
            msg.time,
            style: TextStyle(
              fontSize: size.width * 0.026,
              color: Colors.white70,
              fontFamily: 'regular',
            ),
          ),
        ],
      ),
    );
  }

  // ── Waveform visual ──────────────────────────────────────
  Widget _waveform(Size size, bool isPlaying) {
    // Bar heights pattern – mimics real voice waveform
    const List<double> heights = [
      0.3, 0.6, 1.0, 0.7, 0.5, 0.8, 0.4, 1.0, 0.6, 0.3,
      0.7, 0.9, 0.5, 1.0, 0.4, 0.6, 0.8, 0.3, 0.7, 0.5,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(heights.length, (i) {
        final fraction = i / heights.length;
        final active = isPlaying && fraction <= _voiceProgress;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          width: size.width * 0.012,
          height: size.height * 0.025 * heights[i],
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.white54,
            borderRadius: BorderRadius.circular(size.width * 0.01),
          ),
        );
      }),
    );
  }

  // ──────────────────────────────────────────────────────────
  //  BOTTOM BAR
  // ──────────────────────────────────────────────────────────
  Widget _bottomBar(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.015,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff3A8DD9).withOpacity(0.05),
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        children: [
          // plus button
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.add, color: _blue, size: size.width * 0.06),
          ),
          SizedBox(width: size.width * 0.03),
          // text field
          Expanded(
            child: Container(
              height: size.height * 0.047,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade300, width: 1.2),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      style: TextStyle(
                        fontSize: size.width * 0.038,
                        fontFamily: 'regular',
                        color: _darkText,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(
                          color: _subText,
                          fontSize: size.width * 0.03,
                          fontFamily: 'regular',
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),
                  ),
                  // attachment icon
                  Icon(Icons.attach_file_rounded, color: _blue, size: size.width * 0.05),
                ],
              ),
            ),
          ),
          SizedBox(width: size.width * 0.03),
          // send button
          GestureDetector(
            onTap: _sendMessage,
            child: Icon(Icons.send_rounded, color: _blue, size: size.width * 0.06),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    // Handle send — extend with real logic
    _msgController.clear();
  }
}