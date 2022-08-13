const router = require("express").Router();
const doctorController = require("../controllers/doctors.controller");
const bodyParser = require("body-parser");

router.get("/availableDoctors", doctorController.getAvailableDoctors);

module.exports = router;
