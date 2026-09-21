import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../prisma/prisma.service';
import { LoginDto } from './dto/login.dto';
export declare class AuthService {
    private readonly prisma;
    private readonly jwtService;
    constructor(prisma: PrismaService, jwtService: JwtService);
    login(dto: LoginDto): Promise<{
        accessToken: string;
        admin: {
            id: number;
            loginId: string;
            name: string;
            role: string | null;
        };
    }>;
    validateToken(payload: {
        sub: number;
    }): Promise<{
        id: number;
        loginId: string;
        name: string;
        role: string | null;
    } | null>;
}
