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

export function initOne(id: string) {
  const data = {
    sunday: 'closed',
    monday: 'closed',
    tuesday: 'closed',
    wednesday: 'closed',
    thursday: 'closed',
    friday: 'closed',
    saturday: 'closed',
  }
  return db.collection(PROVIDERS).doc(id).set(data, { merge: true});
}
