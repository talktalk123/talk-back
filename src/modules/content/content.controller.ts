import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';
import { ContentService } from './content.service';
import { CreateBlockDto } from './dto/create-block.dto';
import { UpdateBlockDto } from './dto/update-block.dto';
import { ReorderBlocksDto } from './dto/reorder-blocks.dto';
import { JwtAuthGuard } from '../auth/auth.guard';

@Controller('content')
export class ContentController {
  constructor(private readonly contentService: ContentService) {}

  /** GET /content/pages — 페이지 목록 */
  @UseGuards(JwtAuthGuard)
  @Get('pages')
  getPages() {
    return this.contentService.getPages();
  }

  /** GET /content/pages/:slug — 페이지 + 블록 상세 */
  @UseGuards(JwtAuthGuard)
  @Get('pages/:slug')
  getPage(@Param('slug') slug: string) {
    return this.contentService.getPageBySlug(slug);
  }

  /** POST /content/pages/:slug/blocks — 블록 생성 */
  @UseGuards(JwtAuthGuard)
  @Post('pages/:slug/blocks')
  createBlock(@Param('slug') slug: string, @Body() dto: CreateBlockDto) {
    return this.contentService.createBlock(slug, dto);
  }

  /** PATCH /content/blocks/:id — 블록 수정 */
  @UseGuards(JwtAuthGuard)
  @Patch('blocks/:id')
  updateBlock(@Param('id') id: string, @Body() dto: UpdateBlockDto) {
    return this.contentService.updateBlock(id, dto);
  }

  /** DELETE /content/blocks/:id — 블록 삭제 */
  @UseGuards(JwtAuthGuard)
  @Delete('blocks/:id')
  deleteBlock(@Param('id') id: string) {
    return this.contentService.deleteBlock(id);
  }

  /** PATCH /content/pages/:slug/reorder — 블록 순서 변경 */
  @UseGuards(JwtAuthGuard)
  @Patch('pages/:slug/reorder')
  reorderBlocks(@Param('slug') slug: string, @Body() dto: ReorderBlocksDto) {
    return this.contentService.reorderBlocks(slug, dto);
  }

  /** PATCH /content/blocks/:id/visibility — 표시/숨김 토글 */
  @UseGuards(JwtAuthGuard)
  @Patch('blocks/:id/visibility')
  toggleVisibility(@Param('id') id: string) {
    return this.contentService.toggleVisibility(id);
  }
}
