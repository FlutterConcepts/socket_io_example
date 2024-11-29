require('dotenv').config();
const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const cors = require('cors');
const { createRoom, getRoomParticipants } = require('./src/rooms/roomManager');

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: '*', // Permite conexões de qualquer origem (ajuste para produção)
  },
});

const PORT = process.env.PORT || 5555;

app.use(cors());
app.use(express.json());

// Configuração do Socket.IO
io.on('connection', (socket) => {
  console.log(`Cliente conectado: ${socket.id}`);

  // Evento de entrar em uma sala
  socket.on('joinRoom', ({ username, room }) => {
    socket.join(room);
    createRoom(room, username);

    // Envia a lista de participantes da sala
    const participants = getRoomParticipants(room);
    io.to(room).emit('updateParticipants', participants);

    console.log(`${username} entrou na sala ${room}`);
    io.to(room).emit('newMessage', {
      username: 'Sistema',
      message: `${username} entrou na sala.`,
    });
  });

  // Evento de envio de mensagem
  socket.on('sendMessage', ({ username, room, message }) => {
    io.to(room).emit('newMessage', { username, message });
  });

  // Evento de sair da sala
  socket.on('disconnect', () => {
    console.log(`Cliente desconectado: ${socket.id}`);
  });
});

server.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
