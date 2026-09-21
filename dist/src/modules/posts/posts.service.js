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
exports.PostsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let PostsService = class PostsService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async list(filters = {}) {
        const posts = await this.prisma.post.findMany({
            where: {
                ...(filters.category && { category: filters.category }),
                ...(filters.publishedOnly && { is_published: true }),
            },
            orderBy: { published_at: 'desc' },
        });
        return posts.map((p) => this.toDto(p));
    }
    async getBySlug(slug, publishedOnly = false) {
        const post = await this.prisma.post.findUnique({ where: { slug } });
        if (!post) {
            throw new common_1.NotFoundException(`글을 찾을 수 없습니다: ${slug}`);
        }
        if (publishedOnly && !post.is_published) {
            throw new common_1.NotFoundException(`글을 찾을 수 없습니다: ${slug}`);
        }
        return this.toDto(post);
    }
    async create(dto, authorId) {
        try {
            const post = await this.prisma.post.create({
                data: {
                    slug: dto.slug,
                    title: dto.title,
                    summary: dto.summary ?? null,
                    content: dto.content,
                    category: dto.category,
                    tags: dto.tags ?? [],
                    language: dto.language ?? 'ko-KR',
                    is_published: dto.isPublished ?? true,
                    metadata: (dto.metadata ?? {}),
                    ...(dto.publishedAt && { published_at: new Date(dto.publishedAt) }),
                    ...(authorId && { author_id: BigInt(authorId) }),
                },
            });
            return this.toDto(post);
        }
        catch (e) {
            this.handlePrismaError(e, dto.slug);
            throw e;
        }
    }
    async update(slug, dto) {
        const existing = await this.prisma.post.findUnique({ where: { slug } });
        if (!existing) {
            throw new common_1.NotFoundException(`글을 찾을 수 없습니다: ${slug}`);
        }
        try {
            const post = await this.prisma.post.update({
                where: { slug },
                data: {
                    ...(dto.slug !== undefined && { slug: dto.slug }),
                    ...(dto.title !== undefined && { title: dto.title }),
                    ...(dto.summary !== undefined && { summary: dto.summary }),
                    ...(dto.content !== undefined && { content: dto.content }),
                    ...(dto.category !== undefined && { category: dto.category }),
                    ...(dto.tags !== undefined && { tags: dto.tags }),
                    ...(dto.language !== undefined && { language: dto.language }),
                    ...(dto.isPublished !== undefined && { is_published: dto.isPublished }),
                    ...(dto.metadata !== undefined && {
                        metadata: dto.metadata,
                    }),
                    ...(dto.publishedAt !== undefined && {
                        published_at: new Date(dto.publishedAt),
                    }),
                },
            });
            return this.toDto(post);
        }
        catch (e) {
            this.handlePrismaError(e, dto.slug ?? slug);
            throw e;
        }
    }
    async delete(slug) {
        try {
            await this.prisma.post.delete({ where: { slug } });
            return { success: true };
        }
        catch (e) {
            const code = e.code;
            if (code === 'P2025') {
                throw new common_1.NotFoundException(`글을 찾을 수 없습니다: ${slug}`);
            }
            throw e;
        }
    }
    toDto(post) {
        const dateOnly = (d) => d ? d.toISOString().slice(0, 10) : '';
        return {
            id: String(post.id),
            slug: post.slug,
            title: post.title,
            summary: post.summary,
            content: post.content,
            category: post.category,
            tags: post.tags,
            language: post.language,
            isPublished: post.is_published,
            metadata: post.metadata,
            publishedAt: dateOnly(post.published_at),
            createdAt: dateOnly(post.created_at),
            updatedAt: dateOnly(post.updated_at),
            authorId: post.author_id ? Number(post.author_id) : null,
        };
    }
    handlePrismaError(e, slug) {
        const err = e;
        if (err.code === 'P2002') {
            throw new common_1.ConflictException(`이미 사용 중인 slug입니다: ${slug ?? '(unknown)'}`);
        }
        if (err.code === 'P2025') {
            throw new common_1.NotFoundException(`글을 찾을 수 없습니다: ${slug ?? '(unknown)'}`);
        }
    }
};
exports.PostsService = PostsService;
exports.PostsService = PostsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], PostsService);
//# sourceMappingURL=posts.service.js.map