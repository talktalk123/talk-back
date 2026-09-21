export declare class SaveBlockDto {
    type: string;
    data: Record<string, any>;
    visible?: boolean;
}
export declare class SavePageDto {
    displayName?: string;
    theme?: Record<string, any>;
    blocks: SaveBlockDto[];
}
