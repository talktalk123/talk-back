import { Type } from 'class-transformer';
import {
  IsArray,
  IsBoolean,
  IsIn,
  IsObject,
  IsOptional,
  IsString,
  ValidateNested,
} from 'class-validator';
import { BLOCK_TYPES } from '../block-types';

export class SaveBlockDto {
  @IsString()
  @IsIn(BLOCK_TYPES as unknown as string[])
  type: string;

  @IsObject()
  data: Record<string, any>;

  @IsOptional()
  @IsBoolean()
  visible?: boolean;
}

/** PUT /content/pages/:slug — 페이지의 블록 전체를 원자적으로 교체 */
export class SavePageDto {
  @IsOptional()
  @IsString()
  displayName?: string;

  /** 페이지 메타(SEO) 등. { seo: { title, description, ogImage } } */
  @IsOptional()
  @IsObject()
  theme?: Record<string, any>;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SaveBlockDto)
  blocks: SaveBlockDto[];
}
