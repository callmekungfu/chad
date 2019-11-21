
/*import db from '../index';
import { Provider } from '../models/provider';

const COLLECTION = 'provider';
const RELATIONSHIP = 'user_providers';

export function findAll() {
  return db.collection(COLLECTION).get();
};

export function findOne(id: string) {
  return db.collection(COLLECTION).doc(id).get();
}

export async function insertOne(provider: Provider) {
  const providerResult = await db.collection(COLLECTION).add(provider);
  const update: { [id: string]: any; } = {};
  update[providerResult.id] = true
  await db.collection(RELATIONSHIP).doc(provider.email).set(update, { merge: true });
  return providerResult;
}

export async function deleteOne(id: string) {
  const providerResult = await db.collection(COLLECTION).doc(id).get();
  const provider: any = providerResult.data();
  const update: { [id: string]: any; } = {};
  update[id] = null;
  await db.collection(RELATIONSHIP).doc(provider.email).set(update, { merge: true });
  return db.collection(COLLECTION).doc(id).delete();
}

export function updateOne(id: string, data: any) {
  return db.collection(COLLECTION).doc(id).set(data, { merge: true });
}

*/

import db from '../index';
import { Provider } from '../models/provider';

const PROVIDERS = 'providers';
const USERS = 'users';

export function findAll() {
  return db.collection(PROVIDERS).get();
};

export function findOne(id: string) {
  return db.collection(PROVIDERS).doc(id).get();
}

export async function insertOne(provider: Provider) {
  const providerResult = await db.collection(PROVIDERS).add(provider);
  await db.collection(USERS).doc(provider.email).set({
    provider: providerResult.id
  }, { merge: true });
  return providerResult;
}

export async function deleteOne(id: string) {
  const providerResult = await db.collection(PROVIDERS).doc(id).get();
  const provider: any = providerResult.data();
  await db.collection(USERS).doc(provider.email).set({
    provider: null
  }, { merge: true });
  return db.collection(PROVIDERS).doc(id).delete();
}

export function updateOne(id: string, data: any) {
  return db.collection(PROVIDERS).doc(id).set(data, { merge: true });
}
