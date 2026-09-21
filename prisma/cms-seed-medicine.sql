-- ============================================================
-- medicine(한약 진료) 페이지 콘텐츠 → 블록 이식
-- Supabase SQL Editor에 붙여넣고 RUN.
-- 재실행 안전: 기존 medicine 블록을 지우고 다시 넣습니다.
-- ⚠️ 실행 전: 프론트엔드가 새 블록 타입(text-panel/callout/table/card-list)을
--    렌더할 수 있도록 배포되어 있어야 합니다(완료됨).
-- ============================================================

DELETE FROM page_contents
WHERE page_id = (SELECT id FROM pages WHERE page_key = 'medicine');

INSERT INTO page_contents (page_id, content_type, data, sort_order, is_active) VALUES
((SELECT id FROM pages WHERE page_key='medicine'), 'hero', $j${
  "breadcrumb": "홈 > 한약 진료",
  "badge": "Herbal Medicine",
  "title": "한약은 증상과 몸 상태를 함께 보고<br /><span class=\"text-primary\">처방 방향을 정합니다.</span>",
  "subtitle": "톡바른경희한의원 본점의 한약 진료는 맥진·설진·복진과 생활 패턴을 함께 확인하고,<br class=\"hidden md:block\" />성인 기준 물 제외 순수 한약재 2kg 이상 사용 원칙과 자세한 한약 설명서를 바탕으로 진행됩니다.",
  "theme": "dark",
  "bg": { "type": "image", "value": "https://lh3.googleusercontent.com/aida-public/AB6AXuCGEkiWcE2WCEqsbsFPUGUB7b7eGIEWVMhAJ2tD0XsmUcUivLQsJPOrzgeopOc80j469DTw5ETczO18lDHzTwSfzjAzZkiddAfePVIitJCSYw4QGO6ThmxXResVwYumq_ZeOdUKxeB-FSLVyVxQp5yxgNg-OJvzTvhrOlmJHcnUS7YEKn4C68WLuviRaiCPV1UtLdKsV4yQX9W7xdWDH94PgdMoBze7_8AwRFZ8VTaVxfhw6KgMpdmyuRd2Nc7BB-VAQmTmLgCBFKA" },
  "tags": ["맞춤한약", "맥진·설진·복진", "자세한 설명서", "순수 한약재 2kg 이상 원칙"],
  "buttons": [
    { "label": "네이버 예약", "href": "https://booking.naver.com/booking/13/bizes/1171309", "style": "primary", "icon": "arrow_forward" },
    { "label": "전화 031-767-0075", "href": "tel:031-767-0075", "style": "outline", "icon": "call" }
  ]
}$j$::jsonb, 0, true),

((SELECT id FROM pages WHERE page_key='medicine'), 'text-panel', $j${
  "eyebrow": "Core Message",
  "heading": "보충, 순환, 배출의<br />방향을 구분합니다",
  "paragraphs": ["한약은 부족한 부분을 채우는 보약이 필요한 경우도 있고, 몸 안의 순환이 막혀 먼저 풀어주어야 하는 경우도 있습니다. 본원은 맥진·설진·복진과 생활 패턴, 증상 변화를 함께 확인해 보충, 순환, 배출 중 어떤 방향이 먼저 필요한지 구분합니다. 특히 소화가 막히고 몸이 무겁거나 붓고 머리가 무거운 담음 양상이 있는 경우에는 무조건 보약을 먼저 쓰기보다 순환과 노폐물 배출을 먼저 돕는 방향을 고려합니다."],
  "quote": "보약이 필요한 상태인지, 순환과 노폐물 배출을 먼저 도와야 하는 상태인지 함께 확인합니다. 또한 성인 기준 물을 제외한 순수 한약재를 1제당 2kg 이상 사용하는 원칙을 두고 있습니다.",
  "panelTitle": "톡바른 한약 진료의 특징",
  "panelItems": ["맥진·설진·복진 기반 진찰", "소화·수면·부종·열감·스트레스 반응 확인", "보충·순환·배출 우선순위 구분", "복용 중 변화 확인 후 처방 방향 조정", "환자 이해를 돕는 자세한 한약 설명서 제공", "성인 기준 물 제외 순수 한약재 2kg 이상 사용 원칙"]
}$j$::jsonb, 1, true),

