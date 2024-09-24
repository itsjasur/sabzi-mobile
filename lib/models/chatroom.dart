class Chatroom {
  final int id;
  final String senderName;
  final String senderImageUrl;
  final String timestamp;
  final String location;
  String? latestMessage;

  Chatroom({
    required this.id,
    required this.senderName,
    required this.senderImageUrl,
    required this.timestamp,
    required this.location,
    this.latestMessage,
  });

  factory Chatroom.fromMap(Map<String, dynamic> map) {
    return Chatroom(
      id: map['id'] as int,
      senderName: map['sender_name'] as String,
      senderImageUrl: map['senderImageUrl'] as String,
      timestamp: map['timestamp'] as String,
      location: map['location'] as String,
      latestMessage: map['latestMessage'] as String,
    );
  }
}
