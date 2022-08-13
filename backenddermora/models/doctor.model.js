const User = require("./user.model").User;
const mongoose = require("mongoose");
const dbConfig = require("../config2");
const DB_URL = dbConfig.db;

exports.getAvailableDoctors = () => {
  return new Promise((resolve, reject) => {
    mongoose
      .connect(DB_URL, {
        useUnifiedTopology: true,
        useNewUrlParser: true,
      })
      .then(() => {
        return User.find({ "doctorInfo.isAvailable": true });
      })
      .then((res) => {
        mongoose.disconnect();
        resolve(res);
      })
      .catch((err) => {
        mongoose.disconnect();
        reject(err);
      });
  });
};
