const mongoose = require("mongoose");
const dbConfig = require("../config2");
const DB_URL = dbConfig.db;
const User = require("./user.model").User;

const chatSchema = mongoose.Schema({
  users: [{ type: mongoose.Schema.Types.ObjectId, ref: "user" }],
  startTime: Date,
  endTime: Date,
  isStarted: Boolean,
  isClosed: Boolean,
});

const Chat = mongoose.model("chat", chatSchema);
exports.Chat = Chat;

exports.getChatInfo = async (chatId) => {
  try {
    await mongoose.connect(DB_URL, {
      useUnifiedTopology: true,
      useNewUrlParser: true,
    });
    let chat = await Chat.findById(chatId);
    // mongoose.disconnect();
    return chat;
  } catch (error) {
    console.log(error);

    // mongoose.disconnect();
    throw new Error(error);
  }
};

exports.getChat = async (chatId) => {
  try {
    await mongoose.connect(DB_URL, {
      useUnifiedTopology: true,
      useNewUrlParser: true,
    });
    let chat = await Chat.findById(chatId).populate("users");
    return chat;
  } catch (error) {
    console.log(error);
    // mongoose.disconnect();
    throw new Error(error);
  }
};

exports.sendFriendRequest = async (data) => {
  try {
    await mongoose.connect(DB_URL, {
      useUnifiedTopology: true,
      useNewUrlParser: true,
    });
    await User.updateOne(
      { _id: data.userId },
      {
        $push: {
          friendRequests: {
            name: data.name,
            id: data.id,
            time: data.time,
            age: data.age,
            city: data.city,
            image: data.image,
          },
        },
      }
    );
    //add user2 to user1 sent requests
    await User.updateOne(
      { _id: data.id },
      { $push: { sentRequests: { name: data.userName, id: data.userId } } }
    );

    mongoose.disconnect();

    return;
  } catch (error) {
    mongoose.disconnect();
    throw new Error(error);
  }
};

exports.createChat = async (data) => {
  try {
    // delete from friends request  user2
    await mongoose.connect(DB_URL, {
      useUnifiedTopology: true,
      useNewUrlParser: true,
    });
    await User.updateOne(
      { _id: data.id },
      {
        $pull: { friendRequests: { name: data.userName, id: data.userId } },
      }
    );
    // delete request in sentrequest user 1
    await User.updateOne(
      { _id: data.userId },
      { $pull: { sentRequests: { id: data.id } } }
    );
    // data here includes the user id and friend id and other details
    let newChat = new Chat({
      users: [data.userId, data.id],
      startTime: "",
      endTime: "",
      isStarted: false,
      isClosed: false,
    });
    let chatDoc = await newChat.save();

    // add user1 in user2 friends
    await User.updateOne(
      { _id: data.id },
      {
        $push: {
          friends: {
            name: data.userName,
            id: data.userId,
            image: data.userImage,
            chatId: chatDoc._id,
            status: true,
          },
        },
      }
    );

    await User.updateOne(
      { _id: data.userId },
      {
        $push: {
          friends: {
            name: data.name,
            id: data.id,
            image: data.image,
            chatId: chatDoc._id,
            status: true,
          },
        },
      }
    );
    mongoose.disconnect();
    return;
  } catch (error) {
    mongoose.disconnect();
    throw new Error(error);
  }
};

exports.updateChat = async (chatId) => {
  try {
    await mongoose.connect(DB_URL, {
      useUnifiedTopology: true,
      useNewUrlParser: true,
    });

    var d = new Date();

    await Chat.findByIdAndUpdate(
      { _id: chatId },
      {
        $set: {
          startTime: Date(d.getTime()),
          endTime: d.setMinutes(d.getMinutes() + 5),
          isStarted: true,
        },
      }
    );

    // mongoose.disconnect();
    return;
  } catch (error) {
    // mongoose.disconnect();
    throw new Error(error);
  }
};

exports.updateChatStatus = async (chatId, userId) => {
  try {
    await mongoose.connect(DB_URL, {
      useUnifiedTopology: true,
      useNewUrlParser: true,
    });

    await Chat.findByIdAndUpdate(
      { _id: chatId },
      {
        $set: {
          isClosed: true,
        },
      }
    );
    await User.updateOne(
      { _id: userId, "friends.chatId": chatId },
      {
        $set: {
          "friends.$.status": false,
        },
      }
    );

    mongoose.disconnect();
    return;
  } catch (error) {
    mongoose.disconnect();
    throw new Error(error);
  }
};
