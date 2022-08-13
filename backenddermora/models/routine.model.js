const mongoose = require("mongoose");
const dbConfig = require("../config2");
const DB_URL = dbConfig.db;
const bcrypt = require("bcrypt");
const auth = require("../helpers/auth");

const routineSchema = mongoose.Schema(
  {
    user: { type: mongoose.Schema.Types.ObjectId, ref: "user" },

    morningRoutine: {
      time: String,
      products: {
        type: [{ image: String, label: String, kind: String }],
        default: [],
      },
    },
    nightRoutine: {
      time: String,
      products: {
        type: [{ image: String, label: String, kind: String }],
        default: [],
      },
    },
  },
  { minimize: false }
);

const Routine = mongoose.model("routine", routineSchema);
exports.Routine = Routine;

exports.getRoutine = (userId) => {
  return new Promise((resolve, reject) => {
    mongoose
      .connect(DB_URL, {
        useUnifiedTopology: true,
        useNewUrlParser: true,
      })
      .then(() => {
        let routine = Routine.findOne({ user: userId });
        return routine;
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

exports.addProductToRoutine = async (data, time, userId) => {
  try {
    await mongoose.connect(DB_URL, {
      useUnifiedTopology: true,
      useNewUrlParser: true,
    });
    if (time == "morning") {
      await Routine.findOneAndUpdate(
        { user: userId },
        {
          $set: {
            "morningRoutine.products": data,
          },
        }
      );
    } else if (time == "night") {
      console.log(data);
      await Routine.findOneAndUpdate(
        { user: userId },
        {
          $set: {
            "nightRoutine.products": data,
          },
        }
      );
    }
  } catch (error) {
    mongoose.disconnect();
    throw new Error(error);
  }
};
