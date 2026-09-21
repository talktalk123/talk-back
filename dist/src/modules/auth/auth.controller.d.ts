import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import type { Request } from 'express';
export declare class AuthController {
    private readonly authService;
    constructor(authService: AuthService);
    login(dto: LoginDto): Promise<{
        accessToken: string;
        admin: {
            id: number;
            loginId: string;
            name: string;
            role: string | null;
        };
    }>;
    me(req: Request): Promise<{
        id: number;
        loginId: string;
        name: string;
        role: string | null;
    } | null>;
}
