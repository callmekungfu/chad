import { Request, Response } from "express";
import { Role } from '../models/role';

export function isAuthorized(opts: { hasRole: Array<Role>, allowSameUser?: boolean }) {
  return (req: Request, res: Response, next: Function) => {
    const { role, uid } = res.locals
    const { id } = req.params

    if (opts.allowSameUser && id && uid === id)
      return next();

    if (!role)
      return unauthorizedResponse(res);

    if (opts.hasRole.includes(role))
      return next();

    return unauthorizedResponse(res);
  }
}

function unauthorizedResponse(res: Response) {
  return res.status(403).json({
    isSuccess: false,
    msg: 'INSUFFICIENT PERMISSIONS'
  });
}
