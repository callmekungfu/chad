import * as express from 'express';
import * as admin from 'firebase-admin';
import * as Users from '../services/user';
import * as bcrypt from 'bcrypt';
import { validateJSON } from '../lib/validator';
import { passwordLoginSchema } from '../lib/schemas/index';
import { Login } from '../models/login';
import { User } from '../models/user';

export async function login(req: express.Request, res: express.Response) {
  try {
    if (validateJSON(req.body, passwordLoginSchema).errors.length > 0) {
      return res.status(400).json({
        isSuccess: false,
        msg: 'invalid body'
      });
    } else {
      const { userName, password } = req.body;
      const loginInfo: Login = {
        userName,
        password,
      }
      const userFind = await Users.findOne(loginInfo.userName);
      if (!userFind.exists) {
        return res.status(204).json({
          isSuccess: false,
          msg: 'user does not exist'
        });
      }

      const user: User = userFind.data() as any;

      if (!bcrypt.compareSync(password, user.password)) {
        return res.status(401).json({
          status: 'failed',
          message: 'invalid credentials'
        });
      };

      const { firstName, lastName, role } = user;

      return res.status(200).json({
        isSuccess: true,
        user: {
          userName,
          firstName,
          lastName,
          role,
        }
      });
    }
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function isAuthenticated(req: express.Request, res: express.Response, next: Function) {
  const { authorization } = req.headers

  if (!authorization)
    return unauthenticatedResponse(res);

  if (!authorization.startsWith('Bearer'))
    return unauthenticatedResponse(res);

  const split = authorization.split('Bearer ')
  if (split.length !== 2)
    return unauthenticatedResponse(res);

  const token = split[1]

  try {
    const decodedToken: admin.auth.DecodedIdToken = await admin.auth().verifyIdToken(token);
    console.log("decodedToken", JSON.stringify(decodedToken))
    res.locals = { ...res.locals, uid: decodedToken.uid, role: decodedToken.role, email: decodedToken.email }
    return next();
  }
  catch (err) {
    console.error(`${err.code} -  ${err.message}`)
    return unauthenticatedResponse(res);
  }
}

function unauthenticatedResponse(res: express.Response) {
  return res.status(401).json({
    isSuccess: false,
    msg: 'UNAUTHORIZED'
  });
}
