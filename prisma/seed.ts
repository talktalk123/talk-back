import { PrismaClient } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import * as bcrypt from 'bcryptjs';
import 'dotenv/config';

const adapter = new PrismaPg({
  connectionString: process.env.DATABASE_URL,
});
const prisma = new PrismaClient({ adapter });

async function main() {
  console.log('🌱 Seeding database...');

  // ─── 1. Admin 계정 ───
  const hash = await bcrypt.hash('1234', 10);
  await prisma.admin.upsert({
    where: { login_id: 'admin' },
    update: {},
    create: {
      login_id: 'admin',
      password_hash: hash,
      name: 'Dr. Kim',
      role: 'ADMIN',
    },
  });
  console.log('✅ Admin 계정 생성 (admin / 1234)');

  // ─── 2. Pages ───
  const pagesData = [
    {
      page_key: 'acupuncture',
      page_name: '침 (Acupuncture)',
      sort_order: 0,
      theme: {
        accentColor: 'primary',
        accentColorHover: '#15c550',
        textMuted: '#4e9767',
        bgCard: '#f6f8f6',
        borderCard: 'gray-200',
      },
    },
    {
      page_key: 'chuna',
      page_name: '추나 (Chuna)',
      sort_order: 1,
      theme: {
        accentColor: 'primary',
        accentColorHover: '#15c550',
        textMuted: '#4e9767',
        bgCard: '#f6f8f6',
        borderCard: 'gray-200',
      },
    },
    {
      page_key: 'herbal-medicine',
      page_name: '한약 (Herbal Medicine)',
      sort_order: 2,
      theme: {
        accentColor: 'primary',
        accentColorHover: '#15c550',
        textMuted: '#4e9767',
        bgCard: '#f6f8f6',
        borderCard: 'gray-200',
      },
    },
    {
      page_key: 'beauty',
      page_name: '미용 (Beauty)',
      sort_order: 3,
      theme: {
        accentColor: '#d4a373',
        accentColorHover: '#b08968',
        textMuted: '#78716c',
        bgCard: 'white',
        borderCard: 'stone-200',
      },
    },
  ];

  const pages: Record<string, { id: bigint }> = {};
  for (const p of pagesData) {
    const page = await prisma.page.upsert({
      where: { page_key: p.page_key },
      update: { theme: p.theme },
      create: p,
    });
    pages[p.page_key] = page;
  }
  console.log('✅ 4개 서비스 페이지 생성');

  // ─── 3. Content Blocks ───
  await prisma.pageContent.deleteMany({});

  const blocks = [
    // ── Acupuncture ──
    {
      page_key: 'acupuncture',
      content_type: 'hero',
      sort_order: 0,
      data: {
        backgroundImage:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCx6C3vxZU0RdkpF5LjABi-cpMzUQQk8Psvs9D3ljlPccvKxGOcBxFdASIsQLJKh9mWxK_c32oH9rlM1TttQ0ORqih1UfU6MAmRGRbp3H3NmIJJXMvnI9HIsV8r0a-YrSN2_jwgQq_kv3ayh6_aOdyLPhF-KHMelKAN3k1QwRtgM4-w67fU9oO-wu6sGsB9nZOTlhuDH17cT135CbkcPRR9T_S__beHWp4PHIOUZ3CnqzsDPQ2vL-aevmcHgG6t0Q1OpysM4F2kick',
        badgeIcon: 'healing',
        badgeText: 'Acupuncture Therapy',
        title: '통증의 근본을',
        titleHighlight: '치료하는 침',
        subtitle: '기혈 순환을 돕고 막힌 경락을 뚫어주는 전통 침 치료.\n자연 치유력을 깨워 통증 없는 건강한 몸으로 되돌려드립니다.',
        primaryButtonText: '진료 예약하기',
        secondaryButtonText: '치료 종류 보기',
      },
    },
    {
      page_key: 'acupuncture',
      content_type: 'two-column',
      sort_order: 1,
      data: {
        labelText: 'Our Treatment',
        sectionTitle: '다양한 증상에 맞춘',
        sectionTitleHighlight: '전문 침 치료 프로그램',
        imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuC64FrkTTp-WOgEanBLzQDmy0gUllSgCVgFqjaR3GKQcfUBRYGVMKMTsv86zvW_YVveknxSI6SVwA_GN_qlDb6SmGqe-_S1eueMuR3FGekGrpxm5Is-wkWcLcEtWAbhkNXj6Gk-R0laEl7FPfoXcWYMsww3sVWoQOEG3k6Pfme35pkkUjcmisZ2WIHBycwHqKpFuUU89FH8rsKgM4gm72Dj5Mt0_2sCXZvL3sH5NgafBOcBkFuSAW6QOOSK6wOkbslf5BLKzqGjN9c',
        imagePosition: 'right',
        items: [
          { icon: 'vaccines', heading: '일반 침 (General Acupuncture)', description: '경혈을 자극하여 기혈 순환을 촉진하고 근육의 긴장을 풀어주는 가장 기본적인 치료법입니다. 급성 및 만성 통증 완화에 효과적입니다.' },
          { icon: 'fluid_med', heading: '약침 (Pharmacopuncture)', description: '순수 한약재에서 정제, 추출한 약물을 경혈에 주입하여 침과 한약의 효과를 동시에 얻는 치료법입니다. 염증 제거와 조직 재생에 탁월합니다.' },
          { icon: 'local_fire_department', heading: '화침 (Fire Needle)', description: '침을 가열하여 경혈에 자입하는 요법으로, 심한 냉증이나 고질적인 만성 통증, 인대 및 힘줄 질환에 강력한 효과를 발휘합니다.' },
        ],
      },
    },
    {
      page_key: 'acupuncture',
      content_type: 'card-grid',
      sort_order: 2,
      data: {
        sectionTitle: '침 치료의 핵심 효과',
        sectionSubtitle: 'Key benefits of our acupuncture treatment.',
        cards: [
          { icon: 'flash_on', title: '빠른 통증 완화', subtitle: 'Fast Pain Relief', description: '통증 유발 물질을 제거하고 엔도르핀 분비를 촉진하여 즉각적으로 통증을 줄여줍니다.' },
          { icon: 'water_drop', title: '혈액 순환 개선', subtitle: 'Improved Circulation', description: '막힌 기혈을 뚫어 혈액 순환을 원활하게 하고, 붓기와 염증을 효과적으로 가라앉힙니다.' },
          { icon: 'spa', title: '자연 치유력 강화', subtitle: 'Natural Healing', description: '우리 몸이 스스로 회복할 수 있는 면역 체계를 활성화하여 건강한 신체 밸런스를 되찾아줍니다.' },
        ],
      },
    },
    // ── Chuna ──
    {
      page_key: 'chuna',
      content_type: 'hero',
      sort_order: 0,
      data: {
        backgroundImage: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBT5DnfxD6IDfhY50Hiiazt06mNLps12fMb4A0Rz00mhTW3sFpf-0mknmdHGE5C_H4jWrCBY2dQvmO3y540HJ5Ctm4ea9Yy7-otq7ivAaypkgMeKrdc0dAipiHwX7vG6x8EEAp2Q0srjQx_Jn61EX-1eZjDj8qJv1uQ1Zo9-yYeffDWYxrc0ZaaPSa9xxHBX1efmzkmunhFe8LZk-hWeV1Az43cDSouO4u4FGkDmRgAXn6L44pRuhjEJGMHLClXWYkRoBnrgZLigMo',
        badgeIcon: 'healing',
        badgeText: 'Chuna Manual Therapy',
        title: '틀어진 체형을',
        titleHighlight: '바로잡는 추나 요법',
        subtitle: '비틀어진 척추와 관절을 밀고 당겨 바로잡습니다.\n구조적 문제를 해결하여 통증의 근본 원인을 치료합니다.',
        primaryButtonText: '상담 예약하기',
        secondaryButtonText: '치료 원리 보기',
      },
    },
    {
      page_key: 'chuna',
      content_type: 'card-grid',
      sort_order: 1,
      data: {
        sectionTitle: '추나 요법 핵심 포인트',
        sectionSubtitle: '구조적 불균형을 해소하고 신체 기능을 정상화하는 3가지 핵심',
        centered: true,
        cards: [
          { icon: 'pan_tool', title: '수기 요법', subtitle: 'Hand-on Technique', description: '한의사가 직접 손과 신체를 이용하여 환자의 신체 구조에 유효한 자극을 가하여 구조적·기능적 문제를 치료합니다.' },
          { icon: 'accessibility_new', title: '척추 & 관절 정렬', subtitle: 'Spine & Joint Alignment', description: '어긋난 척추와 관절의 정렬을 바로잡아 신경 압박을 해소하고 통증을 완화하며 운동 범위를 회복시킵니다.' },
          { icon: 'vertical_align_center', title: '자세 교정', subtitle: 'Postural Correction', description: '잘못된 자세로 인한 불균형을 교정하여 만성 통증을 예방하고 바른 체형을 유지하도록 돕습니다.' },
        ],
      },
    },
    {
      page_key: 'chuna',
      content_type: 'process-steps',
      sort_order: 2,
      data: {
        sectionTitle: '추나 치료 프로세스',
        sectionSubtitle: '체계적인 진단부터 유지 관리까지',
        steps: [
          { number: '01', title: '정밀 진단', description: 'X-ray 분석 및 체형 검사를 통해 척추의 틀어짐 정도와 관절의 가동 범위를 정확히 파악합니다.', badge: 'Diagnosis' },
          { number: '02', title: '수기 교정', description: '한의사가 직접 환자의 상태에 맞는 강도와 기법으로 뼈와 근육을 조정하여 정렬을 맞춥니다.', badge: 'Manual Adjustment' },
          { number: '03', title: '유지 및 강화', description: '교정된 상태를 유지하기 위한 운동 요법을 지도하고, 약해진 주변 근육을 강화합니다.', badge: 'Maintenance' },
        ],
      },
    },
    // ── Herbal Medicine ──
    {
      page_key: 'herbal-medicine',
      content_type: 'hero',
      sort_order: 0,
      data: {
        backgroundImage: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDk-fGW9XsGDevjrkN4fnuUwdq61Z7EZ6ztf2p6TcvTR0lwTuGxNR7Nmoxk-DLKsN6wEjayY1Ez9xw9wRLUv7YE6NcdoTg8kT78Qrs5cT2pKx_ATmkcT_VprzIFAggjt6PoZ4ml26YImSFt2PXaexqu_1L93936PXOTsJjRo-3toh4q6Wq1sMY2vTVS04kvog9qo8KIOkTh2A6lpLAvHbNFDvObUeK_tBdmo_MTW1hk_BEccYzrY4PJPGC2idS3neSfhDmubhr5taY',
        badgeIcon: 'verified',
        badgeText: 'Premium Herbal Medicine',
        title: '자연에서 온 처방',
        titleHighlight: '톡바른 한약',
        subtitle: '엄선된 청정 약재와 정성을 담은 조제 과정으로\n몸의 근본적인 회복을 돕는 프리미엄 한약입니다.',
        primaryButtonText: '처방 예약하기',
        secondaryButtonText: '조제 과정 보기',
      },
    },
    {
      page_key: 'herbal-medicine',
      content_type: 'card-grid',
      sort_order: 1,
      data: {
        sectionTitle: '품질 보증 시스템',
        sectionSubtitle: 'Strict quality control and premium ingredients.',
        cards: [
          { icon: 'verified_user', title: 'GAP 인증 약재', subtitle: 'GAP Certified Ingredients', description: '식품의약품안전처의 엄격한 품질 검사를 통과한 GAP 우수 농산물 인증 한약재만을 사용합니다.' },
          { icon: 'science', title: '과학적 탕전 시스템', subtitle: 'Scientific Decoction', description: '약재별 최적의 온도와 시간으로 유효 성분 추출을 극대화하는 첨단 탕전 시스템을 운영합니다.' },
          { icon: 'clean_hands', title: '클린 조제 시설', subtitle: 'Clean Facility', description: '철저한 위생 관리와 정기적인 소독을 통해 안심하고 드실 수 있는 깨끗한 조제 환경을 유지합니다.' },
        ],
      },
    },
    {
      page_key: 'herbal-medicine',
      content_type: 'two-column',
      sort_order: 2,
      data: {
        labelText: 'Our Promise',
        sectionTitle: '믿을 수 있는',
        sectionTitleHighlight: '명품 한약의 기준',
        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC3H2FJSk2MtxVh5v8K6ANww8CxBYO9zeRW-SQyah71v5H1OA9RP9dyWcuMFsv7HkpobpXtKpzUSWzTep5yzP-Kf6Z5pKZK-rZd265LqCBXFX1BxrVy2FmQ4znjkno3EQW-dEwDcwS3gMqV_4Nrk23ISXzCiqAFCYxeEA25l6YAJLdxxkFhrFhzrJi8_piqZ_ipxKsVuCugKr0f0COKXyDiwj0BA14CZesH1OomAuCNzh-e505fkLW2h10gC67OYpSGcvwy_Yr6kr0',
        imagePosition: 'left',
        items: [
          { icon: 'check_circle', heading: '1:1 맞춤 처방', description: '개인의 체질, 증상, 생활 습관까지 고려한 정밀 처방' },
          { icon: 'check_circle', heading: '엄격한 품질 관리', description: '입고부터 조제, 포장까지 전 과정의 철저한 품질 검수' },
          { icon: 'check_circle', heading: '무첨가 원칙', description: '방부제, 색소 등 불필요한 첨가물을 일절 배제한 순수 한약' },
        ],
      },
    },
    // ── Beauty ──
    {
      page_key: 'beauty',
      content_type: 'hero',
      sort_order: 0,
      data: {
        backgroundImage: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC4O6MjvfYU710qwjbnXG3Y62FX8G3yIMeqDIV4IGgMZCkOop9gAF0UMXbxx1QHPybH55X3RvoOXEVZouGpOpAesnIT_HQQk7LgciklJQ99BYIPfo-kMTSZvQmhiqhuk-Pe2ZKDWoONmQfuwJhKDKCfJk5HVR--ZjzAaYntHHtitRwHlYpUneEegNsAMZqKxotN3i4Id1UcNOF05NzF6fbrRttO_WEJhprFjBmZzi2ry-GAi1dyCBa3dzE_vvH6IdNmweJ9GtQK968',
        badgeIcon: 'spa',
        badgeText: 'Aesthetic Clinic',
        title: '본연의 아름다움을',
        titleHighlight: '깨우는 한방 미용',
        subtitle: '자연스러운 아름다움을 위한 정안침과 한방 에스테틱.\n피부 속부터 차오르는 건강한 빛을 만나보세요.',
        primaryButtonText: '상담 예약하기',
        secondaryButtonText: '시술 프로그램',
      },
    },
    {
      page_key: 'beauty',
      content_type: 'card-grid',
      sort_order: 1,
      data: {
        sectionTitle: '프리미엄 뷰티 프로그램',
        sectionSubtitle: 'Natural beauty solutions tailored to your skin.',
        cards: [
          { icon: 'face_retouching_natural', title: '정안침 요법', subtitle: 'Jung-an Needle Therapy', description: '얼굴의 경락과 근육을 자극하여 안색을 맑게 하고 탄력을 개선하는 전통 침 시술입니다.' },
          { icon: 'water_drop', title: '피부 재생 관리', subtitle: 'Skin Rejuvenation', description: '한방 천연 팩과 미세 침 요법(MTS)을 통해 피부 재생을 촉진하고 흉터 및 모공을 관리합니다.' },
          { icon: 'auto_awesome', title: '한방 매선 리프팅', subtitle: 'Natural Facelift', description: '녹는 실을 이용하여 처진 피부를 당겨주고 콜라겐 생성을 유도하는 비수술적 리프팅입니다.' },
        ],
      },
    },
    {
      page_key: 'beauty',
      content_type: 'two-column',
      sort_order: 2,
      data: {
        labelText: 'Natural Beauty',
        sectionTitle: '건강한 아름다움의',
        sectionTitleHighlight: '세 가지 약속',
        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDLvnlioj_YY6sYALCuUaT-U71IAj_ut0ff_cNXwIUTouAQOCHNknHP_9CVwVfPwbnhXchGmapbXZ5uxswrdtkQVqWxO4iCqd29v-kHytG5O4-WRpzlg34PQk1kKQuC3Vh8NnzsaeuQN2FG31HCnfjKu1Tu1dKlUi2QZ7SD68nSLoeftR-rYJEQcHLBO2HXDiuUILqIGnTgZD_XGEhswvfdKHi7uS2yTH-IdfeOiM3Kb9SmA5vnILjaCOGHdgL0fgo2EQDaLQT4nYQ',
        imagePosition: 'left',
        items: [
          { icon: 'favorite', heading: '자연스러운 탄력 회복', description: '인위적인 시술 없이 본연의 근육 탄력을 되찾아줍니다.' },
          { icon: 'light_mode', heading: '맑고 투명한 안색 개선', description: '혈액 순환을 도와 칙칙한 피부톤을 맑게 개선합니다.' },
          { icon: 'nature_people', heading: '비수술적 접근', description: '절개나 마취 없이 안전하게 아름다워지는 방법입니다.' },
        ],
      },
    },
  ];

  for (const block of blocks) {
    const page = pages[block.page_key];
    await prisma.pageContent.create({
      data: {
        page_id: page.id,
        content_type: block.content_type,
        sort_order: block.sort_order,
        data: block.data,
      },
    });
  }
  console.log('✅ 12개 컨텐츠 블록 생성 (4페이지 × 3블록)');

  console.log('🎉 Seed 완료!');
}

main()
  .catch((e) => {
    console.error('❌ Seed 실패:', e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
