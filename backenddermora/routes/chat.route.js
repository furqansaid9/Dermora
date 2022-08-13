const router = require("express").Router();
const chatController = require("../controllers/chat.controller");
const bodyParser = require("body-parser");

router.get("/chat/:id", chatController.getChat);
router.get("/chatInfo/:id", chatController.getChatInfo);

router.post(
  "/createChat",
  bodyParser.urlencoded({ extended: true }),
  chatController.createChat
);
router.post(
  "/updateChat",
  bodyParser.urlencoded({ extended: true }),
  chatController.updateChat
);

router.post(
  "/updateChatStatus",
  bodyParser.urlencoded({ extended: true }),
  chatController.updateChatStatus
);

module.exports = router;
