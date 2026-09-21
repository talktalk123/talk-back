-- ============================================================
-- home(메인) 페이지 콘텐츠 → 블록 이식
-- Supabase SQL Editor에 RUN. 재실행 안전. 프론트엔드 배포 완료.
-- ============================================================
DELETE FROM page_contents WHERE page_id = (SELECT id FROM pages WHERE page_key = 'home');

INSERT INTO page_contents (page_id, content_type, data, sort_order, is_active) VALUES
((SELECT id FROM pages WHERE page_key='home'), 'floating-toolbar', $j${
  "items": [
    { "icon": "calendar_month", "href": "https://booking.naver.com/booking/13/bizes/1171309", "label": "네이버 예약", "primary": false },
    { "icon": "call", "href": "tel:031-767-0075", "label": "전화 031-767-0075", "primary": false },
    { "icon": "menu_book", "href": "https://blog.naver.com/talktalkhani", "label": "네이버 블로그", "primary": true }
  ]
}$j$::jsonb, 0, true),

((SELECT id FROM pages WHERE page_key='home'), 'hero', $j${
  "eyebrow": "경기광주 톡바른경희한의원 본점",
  "title": "몸 상태를 먼저 살피고,<br /><span class='text-primary'>치료 방향을 함께 정합니다.</span>",
  "subtitle": "경기광주 탄벌동에서 한약 진료, 추나·통증치료,<br class='hidden md:block' />교통사고 자동차보험 진료, 피부미용 진료를 안내합니다.",
  "subtitle2": "맥진·설진·복진으로 몸 안쪽을 살피고, 체형검사로 통증 구조를 확인하며,<br class='hidden md:block' />교통사고 후유증과 피부미용 진료까지 상태에 맞춰 진료 방향을 정합니다.",
  "theme": "light",
  "bg": { "type": "color", "value": "" },
  "bgImage": "https://lh3.googleusercontent.com/aida-public/AB6AXuAMNtS5Ajcuix9l4-bqw34j0CFuWOWOcJ8PghIWa_lGk6IFhWRxmfppx_qPLKhfHJdQm6DUJu1EXbHdd_1YzbTZlRmVX4jqdsF6uXU03nBELlb-fcCD0qCIzuAHhlxQmhWnw3ylQUM1FGF80Ro-raAKlglBFLuvX6RLWcN_RkTzJSf0rknAzu_Yrx3YA7X8uMVGwmyczr7_zohObF0vZ_a5cy3DzjR7b1yJM6nZYAcMpwWU6m0BHFoNiWcFGKLM8DdcHkVbunLR86I",
  "buttons": [
    { "label": "네이버 예약", "href": "https://booking.naver.com/booking/13/bizes/1171309", "style": "primary", "icon": "arrow_forward" },
    { "label": "전화 예약 031-767-0075", "href": "tel:031-767-0075", "style": "outline", "icon": "call" }
  ]
}$j$::jsonb, 1, true),

((SELECT id FROM pages WHERE page_key='home'), 'card-grid', $j${
  "heading": "치료 방법이 다양할수록, 상태에 맞는 선택이 중요합니다",
  "intro": "한약, 추나, 침, 약침, 체외충격파, 자기장치료, 피부미용 장비는 모두 목적이 다릅니다. 치료 선택지가 많을수록 중요한 것은 많이 하는 것이 아니라, 지금 필요한 치료와 경과를 보며 조정할 치료를 구분하는 것입니다.",
  "columns": 3,
  "variant": "icon",
  "bg": "neutral",
  "cards": [
    {"icon": "medication", "title": "몸 안쪽을 살피는 한약 진료", "desc": "같은 피로라도 원인은 다를 수 있습니다. 소화·수면·부종·열감·스트레스 반응을 함께 살핍니다.", "href": "/medicine"},
    {"icon": "accessibility_new", "title": "구조를 보는 추나·통증 진료", "desc": "목·허리·어깨·골반 통증은 체형, 근육 긴장, 관절 움직임을 함께 살피며 방향을 정합니다.", "href": "/chuna"},
    {"icon": "face", "title": "장비와 근거를 갖춘 피부미용", "desc": "스킨부스터, 레이저, 니들RF, 리프팅 장비를 피부 고민과 회복력에 맞춰 선택합니다.", "href": "/beauty"}
  ]
}$j$::jsonb, 2, true),

