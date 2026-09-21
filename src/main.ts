import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { ExpressAdapter } from '@nestjs/platform-express';
import express, { type Express, type Request, type Response } from 'express';
import { AppModule } from './app.module';

// BigInt JSON 직렬화 지원
(BigInt.prototype as unknown as { toJSON: () => number }).toJSON = function () {
  return Number(this as unknown as bigint);
};

const expressApp: Express = express();
let initialized = false;

async function bootstrap(): Promise<void> {
  if (initialized) return;

  const app = await NestFactory.create(AppModule, new ExpressAdapter(expressApp));

  app.enableCors({
    origin: process.env.CORS_ORIGIN?.split(',') || [
      'http://localhost:3000',
      'http://localhost:3001',
    ],
    credentials: true,
  });

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
    }),
  );

  app.setGlobalPrefix('api');
  await app.init();

  initialized = true;
}

// Vercel serverless handler
export default async function handler(
  req: Request,
  res: Response,
): Promise<void> {
  await bootstrap();
  return expressApp(req, res);
}

// Local development server (run via `npm run start` or `npm run start:dev`)
if (!process.env.VERCEL) {
  bootstrap()
    .then(() => {
      const port = process.env.PORT ?? 4000;
      expressApp.listen(port, () => {
        console.log(`🚀 Server listening on http://localhost:${port}`);
      });
    })
    .catch((err) => {
      console.error('❌ Bootstrap failed:', err);
      process.exit(1);
    });
}
