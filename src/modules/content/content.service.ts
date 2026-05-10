import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateBlockDto } from './dto/create-block.dto';
import { UpdateBlockDto } from './dto/update-block.dto';
import { ReorderBlocksDto } from './dto/reorder-blocks.dto';

@Injectable()
export class ContentService {
  constructor(private readonly prisma: PrismaService) {}

  /** 모든 페이지 목록 */
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

  /** 특정 페이지 + 블록 상세 */
  async getPageBySlug(pageKey: string) {
    const page = await this.prisma.page.findUnique({
      where: { page_key: pageKey },
      include: {
        contents: { orderBy: { sort_order: 'asc' } },
      },
    });

    if (!page) {
      throw new NotFoundException(`페이지를 찾을 수 없습니다: ${pageKey}`);
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
        updatedAt: c.created_at?.toISOString() ?? '',
      })),
    };
  }

  /** 블록 생성 */
  async createBlock(pageKey: string, dto: CreateBlockDto) {
    const page = await this.prisma.page.findUnique({
      where: { page_key: pageKey },
    });
    if (!page) {
      throw new NotFoundException(`페이지를 찾을 수 없습니다: ${pageKey}`);
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

  /** 블록 수정 */
  async updateBlock(blockId: string, dto: UpdateBlockDto) {
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

  /** 블록 삭제 */
  async deleteBlock(blockId: string) {
    const block = await this.ensureBlockExists(blockId);

    await this.prisma.pageContent.delete({
      where: { id: block.id },
    });

    const remaining = await this.prisma.pageContent.findMany({
      where: { page_id: block.page_id },
      orderBy: { sort_order: 'asc' },
    });

    await Promise.all(
      remaining.map((b, i) =>
        this.prisma.pageContent.update({
          where: { id: b.id },
          data: { sort_order: i },
        }),
      ),
    );

    return { success: true };
  }

  /** 블록 순서 변경 */
  async reorderBlocks(pageKey: string, dto: ReorderBlocksDto) {
    const page = await this.prisma.page.findUnique({
      where: { page_key: pageKey },
    });
    if (!page) {
      throw new NotFoundException(`페이지를 찾을 수 없습니다: ${pageKey}`);
    }

    await Promise.all(
      dto.blockIds.map((id, index) =>
        this.prisma.pageContent.update({
          where: { id: BigInt(id) },
          data: { sort_order: index },
        }),
      ),
    );

    return { success: true };
  }

  /** 블록 표시/숨김 토글 */
  async toggleVisibility(blockId: string) {
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

  private async ensureBlockExists(blockId: string) {
    const block = await this.prisma.pageContent.findUnique({
      where: { id: BigInt(blockId) },
    });
    if (!block) {
      throw new NotFoundException(`블록을 찾을 수 없습니다: ${blockId}`);
    }
    return block;
  }
}