((SELECT id FROM pages WHERE page_key='home'), 'two-column', $j${
  "eyebrow": "Doctor",
  "heading": "치료 방향을 설명하는 진료",
  "imageSide": "left",
  "blob": true,
  "image": { "src": "/images/doctor.jpg", "alt": "이기홍 원장" },
  "imageCaption": { "label": "Director", "title": "이기홍 원장" },
  "paragraphs": [
    "이기홍 원장은 경희대학교 한의과대학을 졸업하고, 톡바른경희한의원 본점에서 진료하고 있습니다. 한약, 추나·통증치료, 피부미용을 환자 상태와 증상의 우선순위에 맞춰 치료 방향을 잡는 진료를 중요하게 생각합니다.",
    "피부미용 분야에서는 스킨부스터와 레이저 장비의 원리와 근거를 강의와 저서로 정리해왔으며, 이러한 기준을 바탕으로 피부 상태에 맞는 시술 방향을 말씀드립니다."
  ],
  "listCard": {
    "title": "주요 이력·활동",
    "items": ["경희대학교 한의과대학 졸업", "톡바른경희한의원 대표원장", "척추도인안교학회 정회원", "국제레이저미용피부과학회 학술이사", "전국한의학학술대회 레이저세션 대표강사", "2026년 K-MEX 보수교육 강의", "한케어 피부미용 강의 진행", "한의미용콘테스트 대상·최우수상", "피부미용진료를 위한 EBS : Evidence Based Skinbooster 저자"],
    "link": { "label": "원장 소개 자세히 보기", "href": "/about" }
  }
}$j$::jsonb, 3, true),

((SELECT id FROM pages WHERE page_key='home'), 'process-steps', $j${
  "eyebrow": "Process",
  "heading": "처음 진료에서 상태를 파악하고, 치료 방향을 함께 정합니다",
  "intro": "불편한 증상, 생활습관, 몸 상태, 통증 구조, 피부 상태를 종합적으로 살펴본 뒤 지금 우선적으로 집중할 치료와 이후 조정할 부분을 나누어 말씀드립니다.",
  "steps": [
    {"num": "01", "title": "증상과 생활 패턴 확인", "desc": "불편한 증상뿐 아니라 수면, 소화, 업무 습관, 운동 패턴, 피부 시술 이력까지 확인합니다."},
    {"num": "02", "title": "진찰 또는 검사", "desc": "맥진·설진·복진, 체형검사, 근육 긴장도, 피부 상태 확인 등 진료 목적에 맞는 항목을 살핍니다."},
    {"num": "03", "title": "문제의 우선순위 설명", "desc": "우선 집중할 증상과 보충·순환·배출 중 필요한 방향, 경과를 보며 조정할 부분을 나눕니다."},
    {"num": "04", "title": "치료 방법 선택", "desc": "한약, 침, 부항, 약침, 추나, 체외충격파, 자기장치료, 피부미용 장비 중 필요한 방향을 정합니다."},
    {"num": "05", "title": "치료 후 변화 확인", "desc": "남은 증상과 새롭게 보이는 변화를 확인해 다음 치료 방향을 조정합니다."}
  ]
}$j$::jsonb, 4, true),

((SELECT id FROM pages WHERE page_key='home'), 'faq', $j${
  "eyebrow": "FAQ",
  "heading": "처음 오시기 전 자주 묻는 질문",
  "items": [
    {"q": "톡바른경희한의원 본점은 어떤 진료를 하나요?", "a": "한약, 추나·통증치료, 침·약침, 집중형·방사형 체외충격파, 자기장치료, 피부미용 진료를 환자 상태에 맞춰 안내합니다. 증상 하나만 보고 치료를 정하기보다 몸 상태와 생활 패턴을 함께 확인합니다."},
    {"q": "처음 내원하면 어떤 과정을 거치나요?", "a": "불편한 증상과 생활 패턴을 확인한 뒤 필요한 경우 맥진·설진·복진, 체형검사, 근육 긴장도 확인, 피부 상태 확인 등을 진행합니다. 이후 현재 문제의 우선순위와 치료 방향을 설명드립니다."},
    {"q": "한약, 추나, 피부미용 진료는 예약이 필요한가요?", "a": "대기 시간을 줄이기 위해 예약 후 내원을 권합니다. 특히 한약 상담과 피부미용 진료는 상담과 설명 시간이 필요할 수 있습니다."},
    {"q": "치료는 몇 번 정도 받아야 하나요?", "a": "증상 기간, 몸 상태, 치료 목표에 따라 달라질 수 있습니다. 처음 진찰 후 예상 치료 방향과 경과 확인 시점을 안내드립니다."},
    {"q": "주차와 진료시간은 어떻게 되나요?", "a": "진료시간은 평일 09:00~20:00 / 토요일 09:00~14:00 / 공휴일 09:00~13:00 / 일요일 휴진입니다. 건물 내 주차장을 이용하실 수 있으며, 만차이거나 주차가 어려운 경우에는 광주시보건소·공설운동장 인근 공영주차장 등 이용 가능한 방법을 안내드립니다."}
  ]
}$j$::jsonb, 5, true),

