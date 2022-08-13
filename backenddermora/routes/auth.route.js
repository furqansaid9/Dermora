const router = require("express").Router();
const authController = require("../controllers/auth.controller");
const check = require("express-validator").check;
const bodyParser = require("body-parser");

router.post(
  "/signup",
  bodyParser.urlencoded({ extended: true }),
  check("email")
    .not()
    .isEmpty()
    .isEmail()
    .withMessage("Please add a vaild E-mail"),
  check("password")
    .not()
    .isEmpty()
    // .isLength({ min: 6 })
    // .matches(/^(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]/)
    .withMessage(
      "Password length must be at least 6 contain At least one uppercase and lowercase. "
    ),
  // check("confirmPassword")
  //   .not()
  //   .isEmpty()
  //   .withMessage("Please confirm email")
  //   .custom((value, { req }) => {
  //     if (value === req.body.password) return true;
  //     else throw "Passwords are not the same";
  //   }),
  check("firstName").not().isEmpty(),
  check("lastName").not().isEmpty(),

  authController.signUp
); //create the user in the db

router.post(
  "/login",
  bodyParser.urlencoded({ extended: true }),
  check("email")
    .not()
    .isEmpty()
    .withMessage("Please try to enter a valid E-mail"),
  check("password")
    .not()
    .isEmpty()
    .withMessage("Please try to enter a valid password"),

  authController.login
); // just reading and checking if it exists in the db

module.exports = router;
