const mongoose = require("mongoose");
const dbConfig = require("../config2");
const DB_URL = dbConfig.db;
const bcrypt = require("bcrypt");
const auth = require("../helpers/auth");
const Routine = require("./routine.model").Routine;
const userSchema = mongoose.Schema(
  {
    email: String,
    isFirst: { type: Boolean, default: true },
    fullName: String,
    password: String,
    phone: String,
    age: { type: Number, default: 0 },
    sex: { type: String, default: "" },
    image: { type: String, default: "" },
    address: {
      country: { type: String, default: "" },
      city: { type: String, default: "" },
      street: { type: String, default: "" },
      postCode: { type: Number },
    },
    kind: { type: String, default: "user" },
    doctorInfo: {
      isAvailable: { type: Boolean, default: false },
      noOfPatients: Number,
      workDetails: {
        clinicName: String,
        address: String,
        jobTitle: String,
        experience: String,
      },
      patients: Array,
      requests: {
        type: [{ id: Number, status: { type: Boolean, default: false } }],
      },
    },
    userInfo: {
      skinType: String,
      skinConcerns: Array,
    },
    friends: {
      // users for doctors and vice versa
      type: [
        {
          name: String,
          id: String,
          image: String,
          friendId: String,
          chatId: String,
          status: Boolean,
        },
      ],
      default: [],
    },
    friendRequests: {
      type: [
        {
          name: String,
          id: String,
          time: String,
          age: Number,
          city: String,
          image: String,
        },
      ],
      default: [],
    },
    sentRequests: {
      type: [
        {
          name: String,
          id: String,
          time: String,
          age: Number,
          city: String,
          image: String,
        },
      ],
      default: [],
    },
  },
  { minimize: false }
);

const User = mongoose.model("user", userSchema);
exports.User = User;

//////////////////////////////////////////////////////

exports.getUser = (userId) => {
  return new Promise((resolve, reject) => {
    mongoose
      .connect(DB_URL, {
        useUnifiedTopology: true,
        useNewUrlParser: true,
      })
      .then(() => {
        return User.findById(userId);
      })
      .then((res) => {
        // mongoose.disconnect();
        resolve(res);
      })
      .catch((err) => {
        mongoose.disconnect();
        reject(err);
      });
  });
};

exports.updateProfile = (name, skinType, image, id) => {
  return new Promise((resolve, reject) => {
    mongoose
      .connect(DB_URL, {
        useUnifiedTopology: true,
        useNewUrlParser: true,
      })
      .then(() => {
        return User.updateMany(
          { _id: id },
          {
            $set: {
              fullName: name,
              "userInfo.skinType": skinType,
              image: image,
            },
          },
          { multi: true }
        );
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
exports.updateAgeSex = (age, sex, id) => {
  return new Promise((resolve, reject) => {
    mongoose
      .connect(DB_URL, {
        useUnifiedTopology: true,
        useNewUrlParser: true,
      })
      .then(() => {
        return User.findByIdAndUpdate(id, { age: age, sex: sex });
      })
      .then((res) => {
        mongoose.disconnect();
        resolve();
      })
      .catch((err) => {
        mongoose.disconnect();
        reject(err);
      });
  });
};
exports.updateSkinType = (type, id) => {
  return new Promise((resolve, reject) => {
    mongoose
      .connect(DB_URL, {
        useUnifiedTopology: true,
        useNewUrlParser: true,
      })
      .then(() => {
        return User.updateOne(
          { _id: id },
          { $set: { "userInfo.skinType": type } }
        );
      })
      .then((res) => {
        mongoose.disconnect();
        resolve();
      })
      .catch((err) => {
        mongoose.disconnect();
        reject(err);
      });
  });
};
exports.updateConcerns = (concerns, id) => {
  return new Promise((resolve, reject) => {
    mongoose
      .connect(DB_URL, {
        useUnifiedTopology: true,
        useNewUrlParser: true,
      })
      .then(() => {
        return User.updateOne(
          { _id: id },
          { $set: { "userInfo.skinConcerns": concerns } }
        );
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
////////////////////////////////////////////////////////

exports.createUser = (email, password, name) => {
  return new Promise((resolve, reject) => {
    mongoose
      .connect(DB_URL, { useUnifiedTopology: true, useNewUrlParser: true })
      .then(() => {
        return User.findOne({ email: email });
      })
      .then((user) => {
        if (user) {
          mongoose.disconnect();
          reject("Email exists");
        } else return bcrypt.hash(password, 10);
      })
      .then((hashedPassword) => {
        let user = new User({
          email: email,
          password: hashedPassword,
          fullName: name,
          phone: "+601111254182",
          address: {
            country: "Malaysia",
            city: "Kuala Lumpur",
            street: "",
            postCode: 0,
          },
          userInfo: { skinType: "", skinConcerns: [], doctors: [] },
        });
        return user.save();
      })
      .then((user) => {
        let newRoutine = new Routine({
          user: user._id,
          morningRoutine: {
            time: "",
            products: [],
          },
          nightRoutine: {
            time: "",
            products: [],
          },
        });
        return newRoutine.save();
      })
      .then(() => {
        mongoose.disconnect();
        resolve();
      })
      .catch((err) => {
        mongoose.disconnect();
        reject(err);
      });
  });
};

exports.login = (email, password) => {
  console.log("welcome");

  return new Promise((resolve, reject) => {
    mongoose
      .connect(DB_URL, { useUnifiedTopology: true, useNewUrlParser: true })
      .then(() => User.findOne({ email: email }))
      .then((user) => {
        if (!user) {
          mongoose.disconnect();
          console.log("this email does not exist");
          reject("this email does not exist");
        } else {
          bcrypt.compare(password, user.password).then((same) => {
            if (!same) {
              mongoose.disconnect();
              console.log("password is incorrect");
              reject("password is incorrect");
            } else {
              mongoose.disconnect();
              const token = auth.generateAccessToken(email);
              resolve({ user, token });
            }
          });
        }
      })
      .catch((err) => {
        mongoose.disconnect();
        console.log(err);
        reject(err);
      });
  });
};

exports.updateIsFirst = async (id) => {
  console.log(id);
  try {
    await mongoose.connect(DB_URL, {
      useUnifiedTopology: true,
      useNewUrlParser: true,
    });
    await User.findOneAndUpdate(
      { _id: id },
      {
        $set: {
          isFirst: false,
        },
      }
    );
  } catch (err) {
    mongoose.disconnect();
    throw new Error(error);
  }
};
