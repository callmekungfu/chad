import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as bcrypt from 'bcryptjs';
import { validateJSON } from '../lib/validator';
import { LoginWithPasswordSchema } from '../schemas';

interface UserI {
  email: string;
  password: string;
  first_name: string;
  last_name: string;
  role: string;
}

export const authenticateWithPassword = functions.https.onRequest(async (req, res) => {

  // Schema Validation
  if (validateJSON(LoginWithPasswordSchema, req.body).errors.length > 0) {
    res.status(400).json({
      status: 'failed',
      message: 'Request Body Contains Errors'
    });
    return;
  }

  const db = admin.firestore();

  const { email, password } = req.body;

  const userStream = await db.collection('users').where('email', '==', email).get();

  if (userStream.empty) {
    console.log('Failed to locate user');
    res.status(403).json({
      status: 'failed',
      message: 'User does not Exist'
    });
    return;
  }

  const user: UserI = userStream.docs[0].data() as any;

  if (!bcrypt.compareSync(password, user.password)) {
    console.log('Failed to authenticate user');
    res.status(403).json({
      status: 'failed',
      message: 'Email Password Does Not Match'
    });
    return;
  };

  res.status(200).json({
    email: user.email,
    first_name: user.first_name,
    last_name: user.last_name,
    role: user.role
  });
  return;
});
