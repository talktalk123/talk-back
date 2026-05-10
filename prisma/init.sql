-- ============================================================
-- 톡바른경희한의원 본점 — 백엔드 초기 DDL
-- 대상: 신규 Supabase 인스턴스 (clean state)
-- 실행 방법: Supabase Dashboard → SQL Editor에 통째로 붙여넣고 RUN
--           또는 psql -f prisma/init.sql "$DATABASE_URL"
-- ============================================================

-- ── 1. admins ────────────────────────────────────────────────
CREATE TABLE "admins" (
  "id"            BIGSERIAL PRIMARY KEY,
  "login_id"      VARCHAR(100) NOT NULL UNIQUE,
  "password_hash" VARCHAR(255) NOT NULL,
  "name"          VARCHAR(100) NOT NULL,
  "role"          VARCHAR(20)  DEFAULT 'EDITOR',
  "last_login_at" TIMESTAMP(6),
  "is_active"     BOOLEAN      DEFAULT true,
  "created_at"    TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_at"    TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP
);

-- ── 2. pages (현재 사용 안 함, 향후 블록 CMS 도입 대비 보존) ──
CREATE TABLE "pages" (
  "id"         BIGSERIAL PRIMARY KEY,
  "page_key"   VARCHAR(100) NOT NULL UNIQUE,
  "page_name"  VARCHAR(100) NOT NULL,
  "is_active"  BOOLEAN      DEFAULT true,
  "sort_order" INTEGER      DEFAULT 0,
  "theme"      JSONB        DEFAULT '{}',
  "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP
);

-- ── 3. page_contents (블록 CMS, 보존) ─────────────────────────
CREATE TABLE "page_contents" (
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
CREATE INDEX "page_contents_page_id_sort_order_idx"
  ON "page_contents" ("page_id", "sort_order");

-- ── 4. popups (보존) ──────────────────────────────────────────
CREATE TABLE "popups" (
  "id"         BIGSERIAL PRIMARY KEY,
  "title"      VARCHAR(100) NOT NULL,
  "image_path" VARCHAR(500),
  "link_url"   VARCHAR(500),
  "start_at"   TIMESTAMP(6) NOT NULL,
  "end_at"     TIMESTAMP(6),
  "is_active"  BOOLEAN      DEFAULT true,
  "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP
);

-- ── 5. posts (AI 게시판, 신규) ────────────────────────────────
CREATE TABLE "posts" (
  "id"           BIGSERIAL PRIMARY KEY,
  "slug"         VARCHAR(120) NOT NULL UNIQUE,
  "title"        VARCHAR(255) NOT NULL,
  "summary"      TEXT,
  "content"      TEXT         NOT NULL,
  "category"     VARCHAR(50)  NOT NULL,
  "tags"         TEXT[]       NOT NULL DEFAULT ARRAY[]::TEXT[],
  "language"     VARCHAR(10)  NOT NULL DEFAULT 'ko-KR',
  "is_published" BOOLEAN      NOT NULL DEFAULT true,
  "metadata"     JSONB        DEFAULT '{}',
  "published_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "created_at"   TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at"   TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "author_id"    BIGINT,
  CONSTRAINT "posts_author_id_fkey"
    FOREIGN KEY ("author_id") REFERENCES "admins"("id")
    ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX "posts_is_published_published_at_idx"
  ON "posts" ("is_published", "published_at" DESC);
CREATE INDEX "posts_category_published_at_idx"
  ON "posts" ("category", "published_at" DESC);
CREATE INDEX "posts_slug_idx" ON "posts" ("slug");
CREATE INDEX "posts_tags_gin_idx" ON "posts" USING GIN ("tags");

-- ============================================================
-- 운영자 메모
-- ============================================================
-- A) Admin 계정 INSERT (예시 — 실제 비밀번호 해시는 직접 만드셔야 합니다)
--    bcrypt 해시 만드는 명령:
--      node -e "console.log(require('bcryptjs').hashSync('원하는비밀번호', 10))"
--
--    INSERT INTO "admins" ("login_id", "password_hash", "name", "role")
--    VALUES (
--      'admin',
--      '$2a$10$여기에생성한해시값붙여넣기',
--      '관리자 이름',
--      'ADMIN'
--    );
--
-- B) Prisma migrate를 쓰지 않고 이 파일을 직접 실행한 경우,
--    이후 Prisma 명령은 `prisma db pull` 또는 `prisma migrate resolve`로
--    상태를 맞추거나, 아예 Prisma migrate를 안 쓰고 `prisma generate`만
--    사용하셔도 됩니다.
--
-- C) Supabase의 RLS(Row Level Security)는 백엔드가 Prisma 직접 접속이라
--    적용 안 됩니다. 만약 supabase-js anon key로 접근하는 채널이 생기면
--    그때 RLS 정책을 별도로 추가하세요.
--
-- D) updated_at 자동 갱신은 Prisma `@updatedAt`이 ORM 레벨에서 처리합니다.
--    DB 직접 UPDATE 시에도 자동 반영이 필요하면 트리거 추가:
--      CREATE OR REPLACE FUNCTION trg_touch_updated_at()
--      RETURNS TRIGGER AS $$
--      BEGIN NEW.updated_at = CURRENT_TIMESTAMP; RETURN NEW; END;
--      $$ LANGUAGE plpgsql;
--      CREATE TRIGGER posts_touch_updated_at
--        BEFORE UPDATE ON "posts"
--        FOR EACH ROW EXECUTE FUNCTION trg_touch_updated_at();
