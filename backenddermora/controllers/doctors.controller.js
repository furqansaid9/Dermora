const doctorModel = require("../models/doctor.model");
const validationResult = require("express-validator").validationResult;

exports.getAvailableDoctors = (req, res, next) => {
  console.log("getting available doctors");

  doctorModel.getAvailableDoctors().then((result) => {
    res.status(200).send({
      message: "Success",
      data: result,
    });
  });
};
