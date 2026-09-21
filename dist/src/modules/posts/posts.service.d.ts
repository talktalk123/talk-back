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
export declare class PostsService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    list(filters?: ListFilters): Promise<AiPostDto[]>;
    getBySlug(slug: string, publishedOnly?: boolean): Promise<AiPostDto>;
    create(dto: CreatePostDto, authorId?: number): Promise<AiPostDto>;
    update(slug: string, dto: UpdatePostDto): Promise<AiPostDto>;
    delete(slug: string): Promise<{
        success: true;
    }>;
    private toDto;
    private handlePrismaError;
}
export {};
