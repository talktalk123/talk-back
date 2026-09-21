-- ============================================================
-- 블록 CMS 적용 SQL — Supabase SQL Editor에 붙여넣고 RUN
-- 멱등(idempotent): 여러 번 실행해도 안전합니다.
--   - 테이블이 이미 있으면 CREATE는 건너뜀 (IF NOT EXISTS)
--   - updated_at 컬럼이 없으면 추가
--   - 페이지 seed는 중복 시 무시 (ON CONFLICT DO NOTHING)
-- 대상 테이블: pages, page_contents (schema.prisma 정의와 동일)
-- ============================================================

-- ── 1. pages (없으면 생성) ────────────────────────────────────
CREATE TABLE IF NOT EXISTS "pages" (
  "id"         BIGSERIAL PRIMARY KEY,
  "page_key"   VARCHAR(100) NOT NULL UNIQUE,
  "page_name"  VARCHAR(100) NOT NULL,
  "is_active"  BOOLEAN      DEFAULT true,
  "sort_order" INTEGER      DEFAULT 0,
  "theme"      JSONB        DEFAULT '{}',
  "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP
);

-- ── 2. page_contents (없으면 생성) ────────────────────────────
CREATE TABLE IF NOT EXISTS "page_contents" (
  "id"           BIGSERIAL PRIMARY KEY,
  "page_id"      BIGINT       NOT NULL,
  "content_type" VARCHAR(20)  NOT NULL,
  "title"        VARCHAR(200),
  "content"      TEXT,
  "image_path"   VARCHAR(500),
  "data"         JSONB        DEFAULT '{}',
  "sort_order"   INTEGER      DEFAULT 0,
  "is_active"    BOOLEAN      DEFAULT true,
  "created_at"   TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "page_contents_page_id_fkey"
    FOREIGN KEY ("page_id") REFERENCES "pages"("id")
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX IF NOT EXISTS "page_contents_page_id_sort_order_idx"
  ON "page_contents" ("page_id", "sort_order");

-- ── 3. updated_at 컬럼 보강 (에디터의 "최근 저장 시각" 표시용) ──
ALTER TABLE "page_contents"
  ADD COLUMN IF NOT EXISTS "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP;

-- DB 직접 UPDATE 시에도 updated_at 자동 갱신 (Prisma @updatedAt 보완)
CREATE OR REPLACE FUNCTION trg_touch_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = CURRENT_TIMESTAMP; RETURN NEW; END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS page_contents_touch_updated_at ON "page_contents";
CREATE TRIGGER page_contents_touch_updated_at
  BEFORE UPDATE ON "page_contents"
  FOR EACH ROW EXECUTE FUNCTION trg_touch_updated_at();

DROP TRIGGER IF EXISTS pages_touch_updated_at ON "pages";
CREATE TRIGGER pages_touch_updated_at
  BEFORE UPDATE ON "pages"
  FOR EACH ROW EXECUTE FUNCTION trg_touch_updated_at();

-- ── 4. 페이지 seed (메뉴 제외 전체 공개 페이지) ───────────────
--    page_key 는 프론트 라우트와 1:1. 이미 있으면 무시.
INSERT INTO "pages" ("page_key", "page_name", "sort_order") VALUES
  ('home',         '메인',       0),
  ('about',        '톡바른 소개', 1),
  ('medicine',     '한약·보약',   2),
  ('chuna',        '추나·통증',   3),
  ('car-accident', '교통사고',    4),
  ('beauty',       '피부미용',    5),
  ('how-to-come',  '진료 안내',   6),
  ('faq',          'FAQ',        7)
ON CONFLICT ("page_key") DO NOTHING;

-- ============================================================
-- 확인용 쿼리 (선택)
--   SELECT page_key, page_name, sort_order, is_active FROM pages ORDER BY sort_order;
--   SELECT page_id, content_type, sort_order, is_active FROM page_contents ORDER BY page_id, sort_order;
-- ============================================================
