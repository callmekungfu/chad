import * as express from 'express';
import * as Services from '../services/services';
import { Service } from '../models/service';
import { validateJSON } from '../lib/validator';
import { postServiceSchema, putServiceSchema } from '../lib/schemas/index';

export async function findAll(req: express.Request, res: express.Response) {
  try {
    const serviceResults: any = []
    const findResult = await Services.findAll();
    findResult.forEach((document: any) => {
      serviceResults.push({
        id: document.id,
        data: document.data()
      });
    });
    return res.status(200).json({
      isSuccess: true,
      service: serviceResults,
    });
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function findOne(req: express.Request, res: express.Response) {
  try {
    const id = req.params.id;
    if (id) {
      const serviceResult = await Services.findOne(id);
      if (serviceResult.exists) {
        return res.status(200).json({
          isSuccess: true,
          service: {
            id: serviceResult.id,
            data: serviceResult.data()
          }
        });
      } else {
        return res.status(204).json({
          isSuccess: true,
          data: {}
        });
      }
    } else {
      return res.status(400).json({
        isSuccess: false,
      });
    }
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function insertOne(req: express.Request, res: express.Response) {
  try {
    if (validateJSON(req.body, postServiceSchema).errors.length > 0) {
      return res.status(400).json({
        isSuccess: false,
        msg: 'invalid body'
      });
    } else {
      const { name, role, price } = req.body;
      const service: Service = {
        name,
        role,
        price
      }
      const serviceInsert = await Services.insertOne(service);
      const serviceResult = await serviceInsert.get();
      return res.status(201).json({
        isSuccess: true,
        service: {
          id: serviceInsert.id,
          data: serviceResult.data()
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

export async function deleteOne(req: express.Request, res: express.Response) {
  try {
    const id = req.params.id;
    if (id) {
      await Services.deleteOne(id);
      return res.status(204).json({
        isSuccess: true,
        service: {}
      });
    } else {
      return res.status(400).json({
        isSuccess: false,
      });
    }
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function updateOne(req: express.Request, res: express.Response) {
  try {
    const id = req.params.id;
    if (id) {
      if (validateJSON(req.body, putServiceSchema).errors.length > 0) {
        return res.status(400).json({
          isSuccess: false,
          msg: 'invalid body'
        });
      } else {
        await Services.updateOne(id, req.body);
        return res.status(200).json({
          isSuccess: true,
          service: {
            id,
            service: req.body
          }
        });
      }
    } else {
      return res.status(400).json({
        isSuccess: false,
      });
    }
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}
