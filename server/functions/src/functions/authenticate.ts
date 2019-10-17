import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as bcrypt from 'bcryptjs';
import { validateJSON } from '../lib/validator';
import { LoginWithPasswordSchema } from '../schemas';

// Interface for user details
interface UserI {
  userName: string;
  password: string;
  first_name: string;
  last_name: string;
  role: string;
}

/**
 * Authenticate With Password
 * 
 * This function handles authenticating user using password
 */

export const authenticateWithPassword = functions.https.onRequest(async (req, res) => {

  // Schema Validation
  if (validateJSON(LoginWithPasswordSchema, req.body).errors.length > 0) {
    res.status(400).json({
      status: 'failed',
      message: 'Request Body Contains Errors'
    });
    return;
  }

  // DB init & request body destructuring
  const db = admin.firestore();
  const { userName, password } = req.body;

  // Find the user by email
  const userStream = await db.collection('users').where('userName', '==', userName).get();

  // If empty return 403 to user
  if (userStream.empty) {
    console.log('Failed to locate user');
    res.status(403).json({
      status: 'failed',
      message: 'User does not Exist'
    });
    return;
  }

  // get user data
  const user: UserI = userStream.docs[0].data() as any;

  // Check login
  if (!bcrypt.compareSync(password, user.password)) {
    console.log('Failed to authenticate user');
    res.status(403).json({
      status: 'failed',
      message: 'Email Password Does Not Match'
    });
    return;
  };

  // Return final result
  res.status(200).json({
    userName: user.userName,
    first_name: user.first_name,
    last_name: user.last_name,
    role: user.role
  });
});
