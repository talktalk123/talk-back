import { IsString, IsIn, IsObject, IsOptional, IsBoolean } from 'class-validator';
import { BLOCK_TYPES } from '../block-types';

export class CreateBlockDto {
  @IsString()
  @IsIn(BLOCK_TYPES as unknown as string[])
  type: string;

  @IsObject()
  data: Record<string, any>;

  @IsOptional()
  @IsBoolean()
  visible?: boolean;
}
