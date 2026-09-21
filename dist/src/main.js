"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = handler;
const core_1 = require("@nestjs/core");
const common_1 = require("@nestjs/common");
const platform_express_1 = require("@nestjs/platform-express");
const express_1 = __importDefault(require("express"));
const app_module_1 = require("./app.module");
BigInt.prototype.toJSON = function () {
    return Number(this);
};
const expressApp = (0, express_1.default)();
let initialized = false;
async function bootstrap() {
    if (initialized)
        return;
    const app = await core_1.NestFactory.create(app_module_1.AppModule, new platform_express_1.ExpressAdapter(expressApp));
    app.enableCors({
        origin: process.env.CORS_ORIGIN?.split(',') || [
            'http://localhost:3000',
            'http://localhost:3001',
        ],
        credentials: true,
    });
    app.useGlobalPipes(new common_1.ValidationPipe({
        whitelist: true,
        forbidNonWhitelisted: true,
        transform: true,
    }));
    app.setGlobalPrefix('api');
    await app.init();
    initialized = true;
}
async function handler(req, res) {
    await bootstrap();
    return expressApp(req, res);
}
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
//# sourceMappingURL=main.js.map