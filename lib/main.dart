import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socket.IO Multi-Client',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  final List<String> messages = [];
  final TextEditingController messageController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  String room = "room1"; // Sala fixa para ambos os apps.

  @override
  void initState() {
    super.initState();
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io(
      'http://localhost:5555', // Substitua pelo endereço do seu servidor
      IO.OptionBuilder()
          .setTransports(['websocket']) // Usa WebSocket
          .disableAutoConnect() // Evita conexão automática
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print('Conectado ao servidor Socket.IO');
      _joinRoom();
    });

    socket.onDisconnect((_) {
      print('Desconectado do servidor');
    });

    socket.on('newMessage', (data) {
      print('Nova mensagem recebida: $data');
      setState(() {
        messages.add("${data['username']}: ${data['message']}");
      });
    });
  }

  void _joinRoom() {
    final username =
        usernameController.text.isEmpty ? "Usuário_${DateTime.now().millisecondsSinceEpoch}" : usernameController.text;

    socket.emit('joinRoom', {
      'username': username,
      'room': room,
    });

    setState(() {
      messages.add("$username entrou na sala $room.");
    });
  }

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      final message = messageController.text;
      socket.emit('sendMessage', {
        'room': room,
        'message': message,
        'username': usernameController.text.isEmpty
            ? "Usuário_${DateTime.now().millisecondsSinceEpoch}"
            : usernameController.text,
      });

      setState(() {
        // messages.add("Você: $message");
      });

      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket.IO Multi-Client Chat'),
      ),
      body: Column(
        children: [
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              hintText: "Digite seu nome de usuário",
              labelText: "Nome de Usuário",
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Digite sua mensagem',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    socket.dispose();
    messageController.dispose();
    usernameController.dispose();
    super.dispose();
  }
}
