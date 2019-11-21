import * as User from './user';
import * as Login from './login';
import * as Service from './service';
import * as Provider from './provider';
import * as ProviderServices from './providerServices';

export const postUserSchema = User.post;
export const passwordLoginSchema = Login.withPassword;
export const postServiceSchema = Service.post;
export const putServiceSchema = Service.put;
export const postProviderSchema = Provider.post;
export const putProviderSchema = Provider.put;
export const postProviderServicesSchema = ProviderServices.post;
