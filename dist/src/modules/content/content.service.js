"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ContentService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let ContentService = class ContentService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async getPublicPage(pageKey) {
        const page = await this.prisma.page.findUnique({
            where: { page_key: pageKey },
            include: {
                contents: {
                    where: { is_active: true },
                    orderBy: { sort_order: 'asc' },
                },
            },
        });
        if (!page || !page.is_active) {
            throw new common_1.NotFoundException(`페이지를 찾을 수 없습니다: ${pageKey}`);
        }
        return {
            slug: page.page_key,
            displayName: page.page_name,
            theme: page.theme,
            blocks: page.contents.map((c) => ({
                id: String(c.id),
                type: c.content_type,
                data: c.data,
                order: c.sort_order,
            })),
        };
    }
    async savePage(pageKey, dto) {
        const page = await this.prisma.page.findUnique({
            where: { page_key: pageKey },
        });
        if (!page) {
            throw new common_1.NotFoundException(`페이지를 찾을 수 없습니다: ${pageKey}`);
        }
        await this.prisma.$transaction([
            this.prisma.pageContent.deleteMany({ where: { page_id: page.id } }),
            ...dto.blocks.map((b, index) => this.prisma.pageContent.create({
                data: {
                    page_id: page.id,
                    content_type: b.type,
                    data: b.data,
                    sort_order: index,
                    is_active: b.visible ?? true,
                },
            })),
            this.prisma.page.update({
                where: { id: page.id },
                data: {
                    ...(dto.displayName !== undefined && { page_name: dto.displayName }),
                    ...(dto.theme !== undefined && { theme: dto.theme }),
                },
            }),
        ]);
        return this.getPageBySlug(pageKey);
    }
    async getPages() {
        const pages = await this.prisma.page.findMany({
            where: { is_active: true },
            orderBy: { sort_order: 'asc' },
        });
        return pages.map((p) => ({
            slug: p.page_key,
            displayName: p.page_name,
            theme: p.theme,
        }));
    }
    async getPageBySlug(pageKey) {
        const page = await this.prisma.page.findUnique({
            where: { page_key: pageKey },
            include: {
                contents: { orderBy: { sort_order: 'asc' } },
            },
        });
        if (!page) {
            throw new common_1.NotFoundException(`페이지를 찾을 수 없습니다: ${pageKey}`);
        }
        return {
            slug: page.page_key,
            displayName: page.page_name,
            theme: page.theme,
            blocks: page.contents.map((c) => ({
                id: String(c.id),
                pageSlug: page.page_key,
                type: c.content_type,
                data: c.data,
                order: c.sort_order,
                visible: c.is_active,
                createdAt: c.created_at?.toISOString() ?? '',
                updatedAt: c.updated_at?.toISOString() ?? c.created_at?.toISOString() ?? '',
            })),
        };
    }
    async createBlock(pageKey, dto) {
        const page = await this.prisma.page.findUnique({
            where: { page_key: pageKey },
        });
        if (!page) {
            throw new common_1.NotFoundException(`페이지를 찾을 수 없습니다: ${pageKey}`);
        }
        const maxOrder = await this.prisma.pageContent.aggregate({
            where: { page_id: page.id },
            _max: { sort_order: true },
        });
        const newOrder = (maxOrder._max.sort_order ?? -1) + 1;
        const block = await this.prisma.pageContent.create({
            data: {
                page_id: page.id,
                content_type: dto.type,
                data: dto.data,
                sort_order: newOrder,
                is_active: dto.visible ?? true,
            },
        });
        return {
            id: String(block.id),
            pageSlug: pageKey,
            type: block.content_type,
            data: block.data,
            order: block.sort_order,
            visible: block.is_active,
            createdAt: block.created_at?.toISOString() ?? '',
            updatedAt: block.created_at?.toISOString() ?? '',
        };
    }
    async updateBlock(blockId, dto) {
        const block = await this.ensureBlockExists(blockId);
        const updated = await this.prisma.pageContent.update({
            where: { id: block.id },
            data: {
                ...(dto.data !== undefined && { data: dto.data }),
                ...(dto.visible !== undefined && { is_active: dto.visible }),
            },
        });
        const page = await this.prisma.page.findUnique({
            where: { id: updated.page_id },
        });
        return {
            id: String(updated.id),
            pageSlug: page?.page_key,
            type: updated.content_type,
            data: updated.data,
            order: updated.sort_order,
            visible: updated.is_active,
            createdAt: updated.created_at?.toISOString() ?? '',
            updatedAt: updated.created_at?.toISOString() ?? '',
        };
    }
    async deleteBlock(blockId) {
        const block = await this.ensureBlockExists(blockId);
        await this.prisma.pageContent.delete({
            where: { id: block.id },
        });
        const remaining = await this.prisma.pageContent.findMany({
            where: { page_id: block.page_id },
            orderBy: { sort_order: 'asc' },
        });
        await Promise.all(remaining.map((b, i) => this.prisma.pageContent.update({
            where: { id: b.id },
            data: { sort_order: i },
        })));
        return { success: true };
    }
    async reorderBlocks(pageKey, dto) {
        const page = await this.prisma.page.findUnique({
            where: { page_key: pageKey },
        });
        if (!page) {
            throw new common_1.NotFoundException(`페이지를 찾을 수 없습니다: ${pageKey}`);
        }
        await Promise.all(dto.blockIds.map((id, index) => this.prisma.pageContent.update({
            where: { id: BigInt(id) },
            data: { sort_order: index },
        })));
        return { success: true };
    }
    async toggleVisibility(blockId) {
        const block = await this.ensureBlockExists(blockId);
        const updated = await this.prisma.pageContent.update({
            where: { id: block.id },
            data: { is_active: !block.is_active },
        });
        return {
            id: String(updated.id),
            visible: updated.is_active,
        };
    }
    async ensureBlockExists(blockId) {
        const block = await this.prisma.pageContent.findUnique({
            where: { id: BigInt(blockId) },
        });
        if (!block) {
            throw new common_1.NotFoundException(`블록을 찾을 수 없습니다: ${blockId}`);
        }
        return block;
    }
};
exports.ContentService = ContentService;
exports.ContentService = ContentService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], ContentService);
//# sourceMappingURL=content.service.js.map