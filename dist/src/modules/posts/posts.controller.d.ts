import type { Request } from 'express';
import { PostsService } from './posts.service';
import { CreatePostDto } from './dto/create-post.dto';
import { UpdatePostDto } from './dto/update-post.dto';
export declare class PostsController {
    private readonly postsService;
    constructor(postsService: PostsService);
    list(category?: string): Promise<import("./posts.service").AiPostDto[]>;
    listAll(category?: string): Promise<import("./posts.service").AiPostDto[]>;
    get(slug: string): Promise<import("./posts.service").AiPostDto>;
    create(dto: CreatePostDto, req: Request): Promise<import("./posts.service").AiPostDto>;
    update(slug: string, dto: UpdatePostDto): Promise<import("./posts.service").AiPostDto>;
    delete(slug: string): Promise<{
        success: true;
    }>;
}
