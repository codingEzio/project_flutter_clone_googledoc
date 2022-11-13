const express = require('express');
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

    // Return the User info received in the form of JSON
    res.status(200).json({ user: user });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
