import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as bcrypt from 'bcryptjs';
import { validateJSON } from '../lib/validator';
import { NewUserSchema } from '../schemas';

/**
 * ## Create New User Function
 * 
 * This function handles creating new users and inserting
 * it into the firebase database.
 * 
 */
export const createNewUser = functions.https.onRequest(async (req, res) => {

  // Schema Validation
  if (validateJSON(NewUserSchema, req.body).errors.length > 0) {
    res.status(400).json({
      status: 'failed',
      message: 'Request Body Contains Errors'
    });
    return;
  }

  // Init database connection and destructure request body
  const db = admin.firestore();
  const {
    userName,
    first_name,
    last_name,
    role,
    password,
  } = req.body;

  // Check if user already exist
  try {
    const userSnap = await db.collection('users').where('userName', '==', userName).get();
    if (!userSnap.empty) {
      res.status(403).json({
        status: 'failed',
        message: 'User already exists'
      });
      return
    }
  } catch (e) {
    res.status(500).json({
      status: 'failed',
      message: 'system failure'
    });
    return;
  }

  // Salt password then push to database
  try {
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(password, salt);
    await db.collection('users').doc().set({
      userName,
      first_name,
      last_name,
      role,
      password: hash,
    });
    res.json({
      status: 'done',
      message: 'New User Created',
      stored: {
        userName,
        first_name,
        last_name,
      }
    });
  } catch (e) {
    res.status(500).json({
      status: 'failed',
      message: 'Error Storing Password'
    });
    return;
  }
  return;
});