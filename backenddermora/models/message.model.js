const mongoose = require("mongoose");
const dbConfig = require("../config2");
const DB_URL = dbConfig.db;

const messageSchema = mongoose.Schema({
  chat: { type: mongoose.Schema.Types.ObjectId, ref: "chat" },
  sender: { type: mongoose.Schema.Types.ObjectId, ref: "user" },
  content: String,
  timestamp: String,
});

const Message = mongoose.model("message", messageSchema);

exports.getMessages = async (chatId) => {
  console.log(chatId);
  try {
    await mongoose.connect(DB_URL, {
      useUnifiedTopology: true,
      useNewUrlParser: true,
    });
    let messages = await Message.find({ chat: chatId }, null, {
      sort: { timestamp: 1 },
    });
    // mongoose.disconnect();
    return messages;
  } catch (error) {
    console.log(error);
    // mongoose.disconnect();
    throw new Error(error);
  }
};

exports.newMessage = async (msg) => {
  /*
        chat: chatId,
        content: content,
        sender: userId
  
  */
  try {
    await mongoose.connect(DB_URL, {
      useUnifiedTopology: true,
      useNewUrlParser: true,
    });
    var d = new Date();
    msg.timestamp = d.toLocaleTimeString();
    let newMsg = new Message({
      chat: msg.chatId,
      sender: msg.sender,
      content: msg.content,
      timestamp: msg.timestamp,
    });
    await newMsg.save();
    mongoose.disconnect();
    return;
  } catch (error) {
    mongoose.disconnect();
    throw new Error(error);
  }
};
