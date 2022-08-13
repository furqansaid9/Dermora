const router = require("express").Router();
const routineController = require("../controllers/routine.controller");
const bodyParser = require("body-parser");

router.get("/routine/:id", routineController.getRoutine);

router.post(
  "/addProduct",
  bodyParser.urlencoded({ extended: true }),
  routineController.addProduct
);

module.exports = router;
