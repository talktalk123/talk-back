import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import type { Request } from 'express';
import { PostsService } from './posts.service';
import { CreatePostDto } from './dto/create-post.dto';
import { UpdatePostDto } from './dto/update-post.dto';
import { JwtAuthGuard } from '../auth/auth.guard';

@Controller('posts')
export class PostsController {
  constructor(private readonly postsService: PostsService) {}

  /** GET /api/posts — 게시글 목록 (공개) */
  @Get()
  list(@Query('category') category?: string) {
    return this.postsService.list({
      category,
      publishedOnly: true,
    });
  }

  /** GET /api/posts/admin — admin용 전체 목록 (인증) */
  @UseGuards(JwtAuthGuard)
  @Get('admin')
  listAll(@Query('category') category?: string) {
    return this.postsService.list({ category, publishedOnly: false });
  }

  /** GET /api/posts/:slug — 단일 글 (공개, published만) */
  @Get(':slug')
  get(@Param('slug') slug: string) {
    return this.postsService.getBySlug(slug, true);
  }

  /** POST /api/posts — 글 생성 (인증) */
  @UseGuards(JwtAuthGuard)
  @Post()
  create(
    @Body() dto: CreatePostDto,
    @Req() req: Request,
  ) {
    const user = (req as Request & { user?: { sub?: number } }).user;
    return this.postsService.create(dto, user?.sub);
  }

  /** PATCH /api/posts/:slug — 글 수정 (인증) */
  @UseGuards(JwtAuthGuard)
  @Patch(':slug')
  update(@Param('slug') slug: string, @Body() dto: UpdatePostDto) {
    return this.postsService.update(slug, dto);
  }

  /** DELETE /api/posts/:slug — 글 삭제 (인증) */
  @UseGuards(JwtAuthGuard)
  @Delete(':slug')
  delete(@Param('slug') slug: string) {
    return this.postsService.delete(slug);
  }
}
