import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcryptjs';
import { PrismaService } from '../prisma/prisma.service';
import { LoginDto } from './dto/login.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
  ) {}

  async login(dto: LoginDto) {
    const admin = await this.prisma.admin.findUnique({
      where: { login_id: dto.loginId },
    });

    if (!admin || !admin.is_active) {
      throw new UnauthorizedException(
        '아이디 또는 비밀번호가 올바르지 않습니다.',
      );
    }

    const isPasswordValid = await bcrypt.compare(
      dto.password,
      admin.password_hash,
    );
    if (!isPasswordValid) {
      throw new UnauthorizedException(
        '아이디 또는 비밀번호가 올바르지 않습니다.',
      );
    }

    await this.prisma.admin.update({
      where: { id: admin.id },
      data: { last_login_at: new Date() },
    });

    const payload = {
      sub: Number(admin.id),
      loginId: admin.login_id,
      name: admin.name,
      role: admin.role,
    };

    return {
      accessToken: this.jwtService.sign(payload),
      admin: {
        id: Number(admin.id),
        loginId: admin.login_id,
        name: admin.name,
        role: admin.role,
      },
    };
  }

  async validateToken(payload: { sub: number }) {
    const admin = await this.prisma.admin.findUnique({
      where: { id: payload.sub },
    });
    if (!admin || !admin.is_active) return null;
    return {
      id: Number(admin.id),
      loginId: admin.login_id,
      name: admin.name,
      role: admin.role,
    };
  }
}
