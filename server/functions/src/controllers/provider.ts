import * as express from 'express';
import * as Providers from '../services/provider';
import * as Services from '../services/services';
import * as ProviderServices from '../services/provider_services';
import { validateJSON } from '../lib/validator';
import { postProviderSchema, putProviderSchema, postProviderServicesSchema } from '../lib/schemas/index';

export async function findAll(req: express.Request, res: express.Response) {
  try {
    const providerResults: any = []
    const findResult = await Providers.findAll();
    findResult.forEach((document: any) => {
      providerResults.push({
        id: document.id,
        data: document.data()
      });
    });
    return res.status(200).json({
      isSuccess: true,
      provider: providerResults,
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
      const providerResult = await Providers.findOne(id);
      if (providerResult.exists) {
        const servicesIdResult: any = await ProviderServices.findOne(id);
        const object = servicesIdResult.data();
        const keys: any[] = Object.keys(object).filter(key => object[key] === true);
        const servicesResult = await Services.findBatch(keys);
        const services: any = [];
        servicesResult.forEach((service: any) => {
          services.push({
            id: service.id,
            data: service.data()
          });
        });
        return res.status(200).json({
          isSuccess: true,
          provider: {
            id: providerResult.id,
            data: providerResult.data(),
            services
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
    if (validateJSON(req.body, postProviderSchema).errors.length > 0) {
      return res.status(400).json({
        isSuccess: false,
        msg: 'invalid body'
      });
    } else {
      const providerInsert = await Providers.insertOne(req.body);
      const providerResult = await providerInsert.get();
      return res.status(201).json({
        isSuccess: true,
        provider: {
          id: providerInsert.id,
          data: providerResult.data()
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
      await Providers.deleteOne(id);
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
      if (validateJSON(req.body, putProviderSchema).errors.length > 0) {
        return res.status(400).json({
          isSuccess: false,
          msg: 'invalid body'
        });
      } else {
        await Providers.updateOne(id, req.body);
        return res.status(200).json({
          isSuccess: true,
          provider: {
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

export async function addService(req: express.Request, res: express.Response) {
  try {
    const providerId = req.params.providerId;
    if (providerId) {
      if (validateJSON(req.body, postProviderServicesSchema).errors.length > 0) {
        return res.status(400).json({
          isSuccess: false,
          msg: 'invalid body'
        });
      } else {
        await ProviderServices.insertOne(providerId, req.body.serviceId);
        return res.status(201).json({
          isSuccess: true,
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

export async function deleteService(req: express.Request, res: express.Response) {
  try {
    const providerId = req.params.providerId;
    const serviceId = req.params.serviceId;
    if (providerId && serviceId) {
      await ProviderServices.deleteOne(providerId, serviceId);
      return res.status(204).json({
        isSuccess: true,
        data: {}
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

export async function findServices(req: express.Request, res: express.Response) {
  try {
    const servicesResults: any = []
    const findResult = await Providers.findAll();
    findResult.forEach((document: any) => {
      servicesResults.push({
        id: document.id,
        data: document.data()
      });
    });
    return res.status(200).json({
      isSuccess: true,
      provider: servicesResults,
    });
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}
