import { ContentService } from './content.service';
import { CreateBlockDto } from './dto/create-block.dto';
import { UpdateBlockDto } from './dto/update-block.dto';
import { ReorderBlocksDto } from './dto/reorder-blocks.dto';
import { SavePageDto } from './dto/save-page.dto';
export declare class ContentController {
    private readonly contentService;
    constructor(contentService: ContentService);
    getPublicPage(slug: string): Promise<{
        slug: string;
        displayName: string;
        theme: import("@prisma/client/runtime/client").JsonValue;
        blocks: {
            id: string;
            type: string;
            data: import("@prisma/client/runtime/client").JsonValue;
            order: number | null;
        }[];
    }>;
    getPages(): Promise<{
        slug: string;
        displayName: string;
        theme: import("@prisma/client/runtime/client").JsonValue;
    }[]>;
    savePage(slug: string, dto: SavePageDto): Promise<{
        slug: string;
        displayName: string;
        theme: import("@prisma/client/runtime/client").JsonValue;
        blocks: {
            id: string;
            pageSlug: string;
            type: string;
            data: import("@prisma/client/runtime/client").JsonValue;
            order: number | null;
            visible: boolean | null;
            createdAt: string;
            updatedAt: string;
        }[];
    }>;
    getPage(slug: string): Promise<{
        slug: string;
        displayName: string;
        theme: import("@prisma/client/runtime/client").JsonValue;
        blocks: {
            id: string;
            pageSlug: string;
            type: string;
            data: import("@prisma/client/runtime/client").JsonValue;
            order: number | null;
            visible: boolean | null;
            createdAt: string;
            updatedAt: string;
        }[];
    }>;
    createBlock(slug: string, dto: CreateBlockDto): Promise<{
        id: string;
        pageSlug: string;
        type: string;
        data: import("@prisma/client/runtime/client").JsonValue;
        order: number | null;
        visible: boolean | null;
        createdAt: string;
        updatedAt: string;
    }>;
    updateBlock(id: string, dto: UpdateBlockDto): Promise<{
        id: string;
        pageSlug: string | undefined;
        type: string;
        data: import("@prisma/client/runtime/client").JsonValue;
        order: number | null;
        visible: boolean | null;
        createdAt: string;
        updatedAt: string;
    }>;
    deleteBlock(id: string): Promise<{
        success: boolean;
    }>;
    reorderBlocks(slug: string, dto: ReorderBlocksDto): Promise<{
        success: boolean;
    }>;
    toggleVisibility(id: string): Promise<{
        id: string;
        visible: boolean | null;
    }>;
}
