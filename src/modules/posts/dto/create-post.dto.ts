import {
  IsArray,
  IsBoolean,
  IsDateString,
  IsObject,
  IsOptional,
  IsString,
  Matches,
  MaxLength,
  MinLength,
} from 'class-validator';

export class CreatePostDto {
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  @Matches(/^[a-z0-9가-힣-]+$/, {
    message: 'slug는 소문자 영숫자/한글/하이픈만 사용할 수 있습니다.',
  })
  slug: string;

  @IsString()
  @MinLength(1)
  @MaxLength(255)
  title: string;

  @IsOptional()
  @IsString()
  summary?: string;

  @IsString()
  @MinLength(1)
  content: string;

  @IsString()
  @MinLength(1)
  @MaxLength(50)
  category: string;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  tags?: string[];

  @IsOptional()
  @IsString()
  @MaxLength(10)
  language?: string;

  @IsOptional()
  @IsBoolean()
  isPublished?: boolean;

  @IsOptional()
  @IsObject()
  metadata?: Record<string, unknown>;

  @IsOptional()
  @IsDateString()
  publishedAt?: string;
}