((SELECT id FROM pages WHERE page_key='medicine'), 'callout', $j${
  "eyebrow": "Follow-up",
  "heading": "한약은 처음 처방보다<br />두 번째 처방이 더 정확해질 수 있습니다.",
  "text": "첫 처방은 현재 증상과 진찰 소견을 바탕으로 방향을 잡는 과정입니다. 복용 중 수면, 소화, 피로, 부종, 열감 같은 변화가 확인되면 다음 처방에서는 남은 불편감에 맞춰 방향을 더 세밀하게 조정할 수 있습니다.",
  "badges": ["복용 중 변화 확인", "경과에 따른 방향 조정", "자세한 한약 설명서"],
  "theme": "surface"
}$j$::jsonb, 2, true),

((SELECT id FROM pages WHERE page_key='medicine'), 'table', $j${
  "eyebrow": "Pattern",
  "heading": "한약 진료에서 자주 나누어 보는 몸 상태",
  "intro": "한의학 용어가 낯설 수 있지만, 일상적으로 표현하면 몸이 막힌 상태인지, 보강이 필요한 상태인지, 열이 위로 오른 상태인지를 나누어 보는 과정입니다.",
  "headers": ["구분", "일상적 표현", "확인하는 증상", "진료 방향"],
  "rows": [
    ["담음", "몸 안의 노폐물과 정체감", "더부룩함, 몸 무거움, 머리 무거움, 붓기", "순환과 노폐물 배출을 돕고 소화기 부담을 줄이는 방향"],
    ["기체", "스트레스와 긴장으로 흐름이 막힌 상태", "가슴 답답함, 트림, 한숨, 긴장성 통증", "막힌 흐름을 풀고 긴장을 줄이는 방향"],
    ["음허", "몸을 식히고 촉촉하게 유지하는 힘의 부족", "상열감, 건조감, 입마름, 불면", "열감을 조절하고 회복력을 돕는 방향"],
    ["심화", "스트레스와 마음의 열감이 위로 오른 상태", "불면, 두근거림, 혀 불편감, 화병 양상", "마음을 안정시키고 수면을 돕는 방향"]
  ]
}$j$::jsonb, 3, true),

((SELECT id FROM pages WHERE page_key='medicine'), 'card-grid', $j${
  "eyebrow": "Categories",
  "heading": "한약 진료 주요 영역",
  "intro": "",
  "columns": 3,
  "variant": "number",
  "cards": [
    {"icon": "", "num": "1", "title": "보약·기력저하", "desc": "체력 저하, 회복 지연, 피로감을 확인하고 보강이 필요한 상태인지 살핍니다."},
    {"icon": "", "num": "2", "title": "소화·담음", "desc": "더부룩함, 식욕저하, 몸의 정체감이 있는지 확인합니다."},
    {"icon": "", "num": "3", "title": "수면·스트레스", "desc": "입면, 중도각성, 가슴 답답함, 긴장 반응을 나누어 봅니다."},
    {"icon": "", "num": "4", "title": "갱년기·상열감", "desc": "안면홍조, 상열감, 불면, 건조감 등 열 균형과 회복력을 살핍니다."},
    {"icon": "", "num": "5", "title": "다이어트 한약", "desc": "식욕, 부종, 소화, 생활 패턴을 확인해 체중관리 방향을 설명합니다."},
    {"icon": "", "num": "6", "title": "소아·학생 한약", "desc": "나이와 체중, 소화력, 체력, 수면 상태를 고려해 복용 방향을 정합니다."}
  ]
}$j$::jsonb, 4, true),

