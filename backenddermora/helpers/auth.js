const jwt = require("jsonwebtoken");

const authenticateToken = (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (token == null) return res.sendStatus(401);

  jwt.verify(token, "Amirah adam", (err, user) => {
    if (err) return res.sendStatus(403);
    req.user = user;
    next();
  });
};

const generateAccessToken = (email) => {
  return jwt.sign({ data: email }, "Amirah adam", {
    expiresIn: "1h",
  });
};

module.exports = {
  generateAccessToken,
  authenticateToken,
};
