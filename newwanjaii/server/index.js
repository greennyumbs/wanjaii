const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors'); // Enable CORS for requests from Flutter app
const admin = require('firebase-admin');
const firebase = require('firebase');

const credentials = require("./wanjaii-firebase-adminsdk-whf62-2a6d29923e.json")

admin.initializeApp({
  credential: admin.credential.cert(credentials),
  databaseURL: 'https://wanjaii.firebaseio.com'
});

const auth = admin.auth();

const app = express();
const port = process.env.PORT || 3000;

app.use(cors()); // Allow CORS for all origins
app.use(bodyParser.json()); // Parse incoming JSON data

app.post('/login', async (req, res) => {
    const { email, password } = req.body;
    try {
      const userRecord = await auth.getUserByEmail(email);
      // You'll need to verify the password manually using a password hashing library
      res.json({ message: 'Login successful!', user: userRecord }); // Send success response
    } catch (error) {
      console.error(error);
      res.status(401).json({ message: 'Invalid email or password' }); // Send error response
    }
});
  
app.post('/register', async (req, res) => {
    const { email, password } = req.body;
  
    try {
      const userRecord = await auth.createUser(email, password);
      res.json({ message: 'Registration successful!', user: userRecord }); // Send success response
    } catch (error) {
      console.error(error);
      let errorMessage = 'Registration failed';
      if (error.code === 'auth/weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (error.code === 'auth/email-already-exists') {
        errorMessage = 'The account already exists for that email.';
      }
      res.status(400).json({ message: errorMessage }); // Send error response with specific message
    }
});
  
app.listen(port, () => console.log(`Server listening on port ${port}`));  
 

// const express = require("express");
// const app = express();
// // const bcrypt = require('bcrypt');

// const admin = require("firebase-admin"); 
// const auth = require("firebase/auth");

// const credentials = require("./wanjaii-firebase-adminsdk-whf62-2a6d29923e.json")


// app.use(express.json());

// admin.initializeApp({
//     databaseURL: 'https://wanjaii.firebaseio.com', // Replace with your project ID
//     credential: admin.credential.cert(credentials)
// });

// app.post('/register', async (req, res) => {
//   const { email, password } = req.body;

//   // (Optional) Validate user data on the backend (e.g., email format, password strength)

//   try {
//     // (If using Firebase Admin SDK)
//     const userRecord = await admin.auth().createUser({
//       email: email,
//       password: password,
//   });

//     // (Optional) Store additional user data in Firestore or your preferred database

//     res.json({ message: 'User registration successful', userRecord });
//   } catch (error) {
//     console.error(error);
//     res.status(500).json({ message: 'Registration failed' });
//   }
// });

// // Define the login route
// app.post('/login', async (req, res) => {
//   const { email, password } = req.body;

//   try {
//     auth.signInWithEmailAndPassword(email, password)
//       .then(userCredential  =>  {
//         // User is authenticated
//         const  user = userCredential.user;
//         console.log(`User  ${user.email}  is authenticated`);
//       })
//       .catch(error  =>  {
//         // Authentication failed
//         console.error(error);
//         console.error('Authentication failed:', error);
//       });
//   } catch (error) {
//     console.error(error);
//     res.status(401).json({ message: 'Authentication failed' });
//   }
// });


// const PORT = process.env.PORT || 3000;

// app.listen(PORT, "0.0.0.0",()=>{
//     console.log(`Connected at port ${PORT}`)
// })

// module.exports = admin;