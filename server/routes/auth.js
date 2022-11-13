require('dotenv').config();

const express = require('express');
const jwt = require('jsonwebtoken');
const User = require('../models/user');

const authRouter = express.Router();

// Gets the request (OAuth) data from the Flutter front-end, then
// we start checking if the user has already been saved to MongoDB.
// If it does, we return the JSON. If it doesn't, we save the basic
// information to MongoDB then return the JSON.
authRouter.post('/api/signup', async (req, res) => {
  try {
    // Return from Flutter front-end request
    const { name, email, profilePic } = req.body;

    // Check if it already exists in the MongoDB
    let user = await User.findOne({ email: email });

    if (!user) {
      // Grab the posted data and be ready for saving to MongoDB
      user = new User({
        name: name,
        email: email,
        profilePic: profilePic,
      });

      // Save to the MongoDB on the cloud
      user = await user.save();
    }

    // As long as the program could proceed to this line, it surely
    // already has the OAuth information in hand. So now we need to
    // generate the JWT token for future authentication of our own,
    // which is totally based on the public info got from OAuth plus
    // a token generated from the process. The most common methods
    // would be used would be .sign() (think of it as attaching our
    // own data like the user id then plus a secret key to generate
    // the token) and .verify() (to ensure it is indeed a JWT token
    // that could identify a person like an user).
    const token = jwt.sign({ id: user._id }, process.env.AUTH_JWT_SECRET_KEY);

    // Return the User info received in the form of JSON
    res.status(200).json({ user: user, token: token });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
