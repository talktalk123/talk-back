-- ============================================================
-- car-accident(교통사고 진료) 페이지 콘텐츠 → 블록 이식
-- Supabase SQL Editor에 RUN. 재실행 안전. 프론트엔드 배포 완료.
-- ============================================================
DELETE FROM page_contents WHERE page_id = (SELECT id FROM pages WHERE page_key = 'car-accident');

INSERT INTO page_contents (page_id, content_type, data, sort_order, is_active) VALUES
((SELECT id FROM pages WHERE page_key='car-accident'), 'hero', $j${
  "breadcrumb": "홈 > 교통사고 진료",
  "eyebrow": "Traffic Accident Care",
  "title": "교통사고 후 통증,<br /><span class=\"text-primary\">초기 상태 확인이 중요합니다.</span>",
  "subtitle": "톡바른경희한의원 본점의 교통사고 진료는 사고접수번호와 자동차보험 접수 절차를 안내하고, 사고 후 목·허리 통증, 두통, 어깨 결림, 몸살, 수면 변화를 함께 확인합니다.",
  "theme": "light",
  "bg": { "type": "color", "value": "" },
  "tags": ["사고접수번호 안내", "자동차보험 진료", "목·허리 통증", "두통·어깨 결림", "추나·침·약침·한약"],
  "buttons": [
    { "label": "전화 문의 031-767-0075", "href": "tel:031-767-0075", "style": "primary", "icon": "call" },
    { "label": "오시는 길 보기", "href": "/how-to-come", "style": "outline", "icon": "arrow_forward" }
  ]
}$j$::jsonb, 0, true),

((SELECT id FROM pages WHERE page_key='car-accident'), 'text-panel', $j${
  "eyebrow": "Why Early Care Matters",
  "heading": "처음에는 괜찮아도,<br />며칠 뒤 불편감이 올라올 수 있습니다",
  "bg": "white",
  "paragraphs": [
    "편타성 손상은 교통사고 이후 흔히 이야기되는 목·어깨·등 주변의 통증 양상입니다. 목 통증과 뻣뻣함, 움직일 때 심해지는 통증, 두통, 어깨·등·팔의 통증, 피로감이나 어지럼 같은 증상이 나타날 수 있습니다.",
    "교통사고 후에는 통증 부위와 기능 제한, 일상생활 불편감이 시간에 따라 달라질 수 있습니다. 본원에서는 사고 직후 증상만 보지 않고, 움직임과 근육 긴장, 두통이나 수면 변화까지 함께 살피며 경과를 확인합니다."
  ],
  "quote": "교통사고 후 진료는 단순히 아픈 부위만 보는 것보다 사고 이후 몸의 긴장과 움직임 변화를 함께 확인하는 과정이 중요합니다.",
  "panelTitle": "이런 증상이 있다면 확인해보세요",
  "panelItems": ["목·허리 통증과 뻣뻣함", "두통, 어깨 결림, 등 통증", "팔 저림, 손 저림, 움직임 제한", "몸살 같은 피로감, 어지럼, 수면 불편", "처음에는 괜찮았는데 며칠 뒤 올라온 통증"]
}$j$::jsonb, 1, true),

((SELECT id FROM pages WHERE page_key='car-accident'), 'card-grid', $j${
  "eyebrow": "First Visit",
  "heading": "사고접수번호만 준비해오시면 접수 절차를 안내드립니다",
  "intro": "자동차보험 진료가 필요한 경우 보험사 접수 여부와 사고접수번호를 확인해오시면 진료 접수가 더 수월합니다.",
  "columns": 4,
  "variant": "number-lg",
  "bg": "neutral",
  "cards": [
    {"icon": "", "num": "01", "title": "사고접수번호 확인", "desc": "보험사에 사고가 접수되어 있다면 사고접수번호를 알려주세요. 접수 상황에 따라 필요한 절차를 안내드립니다."},
    {"icon": "", "num": "02", "title": "사고 경위와 증상 확인", "desc": "추돌 방향, 충격 정도, 사고 후 증상이 언제부터 시작되었는지 확인합니다."},
    {"icon": "", "num": "03", "title": "목·허리·어깨 움직임 확인", "desc": "통증 부위, 관절 움직임, 근육 긴장, 두통이나 저림 여부를 함께 살펴봅니다."},
    {"icon": "", "num": "04", "title": "치료 방향 안내", "desc": "침, 약침, 추나, 한약, 물리치료 등 상태에 맞는 치료 방향과 경과 확인 기준을 말씀드립니다."}
  ]
}$j$::jsonb, 2, true),

((SELECT id FROM pages WHERE page_key='car-accident'), 'table', $j${
  "eyebrow": "Treatment Options",
  "heading": "사고 후 몸 상태에 맞춰 치료를 조합합니다",
  "intro": "교통사고 후 통증은 근육 긴장, 관절 움직임 제한, 전신 피로감, 수면 변화가 함께 나타날 수 있어 상태에 맞는 치료 조합이 중요합니다.",
  "bg": "white",
  "headers": ["치료", "확인하는 부분", "설명"],
  "rows": [
    ["침치료", "통증 부위와 연결된 근육 긴장", "목·어깨·허리 주변 긴장과 혈자리 반응을 함께 확인합니다."],
    ["약침치료", "통증 부위, 염증 반응, 근육 긴장", "환자 상태와 목적에 따라 약침 종류를 구분해 적용합니다."],
    ["추나요법", "목·허리·골반 움직임", "사고 이후 움직임 제한과 체형 변화를 확인하며 시행합니다."],
    ["한약", "전신 긴장, 몸살, 수면, 회복력", "교통사고 이후 몸의 긴장과 피로감, 수면 변화를 함께 살펴 처방 방향을 정합니다."],
    ["물리치료·자기장치료", "통증 완화와 회복 보조", "통증 양상과 일상생활 불편감에 따라 보조적으로 활용합니다."]
  ]
}$j$::jsonb, 3, true),

