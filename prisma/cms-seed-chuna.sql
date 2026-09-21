-- ============================================================
-- chuna(추나·통증 진료) 페이지 콘텐츠 → 블록 이식
-- Supabase SQL Editor에 붙여넣고 RUN. 재실행 안전(기존 블록 삭제 후 삽입).
-- 프론트엔드는 배포 완료(라이트 이미지 히어로 / 큰 번호 카드 / 하이라이트 패널 / 섹션 배경 옵션).
-- ============================================================

DELETE FROM page_contents
WHERE page_id = (SELECT id FROM pages WHERE page_key = 'chuna');

INSERT INTO page_contents (page_id, content_type, data, sort_order, is_active) VALUES
((SELECT id FROM pages WHERE page_key='chuna'), 'hero', $j${
  "breadcrumb": "홈 > 추나·통증 진료",
  "badge": "Pain & Chuna",
  "title": "통증 부위와 반복되는 원인을<br /><span class=\"text-primary\">함께 살펴봅니다.</span>",
  "subtitle": "골반교정 추나, 침·약침, 집중형·방사형 체외충격파, 자기장치료를 통증 부위와 몸 상태에 맞춰 조합합니다. 체형, 근육 긴장, 관절 움직임, 생활습관을 함께 확인해 반복되는 원인을 더 구체적으로 파악합니다.",
  "theme": "light",
  "bg": { "type": "image", "value": "https://lh3.googleusercontent.com/aida-public/AB6AXuBxUJKazzmcvOywe2Ll2cclfrRDJT5GnWnUQp1NN2PVKzZ0gk6YPEHIhf187BCM3JSN7bSWQRnXsOAe9-igK3HyUCWQhl38TDOlCMCqPNzdNg6NAssaOUVniuvzMmhzyORM5Vs1a6iGkK-okgVIYzTgGu6thrz_I2ia4yjrlVDVH2qj_2T0fVmK0VGdKJdygYpbHeJPrAr9iUIkltCFqXGHdNiBOPJuxulL7xefO4TCwWJt1RvFWDDRnYablKhbiavOJ_Po363u4Ls" },
  "tags": ["골반교정 추나", "혈자리 침치료", "다양한 약침", "집중형·방사형 체외충격파", "자기장치료"],
  "buttons": [
    { "label": "네이버 예약", "href": "https://booking.naver.com/booking/13/bizes/1171309", "style": "primary", "icon": "calendar_today" },
    { "label": "전화 031-767-0075", "href": "tel:031-767-0075", "style": "outline", "icon": "call" }
  ]
}$j$::jsonb, 0, true),

((SELECT id FROM pages WHERE page_key='chuna'), 'text-panel', $j${
  "eyebrow": "Core Message",
  "heading": "통증 부위와 통증을 만드는 구조를<br />나누어 확인합니다",
  "bg": "white",
  "paragraphs": [
    "반복되는 통증은 한 부위의 문제만으로 설명되지 않는 경우가 많습니다. 자세, 움직임, 근육 긴장, 관절 가동성, 생활습관이 함께 영향을 줄 수 있습니다.",
    "본원에서는 추나치료를 기본적으로 골반교정과 교정 도구를 활용해 진행하고, 척추도인안교학회 창립 전 학생모임 시기부터 수련해온 척추도인안교요법 기반의 교정 접근을 추나·통증 진료에 활용합니다. 상태에 따라 침, 혈자리 침치료, 약침, 집중형·방사형 체외충격파, 자기장치료를 조합합니다."
  ],
  "quote": "반복되는 통증은 원인 구조를 함께 살피는 것이 중요합니다.",
  "panelTitle": "보유 치료 자산",
  "panelItems": ["골반교정 중심 추나치료", "척추도인안교요법 기반 교정 도구 접근", "교정 도구를 활용한 추나 접근", "집중형 체외충격파", "방사형 체외충격파", "염증·보강·근육긴장 완화 목적의 다양한 약침", "자기장치료기", "혈자리 기반 침치료"]
}$j$::jsonb, 1, true),

((SELECT id FROM pages WHERE page_key='chuna'), 'table', $j${
  "eyebrow": "Treatment Tools",
  "heading": "치료 도구별 역할",
  "bg": "neutral",
  "headers": ["치료", "주로 보는 부분", "설명"],
  "rows": [
    ["추나요법", "골반, 척추, 체형, 관절 움직임", "골반교정과 척추도인안교요법 기반 교정 도구 접근을 활용해 구조적 불균형과 움직임을 확인합니다."],
    ["혈자리 침치료", "통증 조절, 근육 긴장, 연결된 반응", "통증 부위만 찌르는 방식이 아니라 혈자리를 활용해 다른 부위의 긴장 변화도 확인합니다."],
    ["약침 치료", "염증, 근육 긴장, 회복 보조", "목적에 따라 약침 종류를 다르게 선택합니다. 환자 상태와 부위에 따라 적용이 달라질 수 있습니다."],
    ["집중형 체외충격파", "깊거나 특정한 통증 지점", "잘 풀리지 않는 핵심 근육, 인대·힘줄 부위 등 목표 지점을 정해 적용할 수 있습니다."],
    ["방사형 체외충격파", "넓은 근육·근막 긴장", "넓게 긴장된 부위, 근막성 통증 등에서 상태에 따라 활용합니다."],
    ["자기장치료", "통증 완화 보조와 회복 관리", "통증 양상에 따라 보조 치료로 함께 활용할 수 있습니다."]
  ]
}$j$::jsonb, 2, true),