((SELECT id FROM pages WHERE page_key='home'), 'raw-html', $j${
  "bg": "neutral",
  "html": "<div class='max-w-7xl mx-auto px-4 sm:px-6 lg:px-8'><div class='text-center mb-12'><p class='text-sm font-bold text-primary tracking-widest uppercase mb-3'>Location</p><h2 class='text-3xl md:text-4xl font-bold leading-tight'>진료시간·오시는 길</h2></div><div class='grid lg:grid-cols-2 gap-12'><div class='bg-white p-10 rounded-3xl shadow-sm border border-neutral-200'><h3 class='text-2xl font-bold mb-8'>진료 안내</h3><div class='space-y-5 mb-10'><div class='flex justify-between border-b border-neutral-100 pb-4'><span class='text-neutral-600 font-medium'>평일 (월-금)</span><span class='font-bold'>09:00 - 20:00</span></div><div class='flex justify-between border-b border-neutral-100 pb-4'><span class='text-neutral-600 font-medium'>토요일</span><span class='font-bold'>09:00 - 14:00</span></div><div class='flex justify-between border-b border-neutral-100 pb-4'><span class='text-neutral-600 font-medium'>공휴일</span><span class='font-bold'>09:00 - 13:00</span></div><div class='flex justify-between text-primary font-bold'><span>일요일</span><span>휴진</span></div></div><div class='space-y-4'><div class='flex items-start gap-4'><span class='material-symbols-outlined text-primary'>location_on</span><p class='text-neutral-700'>경기도 광주시 파발로 187 세양빌딩 2층</p></div><div class='flex items-center gap-4'><span class='material-symbols-outlined text-primary'>call</span><a href='tel:031-767-0075' class='text-neutral-700 font-bold hover:text-primary transition-colors'>031-767-0075</a></div><div class='flex items-start gap-4'><span class='material-symbols-outlined text-primary'>local_parking</span><p class='text-neutral-700'>건물 내 주차장 이용 가능. 만차 시 광주시보건소·공설운동장 인근 공영주차장 안내드립니다.</p></div></div><div class='mt-8 flex flex-wrap gap-3'><a href='/how-to-come' class='px-5 py-3 bg-primary text-white rounded-lg font-bold hover:bg-primary-dark transition-all flex items-center gap-2 text-sm'>진료 안내 자세히<span class='material-symbols-outlined text-base'>arrow_forward</span></a><a href='https://booking.naver.com/booking/13/bizes/1171309' target='_blank' rel='noopener noreferrer' class='px-5 py-3 bg-white border border-neutral-200 text-neutral-800 rounded-lg font-bold hover:bg-neutral-50 transition-all flex items-center gap-2 text-sm'>네이버 예약</a></div></div><div class='rounded-3xl overflow-hidden shadow-lg min-h-[400px] border border-neutral-200 bg-gradient-to-br from-primary-surface to-white relative flex items-center justify-center p-10'><div class='text-center'><span class='material-symbols-outlined text-primary text-7xl mb-4'>location_on</span><h3 class='text-xl font-bold text-neutral-900 mb-2'>톡바른경희한의원 본점</h3><p class='text-neutral-600 mb-2'>경기도 광주시 파발로 187</p><p class='text-neutral-600 mb-6'>세양빌딩 2층</p><p class='text-sm text-neutral-500 mb-6'>(광주시보건소 앞 / 탄벌동)</p><div class='flex flex-wrap gap-2 justify-center'><a href='https://map.naver.com/p/search/%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EA%B4%91%EC%A3%BC%EC%8B%9C%20%ED%8C%8C%EB%B0%9C%EB%A1%9C%20187' target='_blank' rel='noopener noreferrer' class='px-4 py-2 bg-white border border-primary/30 text-primary rounded-lg font-bold text-sm hover:bg-primary hover:text-white transition-all'>네이버 지도</a><a href='https://map.kakao.com/?q=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EA%B4%91%EC%A3%BC%EC%8B%9C%20%ED%8C%8C%EB%B0%9C%EB%A1%9C%20187' target='_blank' rel='noopener noreferrer' class='px-4 py-2 bg-white border border-primary/30 text-primary rounded-lg font-bold text-sm hover:bg-primary hover:text-white transition-all'>카카오맵</a></div></div></div></div></div>"
}$j$::jsonb, 6, true);

-- 되돌리기: DELETE FROM page_contents WHERE page_id = (SELECT id FROM pages WHERE page_key='home');
