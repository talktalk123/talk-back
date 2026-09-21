/**
 * 블록 타입 단일 소스. 프론트 src/lib/cms/blocks.ts 와 동일하게 유지할 것.
 * content_type 컬럼이 VARCHAR(20)이므로 각 값은 20자 이하.
 */
export const BLOCK_TYPES = [
  'hero',
  'rich-text',
  'card-grid',
  'two-column',
  'process-steps',
  'faq',
  'cta',
  'text-panel',
  'callout',
  'table',
  'card-list',
  'raw-html',
  'floating-toolbar',
  'info-columns',
] as const;

export type BlockType = (typeof BLOCK_TYPES)[number];
