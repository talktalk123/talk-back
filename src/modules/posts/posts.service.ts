import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Post, Prisma } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { CreatePostDto } from './dto/create-post.dto';
import { UpdatePostDto } from './dto/update-post.dto';

interface ListFilters {
  category?: string;
  publishedOnly?: boolean;
}

export interface AiPostDto {
  id: string;
  slug: string;
  title: string;
  summary: string | null;
  content: string;
  category: string;
  tags: string[];
  language: string;
  isPublished: boolean;
  metadata: unknown;
  publishedAt: string;
  createdAt: string;
  updatedAt: string;
  authorId: number | null;
}

@Injectable()
export class PostsService {
  constructor(private readonly prisma: PrismaService) {}

  async list(filters: ListFilters = {}): Promise<AiPostDto[]> {
    const posts = await this.prisma.post.findMany({
      where: {
        ...(filters.category && { category: filters.category }),
        ...(filters.publishedOnly && { is_published: true }),
      },
      orderBy: { published_at: 'desc' },
    });
    return posts.map((p) => this.toDto(p));
  }

  async getBySlug(slug: string, publishedOnly = false): Promise<AiPostDto> {
    const post = await this.prisma.post.findUnique({ where: { slug } });
    if (!post) {
      throw new NotFoundException(`글을 찾을 수 없습니다: ${slug}`);
    }
    if (publishedOnly && !post.is_published) {
      throw new NotFoundException(`글을 찾을 수 없습니다: ${slug}`);
    }
    return this.toDto(post);
  }

  async create(dto: CreatePostDto, authorId?: number): Promise<AiPostDto> {
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
          metadata: (dto.metadata ?? {}) as Prisma.InputJsonValue,
          ...(dto.publishedAt && { published_at: new Date(dto.publishedAt) }),
          ...(authorId && { author_id: BigInt(authorId) }),
        },
      });
      return this.toDto(post);
    } catch (e) {
      this.handlePrismaError(e, dto.slug);
      throw e;
    }
  }

  async update(slug: string, dto: UpdatePostDto): Promise<AiPostDto> {
    const existing = await this.prisma.post.findUnique({ where: { slug } });
    if (!existing) {
      throw new NotFoundException(`글을 찾을 수 없습니다: ${slug}`);
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
            metadata: dto.metadata as Prisma.InputJsonValue,
          }),
          ...(dto.publishedAt !== undefined && {
            published_at: new Date(dto.publishedAt),
          }),
        },
      });
      return this.toDto(post);
    } catch (e) {
      this.handlePrismaError(e, dto.slug ?? slug);
      throw e;
    }
  }

  async delete(slug: string): Promise<{ success: true }> {
    try {
      await this.prisma.post.delete({ where: { slug } });
      return { success: true };
    } catch (e: unknown) {
      const code = (e as { code?: string }).code;
      if (code === 'P2025') {
        throw new NotFoundException(`글을 찾을 수 없습니다: ${slug}`);
      }
      throw e;
    }
  }

  private toDto(post: Post): AiPostDto {
    const dateOnly = (d: Date | null | undefined) =>
      d ? d.toISOString().slice(0, 10) : '';
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

  private handlePrismaError(e: unknown, slug?: string): never | void {
    const err = e as { code?: string; meta?: { target?: string[] } };
    if (err.code === 'P2002') {
      throw new ConflictException(
        `이미 사용 중인 slug입니다: ${slug ?? '(unknown)'}`,
      );
    }
    if (err.code === 'P2025') {
      throw new NotFoundException(`글을 찾을 수 없습니다: ${slug ?? '(unknown)'}`);
    }
  }
}
