-- ============================================================
-- raw-html 섹션을 구조화 블록(info-columns / card-grid)으로 교체
-- → 진료시간·전화·주소·준비사항을 admin에서 HTML 없이 칸으로 편집 가능
-- Supabase SQL Editor에 RUN. 재실행 안전(해당 raw-html만 지우고 새 블록 삽입).
-- ⚠️ 프론트엔드/백엔드 배포 완료 후 실행 (info-columns 렌더러 필요).
-- ============================================================

-- ── home: 진료시간/지도 raw-html → info-columns (sort_order 6) ──
DELETE FROM page_contents
WHERE page_id = (SELECT id FROM pages WHERE page_key = 'home') AND content_type = 'raw-html';

INSERT INTO page_contents (page_id, content_type, data, sort_order, is_active) VALUES
((SELECT id FROM pages WHERE page_key='home'), 'info-columns', $j${
  "heading": "진료시간·오시는 길",
  "bg": "neutral",
  "left": {
    "kind": "card",
    "title": "진료 안내",
    "rows": [
      {"label": "평일 (월-금)", "value": "09:00 - 20:00"},
      {"label": "토요일", "value": "09:00 - 14:00"},
      {"label": "공휴일", "value": "09:00 - 13:00"},
      {"label": "일요일", "value": "휴진", "highlight": true}
    ],
    "lines": [
      {"icon": "location_on", "text": "경기도 광주시 파발로 187 세양빌딩 2층"},
      {"icon": "call", "text": "031-767-0075", "href": "tel:031-767-0075"},
      {"icon": "local_parking", "text": "건물 내 주차장 이용 가능. 만차 시 광주시보건소·공설운동장 인근 공영주차장 안내드립니다."}
    ],
    "buttons": [
      {"label": "진료 안내 자세히", "href": "/how-to-come", "primary": true},
      {"label": "네이버 예약", "href": "https://booking.naver.com/booking/13/bizes/1171309"}
    ]
  },
  "right": {
    "kind": "map",
    "title": "톡바른경희한의원 본점",
    "addressLines": ["경기도 광주시 파발로 187", "세양빌딩 2층"],
    "sub": "(광주시보건소 앞 / 탄벌동)",
    "links": [
      {"label": "네이버 지도", "href": "https://map.naver.com/p/search/%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EA%B4%91%EC%A3%BC%EC%8B%9C%20%ED%8C%8C%EB%B0%9C%EB%A1%9C%20187"},
      {"label": "카카오맵", "href": "https://map.kakao.com/?q=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EA%B4%91%EC%A3%BC%EC%8B%9C%20%ED%8C%8C%EB%B0%9C%EB%A1%9C%20187"}
    ]
  }
}$j$::jsonb, 6, true);

-- ── how-to-come: raw-html ×3 → info-columns ×2 + card-grid (sort_order 1,2,3) ──
DELETE FROM page_contents
WHERE page_id = (SELECT id FROM pages WHERE page_key = 'how-to-come') AND content_type = 'raw-html';

INSERT INTO page_contents (page_id, content_type, data, sort_order, is_active) VALUES
((SELECT id FROM pages WHERE page_key='how-to-come'), 'info-columns', $j${
  "bg": "white",
  "left": {
    "kind": "card",
    "title": "진료시간",
    "icon": "schedule",
    "rows": [
      {"label": "평일 (월-금)", "value": "09:00 - 20:00"},
      {"label": "토요일", "value": "09:00 - 14:00"},
      {"label": "공휴일", "value": "09:00 - 13:00"},
      {"label": "일요일", "value": "휴진", "highlight": true}
    ],
    "note": {"text": "공휴일 및 임시 휴진 일정은 변동될 수 있으므로 내원 전 확인을 권합니다."}
  },
  "right": {
    "kind": "card",
    "title": "병원 정보",
    "icon": "storefront",
    "lines": [
      {"icon": "badge", "text": "톡바른경희한의원 본점"},
      {"icon": "location_on", "text": "경기도 광주시 파발로 187 세양빌딩 2층"},
      {"icon": "call", "text": "031-767-0075", "href": "tel:031-767-0075"}
    ],
    "buttons": [{"label": "전화하기", "href": "tel:031-767-0075", "primary": true}]
  }
}$j$::jsonb, 1, true),

((SELECT id FROM pages WHERE page_key='how-to-come'), 'info-columns', $j${
  "bg": "neutral",
  "left": {
    "kind": "text",
    "eyebrow": "Location",
    "heading": "오시는 길·주차",
    "paragraphs": ["경기광주 탄벌동, 광주시보건소 앞 세양빌딩 2층에 위치해 있습니다. 내원 전 지도 앱에서 톡바른경희한의원 본점 또는 경기도 광주시 파발로 187을 검색하시면 더 편하게 찾으실 수 있습니다."],
    "note": {"icon": "local_parking", "title": "주차 안내", "text": "건물 주차장을 이용하실 수 있습니다. 만차이거나 주차가 어려운 경우에는 내원 전 전화로 문의해주시면 광주시보건소·공설운동장 인근 공영주차장 등 현재 이용 가능한 방법을 안내드리겠습니다."},
    "buttons": [{"label": "전화 031-767-0075", "href": "tel:031-767-0075", "primary": true}]
  },
  "right": {
    "kind": "map",
    "title": "톡바른경희한의원 본점",
    "addressLines": ["경기도 광주시 파발로 187", "세양빌딩 2층"],
    "sub": "광주시보건소 앞 · 탄벌동",
    "links": [
      {"label": "네이버 지도에서 보기", "href": "https://map.naver.com/p/search/%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EA%B4%91%EC%A3%BC%EC%8B%9C%20%ED%8C%8C%EB%B0%9C%EB%A1%9C%20187"},
      {"label": "카카오맵에서 보기", "href": "https://map.kakao.com/?q=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EA%B4%91%EC%A3%BC%EC%8B%9C%20%ED%8C%8C%EB%B0%9C%EB%A1%9C%20187"}
    ]
  }
}$j$::jsonb, 2, true),

((SELECT id FROM pages WHERE page_key='how-to-come'), 'card-grid', $j${
  "eyebrow": "Before Visit",
  "heading": "처음 오시기 전 확인해주세요",
  "intro": "예약 후 내원하시면 대기 시간을 줄일 수 있습니다. 진료 목적에 따라 아래 내용을 준비해오시면 상담과 진료 방향을 정하는 데 도움이 됩니다.",
  "columns": 3,
  "variant": "icon-num",
  "bg": "white",
  "cards": [
    {"icon": "medication", "num": "01", "title": "한약 상담", "desc": "수면, 소화, 대변, 부종, 열감, 피로 변화처럼 평소 불편했던 증상을 메모해오시면 도움이 됩니다."},
    {"icon": "accessibility_new", "num": "02", "title": "통증·교통사고", "desc": "통증 부위, 악화되는 자세, 사고접수번호, 기존 검사 결과가 있다면 함께 가져오시면 좋습니다."},
    {"icon": "face", "num": "03", "title": "피부미용 상담", "desc": "최근 시술 이력, 사용 중인 화장품, 피부가 예민해진 계기, 원하는 다운타임 범위를 알려주시면 좋습니다."}
  ]
}$j$::jsonb, 3, true);

-- 되돌리기는 cms-seed-home.sql / cms-seed-how-to-come.sql 을 다시 RUN하면 raw-html 버전으로 복귀됩니다.
