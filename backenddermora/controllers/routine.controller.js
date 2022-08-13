const routineModel = require("../models/routine.model");

exports.getRoutine = (req, res, next) => {
  console.log(req.params.id);
  let userId = req.params.id;

  routineModel.getRoutine(userId).then((result) => {
    res.status(200).send({
      message: "Success",
      data: result,
    });
  });
};

exports.addProduct = (req, res, next) => {
  console.log("add product");
  let time = req.body.time;
  let data = req.body.data;
  let userId = req.body.userId;
  routineModel.addProductToRoutine(data, time, userId).then(() => {
    res.status(200).send({
      message: "Success",
    });
  });
};
