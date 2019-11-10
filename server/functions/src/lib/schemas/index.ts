import * as User from './user';
import * as Login from './login';
import * as Service from './service';

export const postUserSchema = User.post;
export const passwordLoginSchema = Login.withPassword;
export const postServiceSchema = Service.post;
export const putServiceSchema = Service.put;
