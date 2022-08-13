const express = require("express");

const errors = require("./helpers/errors");
const auth = require("./helpers/auth");

const unless = require("express-unless");

const app = express();
app.use(express.json());

const authRouter = require("./routes/auth.route");
const userRouter = require("./routes/user.route");
const doctorRouter = require("./routes/doctor.route");
const chatRouter = require("./routes/chat.route");
const routineRouter = require("./routes/routine.route");

const server = require("http").createServer(app);
const io = require("socket.io")(server);
var cors = require("cors");
const res = require("express/lib/response");
app.use(cors());

auth.authenticateToken.unless = unless;

app.use(
  auth.authenticateToken.unless({
    path: [
      { url: "/login", methods: ["POST"] },
      { url: "/signup", methods: ["POST"] },
    ],
  })
);

require("./sockets/chat.socket")(io);
require("./sockets/friend.socket")(io);

app.use(errors.errorHandler);
app.use("/", authRouter);
app.use("/", userRouter);
app.use("/", doctorRouter);
app.use("/", chatRouter);
app.use("/", routineRouter);

const port = process.env.PORT || 3000;

server.listen(port, function (err) {
  if (err) throw err;
  console.log("Listening on port %d", port);
});
