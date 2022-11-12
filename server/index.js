require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');

const PORT = process.env.PORT | 3001;

const app = express();

app.use(express.json());
app.use(authRouter);

const db = `mongodb+srv://app-flutter-googledoc-clone:${process.env.DB_MONGODB_PASSWORD}@cluster0.bnb6949.mongodb.net/?retryWrites=true&w=majority`;

mongoose
  .connect(db)
  .then(() => {
    console.log('Connected to MongoDB on the cloud');
  })
  .catch(err => {
    console.warn(err);
  });

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Connected at port ${PORT}`);
});
