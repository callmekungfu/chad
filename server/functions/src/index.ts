import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as express from 'express';
import * as bodyParser from "body-parser";
import * as cors from 'cors';
import { routerConfig } from './router';

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();

const VERSION = 'v1';
const app = express();
const main = express();

main.use(`/${VERSION}`, app);
main.use(bodyParser.json());
app.use(cors({ origin: true }));
routerConfig(app);


app.get('/ping', (req, res) => {
  res.set('text/plain').status(200).send('pong');
})

app.get('*', (req, res) => {
  res.status(404).json({ isSuccess: false, error: 'The specified URI is unknown for the REST service.' });
});

export const api = functions.https.onRequest(main);
export default db;
