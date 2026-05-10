import { IsString, IsIn, IsObject, IsOptional, IsBoolean } from 'class-validator';

export class CreateBlockDto {
  @IsString()
  @IsIn(['hero', 'card-grid', 'two-column', 'process-steps'])
  type: string;

  @IsObject()
  data: Record<string, any>;

  @IsOptional()
  @IsBoolean()
  visible?: boolean;
}
