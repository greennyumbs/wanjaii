const express = require('express');
const { firestore } = require('./firebase-admin'); // Import Firestore instance

const app = express();
const port = 3000; // Customize port number if needed

// Example endpoint to add user data (replace with your data structure)
app.post('/users', async (req, res) => {
  const { email } = req.body;

  try {
    // Create a new user document in Firestore with the provided email
    const userRef = await firestore.collection('users').add({
      email: email,
    });
    res.status(201).json({ message: 'User created successfully', userId: userRef.id });
  } catch (error) {
    console.error('Error adding user:', error);
    res.status(500).json({ message: 'Error adding user' });
  }
});

/* app.get('/user', async (req, res) => {
    try {
      const users = [];
      const snapshot = await firestore.collection('users').get();
  
      snapshot.forEach((doc) => {
        users.push(doc.data());
        console.log(doc.id, '=>', doc.data()); // Log user ID and data
      });
  
      res.send(users);
    } catch (error) {
      console.error(error);
      res.status(500).send({ message: 'Error fetching users' });
    }
}); */

app.get('/users', (req, res) => {
  // Get the signed-in user's UID from the request headers or query params
  const uid = req.headers['uid'] || req.query.uid;

  // Use the Firebase Admin SDK to fetch the user data from Realtime Database or Firestore
  admin.auth().getUser(uid)
   .then((userRecord) => {
      // Return the user data in JSON format
      res.json(userRecord.toJSON());
    })
   .catch((error) => {
      console.error(error);
      res.status(500).json({ error: 'Failed to fetch user data' });
    });
});


app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
