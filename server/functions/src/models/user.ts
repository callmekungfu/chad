import { Role } from './role';

export interface User {
  userName: string;
  password: string;
  firstName: string;
  lastName: string;
  role: Role;
  provider?: string;
}
