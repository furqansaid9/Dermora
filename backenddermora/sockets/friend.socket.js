const sendFriendRequest = require("../models/chat.model").sendFriendRequest;

module.exports = (io) => {
  io.on("connection", (socket) => {
    socket.on("joinNotificationRoom", (id) => {
      socket.join(id);
      console.log("join", id);
    });
    socket.on("sendFriendRequest", (data) => {
      var d = new Date();

      sendFriendRequest({ ...data, time: d.toLocaleTimeString() }) // update the db
        .then(() => {
          var d = new Date();
          io.to(data.userId).emit("newFriendRequest", {
            name: data.name,
            id: data.id,
            image: data.image,
            city: data.city,
            age: data.age,
            time: d.toLocaleTimeString(),
          });
        })
        .catch((err) => {
          socket.emit("requestFailed");
        });
    });
    socket.on("requestAccepted", (userId, id) => {
      console.log("here iam in the server");
      io.to(userId).emit("accepted", {
        id: id,
      });
    });
  });
};