((SELECT id FROM pages WHERE page_key='medicine'), 'card-list', $j${
  "eyebrow": "Medication Guide",
  "heading": "한약 설명서를 자세히 쓰는 이유",
  "intro": "복용 중 나타나는 변화는 환자마다 다릅니다. 설명서에는 현재 몸 상태와 처방 방향을 이해할 수 있도록 필요한 내용을 정리하고, 이후 진료에서 참고할 수 있는 개인별 증상 변화 체크 포인트를 함께 안내합니다.",
  "columns": 2,
  "cards": [
    {"title": "설명서에 담는 내용", "items": ["주요 증상 정리", "한의학적 원인 설명", "맥진·설진·복진 소견", "기대할 수 있는 변화와 한계", "복약 안내와 증상 변화 체크 포인트"]},
    {"title": "복용 중 체크할 변화 예시", "subtitle": "확인해야 할 항목은 환자 상태와 처방 방향에 따라 달라질 수 있습니다.", "items": ["피로, 수면, 회복감", "식욕, 소화, 속쓰림", "대변·소변 변화", "부종, 열감, 땀, 갈증", "두통, 어지럼, 가슴 답답함", "피부 상태, 통증, 생리 등 개인별 주요 증상"]}
  ]
}$j$::jsonb, 5, true),

((SELECT id FROM pages WHERE page_key='medicine'), 'faq', $j${
  "eyebrow": "FAQ",
  "heading": "한약 진료 FAQ",
  "items": [
    {"q": "한약은 어떤 기준으로 처방하나요?", "a": "한약은 부족한 부분을 채우는 보약이 필요한 경우도 있고, 몸 안의 순환이 막혀 먼저 풀어주어야 하는 경우도 있습니다. 본원은 맥진·설진·복진과 생활 패턴, 증상 변화를 함께 확인해 보충, 순환, 배출 중 어떤 방향이 먼저 필요한지 구분합니다."},
    {"q": "보약 중심 한약과 순환·배출을 돕는 한약은 어떻게 다른가요?", "a": "보약 중심 한약은 기력, 체력, 회복력처럼 부족한 부분을 채우는 데 초점을 둡니다. 반면 순환과 배출을 돕는 한약은 몸이 무겁거나 붓고, 소화가 막히고, 흐름이 정체된 상태를 먼저 풀어주는 데 초점을 둡니다. 본원은 두 방향의 우선순위를 구분해 처방 방향을 정합니다."},
    {"q": "톡바른경희한의원의 한약은 어떤 점을 중요하게 보나요?", "a": "복용 중 어떤 변화가 생기는지 확인하고, 이후 진료에서 남은 증상을 더 정확히 전달할 수 있도록 안내하는 것을 중요하게 봅니다. 성인 기준으로 물을 제외한 순수 한약재를 2kg 이상 사용하는 원칙을 두고 있습니다."},
    {"q": "한약 설명서를 자세히 써주는 이유는 무엇인가요?", "a": "환자가 본인 몸 상태와 치료 방향을 이해해야 복용 중 변화를 잘 확인할 수 있기 때문입니다. 어려운 한의학 용어를 그대로 전달하기보다 일상적으로 와닿는 말로 풀어 설명하려고 합니다."},
    {"q": "피로, 수면, 소화불량이 같이 있을 때는 어떻게 보나요?", "a": "여러 증상이 함께 있을 때는 한 가지 원인으로 단정하지 않고 몸 상태를 나누어 확인합니다. 소화, 수면, 열감, 부종, 스트레스 반응을 함께 보면서 보충, 순환, 배출 중 어떤 방향이 먼저 필요한지 구분합니다."}
  ]
}$j$::jsonb, 6, true),

((SELECT id FROM pages WHERE page_key='medicine'), 'cta', $j${
  "heading": "한약 상담은 예약 후 내원을 권합니다",
  "text": "맥진·설진·복진과 함께 충분한 설명 시간이 필요할 수 있습니다.",
  "theme": "dark",
  "buttons": [
    {"label": "네이버 예약하기", "href": "https://booking.naver.com/booking/13/bizes/1171309", "style": "primary", "icon": "arrow_forward"},
    {"label": "전화 031-767-0075", "href": "tel:031-767-0075", "style": "outline", "icon": "call"},
    {"label": "자주 묻는 질문", "href": "/faq", "style": "outline", "icon": "arrow_forward"}
  ]
}$j$::jsonb, 7, true);

-- ============================================================
-- 되돌리기 (폴백 복귀): 아래 한 줄 실행 시 medicine은 기존 코드 콘텐츠로 돌아갑니다.
--   DELETE FROM page_contents WHERE page_id = (SELECT id FROM pages WHERE page_key='medicine');
-- ============================================================
