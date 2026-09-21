import { PrismaService } from '../prisma/prisma.service';
import { CreateBlockDto } from './dto/create-block.dto';
import { UpdateBlockDto } from './dto/update-block.dto';
import { ReorderBlocksDto } from './dto/reorder-blocks.dto';
import { SavePageDto } from './dto/save-page.dto';
export declare class ContentService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    getPublicPage(pageKey: string): Promise<{
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
    savePage(pageKey: string, dto: SavePageDto): Promise<{
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
    getPages(): Promise<{
        slug: string;
        displayName: string;
        theme: import("@prisma/client/runtime/client").JsonValue;
    }[]>;
    getPageBySlug(pageKey: string): Promise<{
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
    createBlock(pageKey: string, dto: CreateBlockDto): Promise<{
        id: string;
        pageSlug: string;
        type: string;
        data: import("@prisma/client/runtime/client").JsonValue;
        order: number | null;
        visible: boolean | null;
        createdAt: string;
        updatedAt: string;
    }>;
    updateBlock(blockId: string, dto: UpdateBlockDto): Promise<{
        id: string;
        pageSlug: string | undefined;
        type: string;
        data: import("@prisma/client/runtime/client").JsonValue;
        order: number | null;
        visible: boolean | null;
        createdAt: string;
        updatedAt: string;
    }>;
    deleteBlock(blockId: string): Promise<{
        success: boolean;
    }>;
    reorderBlocks(pageKey: string, dto: ReorderBlocksDto): Promise<{
        success: boolean;
    }>;
    toggleVisibility(blockId: string): Promise<{
        id: string;
        visible: boolean | null;
    }>;
    private ensureBlockExists;
}
