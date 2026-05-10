import { IsObject, IsOptional, IsBoolean } from 'class-validator';

export class UpdateBlockDto {
  @IsOptional()
  @IsObject()
  data?: Record<string, any>;

  @IsOptional()
  @IsBoolean()
  visible?: boolean;
}
