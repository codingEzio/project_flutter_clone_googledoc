require('dotenv').config();

const jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {
  try {
    const jwtToken = req.header('auth-token-jwt');

    // Did not find JWT token in the server's HTTP response
    if (!jwtToken) {
      return res.status(401).json({ msg: 'No auth token, access denied.' });
    }

    // Is this the token that is generated with our user ID and secret?
    const verified = jwt.verify(jwtToken, process.env.AUTH_JWT_SECRET_KEY);

    // It is indeed a token. Though it might not be a valid JWT token or
    // a token that is generated with non-userID and wrong secrect key.
    if (!verified) {
      return res.status(401).json({ msg: 'Token verification failed.' });
    }

    // Got token from HTTP response and its validity can be ensured
    req.user = verified.id;
    req.token = token;

    // Move forward to the next middleware (or the end)
    next();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

module.exports = auth;
