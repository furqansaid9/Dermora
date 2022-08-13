const newNessage = require("../models/message.model").newMessage;

module.exports = (io) => {
  io.on("connection", (socket) => {
    socket.on("joinChat", (chatId) => {
      socket.join(chatId);
    });
    socket.on("sendMessage", (msg) => {
      newNessage(msg).then(() => {
        io.to(msg.chatId).emit("newMessage", msg);
      });
    });
  });
};
