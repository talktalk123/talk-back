export declare class CreatePostDto {
    slug: string;
    title: string;
    summary?: string;
    content: string;
    category: string;
    tags?: string[];
    language?: string;
    isPublished?: boolean;
    metadata?: Record<string, unknown>;
    publishedAt?: string;
}
