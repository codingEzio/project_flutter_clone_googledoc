const express = require('express');
const User = require('../models/user');

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
  try {
    const { name, email, profilePic } = req.body;

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
