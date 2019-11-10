import * as express from 'express';
import * as Users from '../services/user';
import { validateJSON } from '../lib/validator';
import { postUserSchema } from '../lib/schemas/index';
import { User } from '../models/user';

export async function insertOne(req: express.Request, res: express.Response) {
  try {
    if (validateJSON(req.body, postUserSchema).errors.length > 0) {
      return res.status(400).json({
        isSuccess: false,
        msg: 'invalid body'
      });
    } else {
      const { userName, password, firstName, lastName, role } = req.body;
      const user: User = {
        userName,
        password,
        firstName,
        lastName,
        role,
      }
      const userFind = await Users.findOne(user.userName);
      if (userFind.exists) {
        return res.status(409).json({
          isSuccess: false,
          msg: 'user already exists'
        });
      }
      await Users.insertOne(user);
      return res.status(201).json({
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
