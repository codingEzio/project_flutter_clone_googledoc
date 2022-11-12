const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
  // MongoDB field (~= column)
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
  profilePic: {
    type: String,
    required: true,
  },
});

// MongoDB collection (~= table)
const User = mongoose.model('User', userSchema);

module.exports = User;