((SELECT id FROM pages WHERE page_key='chuna'), 'card-grid', $j${
  "eyebrow": "By Area",
  "heading": "부위별로 다르게 확인합니다",
  "intro": "",
  "columns": 3,
  "variant": "number-lg",
  "bg": "white",
  "cards": [
    {"icon": "", "num": "01", "title": "목·어깨 통증", "desc": "목 자체뿐 아니라 승모근, 견갑골, 흉추 움직임, 팔저림 여부를 함께 봅니다."},
    {"icon": "", "num": "02", "title": "허리·골반 통증", "desc": "허리 통증이 골반 움직임, 둔근 긴장, 고관절 제한과 연결되는지 확인합니다."},
    {"icon": "", "num": "03", "title": "무릎·발목 통증", "desc": "관절 통증뿐 아니라 보행, 근력, 인대 긴장, 발목 움직임을 함께 봅니다."},
    {"icon": "", "num": "04", "title": "팔꿈치·손목 통증", "desc": "반복 사용, 힘줄 부위 압통, 근막 긴장을 확인하고 체외충격파 적용 여부를 봅니다."},
    {"icon": "", "num": "05", "title": "족저근막·발바닥 통증", "desc": "발바닥 통증은 족저근막, 종아리 긴장, 보행 습관을 함께 확인합니다."},
    {"icon": "", "num": "06", "title": "등·흉추 통증", "desc": "등 주변 긴장, 흉추 움직임, 견갑골 움직임과 호흡 시 불편감을 함께 확인합니다."}
  ]
}$j$::jsonb, 3, true),

((SELECT id FROM pages WHERE page_key='chuna'), 'text-panel', $j${
  "eyebrow": "Acupuncture",
  "heading": "근위·원위 혈자리를<br />함께 활용하는 침치료",
  "bg": "surface",
  "paragraphs": [
    "침치료는 통증 부위의 근육만 단순히 자극하는 방식으로 끝나지 않습니다. 통증 부위와 연결된 근육 긴장, 움직임, 혈자리 반응을 함께 확인하면서 치료 방향을 정합니다. 반응은 개인 상태에 따라 달라질 수 있습니다.",
    "본원에서는 통증 부위, 연결된 근육 긴장, 혈자리 반응을 함께 확인해 침치료 방향을 정합니다."
  ],
  "panelTitle": "침치료는 반응을 확인하며 진행합니다",
  "panelIcon": "tips_and_updates",
  "panelText": "침치료는 통증 부위 주변의 근위 혈자리와 연결된 원위 혈자리를 함께 살피며 진행합니다. 근위·원위 혈자리 반응과 연결된 근육 긴장을 함께 확인하면서 치료 방향을 잡습니다. 반응은 개인 상태에 따라 달라질 수 있습니다."
}$j$::jsonb, 4, true),

((SELECT id FROM pages WHERE page_key='chuna'), 'faq', $j${
  "eyebrow": "FAQ",
  "heading": "추나·통증 진료 FAQ",
  "items": [
    {"q": "추나요법은 어떤 방식으로 진행하나요?", "a": "본원에서는 골반교정과 척추도인안교요법 기반의 교정 도구 접근을 활용한 추나 치료를 진행합니다. 체형과 움직임을 확인한 뒤 필요한 부위에 맞춰 시행하며, 상태에 따라 침·약침·체외충격파를 함께 고려합니다."},
    {"q": "집중형·방사형 체외충격파는 어떻게 다르게 쓰이나요?", "a": "집중형은 더 깊거나 특정 지점에 집중할 때, 방사형은 넓은 근육·근막 부위에 적용할 때 고려할 수 있습니다. 실제 적용은 통증 부위, 조직 깊이, 압통 양상에 따라 달라집니다."},
    {"q": "약침은 어떤 경우에 사용하나요?", "a": "약침은 침치료의 자극에 약침액의 국소 작용을 더해, 통증 부위의 염증 반응과 근육 긴장, 회복 과정을 함께 고려할 수 있는 치료입니다. 통증 양상과 부위에 따라 일반 침치료와 병행해 치료 방향을 정합니다."},
    {"q": "혈자리를 이용한 침치료는 무엇이 다른가요?", "a": "통증 부위와 주변 혈자리 반응을 함께 살피는 방식으로 접근할 수 있습니다. 통증 부위와 연결된 근육 긴장, 움직임, 혈자리 반응을 함께 확인하면서 치료 방향을 정합니다."},
    {"q": "통증이 반복될 때는 어느 부위를 함께 보나요?", "a": "아픈 부위만 보지 않고 체형, 관절 움직임, 근육 긴장, 반복되는 생활습관을 함께 확인합니다. 목 통증이라도 어깨, 등, 골반 움직임이 영향을 줄 수 있어 전체 흐름을 함께 살핍니다."}
  ]
}$j$::jsonb, 5, true),

((SELECT id FROM pages WHERE page_key='chuna'), 'cta', $j${
  "heading": "반복되는 통증은 구조부터 살펴보세요",
  "text": "체형, 근육 긴장, 관절 움직임을 함께 확인하고 통증 부위와 연결된 원인을 살펴봅니다.",
  "theme": "dark",
  "buttons": [
    {"label": "네이버 예약하기", "href": "https://booking.naver.com/booking/13/bizes/1171309", "style": "primary", "icon": "arrow_forward"},
    {"label": "전화 031-767-0075", "href": "tel:031-767-0075", "style": "outline", "icon": "call"},
    {"label": "교통사고 진료 보기", "href": "/car-accident", "style": "outline", "icon": "arrow_forward"}
  ]
}$j$::jsonb, 6, true);

-- 되돌리기: DELETE FROM page_contents WHERE page_id = (SELECT id FROM pages WHERE page_key='chuna');