((SELECT id FROM pages WHERE page_key='car-accident'), 'text-panel', $j${
  "eyebrow": "Recovery Flow",
  "heading": "상태에 맞는 회복 흐름이 중요합니다",
  "bg": "surface",
  "paragraphs": [
    "교통사고 후 통증은 가만히 쉬기만 한다고 모두 해결되는 문제가 아니라, 현재 통증 정도와 움직임 제한을 확인하면서 회복 흐름을 조절하는 과정이 중요합니다. 본원에서는 환자가 안심하고 일상으로 돌아갈 수 있도록 통증 양상, 움직임, 수면과 피로 변화를 함께 확인합니다.",
    "통증이 심한 초기에는 불편감을 줄이는 치료를 우선하고, 이후 움직임 회복과 일상 복귀를 함께 고려해 치료 방향을 조정합니다."
  ],
  "panelTitle": "바로 의료기관 확인이 필요한 경우",
  "panelIcon": "warning",
  "panelText": "심한 두통, 의식 저하, 팔다리 힘 빠짐, 심한 저림, 보행 이상, 대소변 조절 문제, 심한 흉통이나 호흡곤란이 있다면 응급 평가가 우선입니다.",
  "panelTone": "warning"
}$j$::jsonb, 4, true),

((SELECT id FROM pages WHERE page_key='car-accident'), 'card-grid', $j${
  "eyebrow": "Follow-up",
  "heading": "교통사고 진료는 경과 확인이 중요합니다",
  "intro": "사고 후 통증은 하루하루 양상이 달라질 수 있습니다. 처음 진료에서 현재 상태를 확인하고, 이후 통증 부위와 움직임 변화를 보며 치료 방향을 조정합니다.",
  "columns": 3,
  "variant": "number-lg",
  "bg": "white",
  "cards": [
    {"icon": "", "num": "01", "title": "초기 통증 조절", "desc": "목·허리 통증, 두통, 어깨 긴장을 줄이고 일상생활 불편감을 확인합니다."},
    {"icon": "", "num": "02", "title": "움직임 회복", "desc": "목·허리·골반 움직임과 근육 긴장을 살피며 회복 흐름을 확인합니다."},
    {"icon": "", "num": "03", "title": "일상 복귀 관리", "desc": "수면, 업무, 운전, 운동 복귀 과정에서 남는 불편감을 함께 조정합니다."}
  ]
}$j$::jsonb, 5, true),

((SELECT id FROM pages WHERE page_key='car-accident'), 'faq', $j${
  "eyebrow": "FAQ",
  "heading": "교통사고 진료 FAQ",
  "items": [
    {"q": "교통사고 후 한의원 진료를 받으려면 무엇을 준비해야 하나요?", "a": "자동차보험 진료가 필요한 경우 사고접수번호를 알려주시면 접수 절차를 안내드릴 수 있습니다. 보험사 접수 여부와 사고접수번호를 미리 확인해오시면 내원 과정이 더 수월합니다."},
    {"q": "사고 직후에는 괜찮았는데 며칠 뒤 아플 수 있나요?", "a": "교통사고 후 목 통증과 두통, 어깨·등 통증, 피로감, 어지럼 같은 증상은 사고 직후보다 며칠 뒤 나타나는 경우가 있습니다. 초기 상태를 확인하고 경과를 살피는 것이 도움이 됩니다."},
    {"q": "교통사고 진료에서는 어떤 증상을 확인하나요?", "a": "목·허리 통증, 두통, 어깨와 등 긴장, 손발 저림, 몸살 같은 전신 불편감, 수면 변화 등을 확인합니다. 사고 경위와 통증이 심해지는 자세도 함께 살펴봅니다."},
    {"q": "자동차보험으로 어떤 치료를 받을 수 있나요?", "a": "자동차보험 적용 범위와 환자 상태에 따라 침, 약침, 추나, 한약, 물리치료 등 진료 방향이 달라질 수 있습니다. 실제 적용 여부는 보험 접수 상황과 진찰 결과에 따라 안내드립니다."},
    {"q": "교통사고 후 얼마나 치료받아야 하나요?", "a": "사고 충격의 정도, 증상 기간, 통증 부위, 일상생활 불편감에 따라 달라질 수 있습니다. 처음 진료에서 현재 상태를 확인하고 경과를 보며 치료 간격과 방향을 조정합니다."}
  ]
}$j$::jsonb, 6, true),

((SELECT id FROM pages WHERE page_key='car-accident'), 'cta', $j${
  "heading": "사고접수번호와 함께 전화 주세요",
  "text": "보험사 접수 여부와 사고접수번호를 확인해오시면 접수 절차가 더 수월합니다.",
  "theme": "dark",
  "buttons": [
    {"label": "전화 031-767-0075", "href": "tel:031-767-0075", "style": "primary", "icon": "call"},
    {"label": "네이버 예약", "href": "https://booking.naver.com/booking/13/bizes/1171309", "style": "outline", "icon": "arrow_forward"},
    {"label": "오시는 길", "href": "/how-to-come", "style": "outline", "icon": "arrow_forward"}
  ]
}$j$::jsonb, 7, true);

-- 되돌리기: DELETE FROM page_contents WHERE page_id = (SELECT id FROM pages WHERE page_key='car-accident');
