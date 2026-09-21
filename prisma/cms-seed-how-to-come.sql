-- ============================================================
-- how-to-come(진료 안내) 페이지 콘텐츠 → 블록 이식
-- Supabase SQL Editor에 RUN. 재실행 안전. 프론트엔드 배포 완료.
-- 진료시간/지도/준비사항 섹션은 2단 bespoke 레이아웃이라 raw-html로 현재 HTML 그대로 재현.
-- ============================================================
DELETE FROM page_contents WHERE page_id = (SELECT id FROM pages WHERE page_key = 'how-to-come');

INSERT INTO page_contents (page_id, content_type, data, sort_order, is_active) VALUES
((SELECT id FROM pages WHERE page_key='how-to-come'), 'hero', $j${
  "breadcrumb": "홈 > 진료 안내",
  "eyebrow": "Guide",
  "title": "진료시간·예약·<span class='text-primary'>오시는 길</span>",
  "subtitle": "톡바른경희한의원 본점의 진료시간, 예약 방법, 오시는 길, 주차 안내를 한곳에 정리했습니다. 내원 전 확인하시면 더 편하게 방문하실 수 있습니다.",
  "theme": "light",
  "bg": { "type": "color", "value": "" },
  "buttons": [
    { "label": "네이버 예약", "href": "https://booking.naver.com/booking/13/bizes/1171309", "style": "primary", "icon": "arrow_forward" },
    { "label": "전화 031-767-0075", "href": "tel:031-767-0075", "style": "outline", "icon": "call" }
  ]
}$j$::jsonb, 0, true),

((SELECT id FROM pages WHERE page_key='how-to-come'), 'raw-html', $j${
  "bg": "white",
  "html": "<div class='max-w-7xl mx-auto px-4 sm:px-6 lg:px-8'><div class='grid lg:grid-cols-2 gap-8'><div class='bg-neutral-50 rounded-3xl p-10 border border-neutral-100'><div class='flex items-center gap-3 mb-8'><span class='material-symbols-outlined text-primary text-3xl'>schedule</span><h2 class='text-2xl font-bold text-neutral-900'>진료시간</h2></div><div class='space-y-4 mb-6'><div class='flex justify-between items-center py-3 border-b border-neutral-200'><span class='font-medium text-neutral-700'>평일 (월-금)</span><span class='font-bold text-neutral-900'>09:00 - 20:00</span></div><div class='flex justify-between items-center py-3 border-b border-neutral-200'><span class='font-medium text-neutral-700'>토요일</span><span class='font-bold text-neutral-900'>09:00 - 14:00</span></div><div class='flex justify-between items-center py-3 border-b border-neutral-200'><span class='font-medium text-neutral-700'>공휴일</span><span class='font-bold text-neutral-900'>09:00 - 13:00</span></div><div class='flex justify-between items-center py-3'><span class='font-medium text-primary'>일요일</span><span class='font-bold text-primary'>휴진</span></div></div><p class='text-xs text-neutral-500 leading-relaxed'>공휴일 및 임시 휴진 일정은 변동될 수 있으므로 내원 전 확인을 권합니다.</p></div><div class='bg-neutral-50 rounded-3xl p-10 border border-neutral-100'><div class='flex items-center gap-3 mb-8'><span class='material-symbols-outlined text-primary text-3xl'>storefront</span><h2 class='text-2xl font-bold text-neutral-900'>병원 정보</h2></div><div class='space-y-5 mb-8'><div><p class='text-xs font-bold text-primary tracking-widest uppercase mb-1'>상호</p><p class='text-lg font-bold text-neutral-900'>톡바른경희한의원 본점</p></div><div><p class='text-xs font-bold text-primary tracking-widest uppercase mb-1'>주소</p><p class='text-neutral-700'>경기도 광주시 파발로 187<br />세양빌딩 2층</p></div><div><p class='text-xs font-bold text-primary tracking-widest uppercase mb-1'>전화</p><a href='tel:031-767-0075' class='text-lg font-bold text-neutral-900 hover:text-primary transition-colors'>031-767-0075</a></div></div><a href='tel:031-767-0075' class='w-full px-6 py-4 bg-neutral-900 text-white rounded-lg font-bold hover:bg-neutral-800 transition-all flex items-center justify-center gap-2'><span class='material-symbols-outlined'>call</span>전화하기</a></div></div></div>"
}$j$::jsonb, 1, true),

((SELECT id FROM pages WHERE page_key='how-to-come'), 'raw-html', $j${
  "bg": "neutral",
  "html": "<div class='max-w-7xl mx-auto px-4 sm:px-6 lg:px-8'><div class='grid lg:grid-cols-2 gap-12'><div><p class='text-sm font-bold text-primary tracking-widest uppercase mb-3'>Location</p><h2 class='text-3xl md:text-4xl font-bold mb-6 leading-tight'>오시는 길·주차</h2><p class='text-neutral-600 leading-relaxed mb-5'>경기광주 탄벌동, 광주시보건소 앞 세양빌딩 2층에 위치해 있습니다. 내원 전 지도 앱에서 <strong class='text-neutral-900'>톡바른경희한의원 본점</strong> 또는 <strong class='text-neutral-900'>경기도 광주시 파발로 187</strong>을 검색하시면 더 편하게 찾으실 수 있습니다.</p><div class='bg-white rounded-2xl p-6 border-2 border-primary/20 mb-6'><div class='flex items-start gap-3'><span class='material-symbols-outlined text-primary text-2xl flex-shrink-0'>local_parking</span><div><h3 class='font-bold text-neutral-900 mb-2'>주차 안내</h3><p class='text-sm text-neutral-600 leading-relaxed'>건물 주차장을 이용하실 수 있습니다. 만차이거나 주차가 어려운 경우에는 내원 전 전화로 문의해주시면 광주시보건소·공설운동장 인근 공영주차장 등 현재 이용 가능한 방법을 안내드리겠습니다.</p></div></div></div><a href='tel:031-767-0075' class='inline-flex items-center gap-2 px-6 py-3 bg-primary text-white rounded-lg font-bold hover:bg-primary-dark transition-all'><span class='material-symbols-outlined'>call</span>전화 031-767-0075</a></div><div class='rounded-3xl overflow-hidden shadow-lg min-h-[400px] border border-neutral-200 bg-gradient-to-br from-primary-surface to-white relative flex items-center justify-center p-10'><div class='text-center'><span class='material-symbols-outlined text-primary text-7xl mb-4'>location_on</span><h3 class='text-xl font-bold text-neutral-900 mb-2'>톡바른경희한의원 본점</h3><p class='text-neutral-600 mb-2'>경기도 광주시 파발로 187</p><p class='text-neutral-600 mb-6'>세양빌딩 2층</p><p class='text-sm text-neutral-500 mb-6'>광주시보건소 앞 · 탄벌동</p><div class='flex flex-wrap gap-2 justify-center'><a href='https://map.naver.com/p/search/%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EA%B4%91%EC%A3%BC%EC%8B%9C%20%ED%8C%8C%EB%B0%9C%EB%A1%9C%20187' target='_blank' rel='noopener noreferrer' class='px-4 py-2 bg-white border border-primary/30 text-primary rounded-lg font-bold text-sm hover:bg-primary hover:text-white transition-all'>네이버 지도에서 보기</a><a href='https://map.kakao.com/?q=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EA%B4%91%EC%A3%BC%EC%8B%9C%20%ED%8C%8C%EB%B0%9C%EB%A1%9C%20187' target='_blank' rel='noopener noreferrer' class='px-4 py-2 bg-white border border-primary/30 text-primary rounded-lg font-bold text-sm hover:bg-primary hover:text-white transition-all'>카카오맵에서 보기</a></div></div></div></div></div>"
}$j$::jsonb, 2, true),

((SELECT id FROM pages WHERE page_key='how-to-come'), 'raw-html', $j${
  "bg": "white",
  "html": "<div class='max-w-7xl mx-auto px-4 sm:px-6 lg:px-8'><div class='text-center mb-16'><p class='text-sm font-bold text-primary tracking-widest uppercase mb-3'>Before Visit</p><h2 class='text-3xl md:text-4xl font-bold mb-4 leading-tight'>처음 오시기 전 확인해주세요</h2><p class='text-neutral-500 max-w-3xl mx-auto leading-relaxed'>예약 후 내원하시면 대기 시간을 줄일 수 있습니다. 진료 목적에 따라 아래 내용을 준비해오시면 상담과 진료 방향을 정하는 데 도움이 됩니다.</p></div><div class='grid md:grid-cols-3 gap-6'><div class='bg-neutral-50 rounded-2xl p-8 border border-neutral-100 hover:border-primary/40 transition-colors'><div class='w-12 h-12 bg-primary-surface text-primary rounded-xl flex items-center justify-center mb-5'><span class='material-symbols-outlined text-2xl'>medication</span></div><p class='text-xs font-bold text-primary mb-2'>01</p><h3 class='text-xl font-bold mb-3 text-neutral-900'>한약 상담</h3><p class='text-neutral-600 leading-relaxed'>수면, 소화, 대변, 부종, 열감, 피로 변화처럼 평소 불편했던 증상을 메모해오시면 도움이 됩니다.</p></div><div class='bg-neutral-50 rounded-2xl p-8 border border-neutral-100 hover:border-primary/40 transition-colors'><div class='w-12 h-12 bg-primary-surface text-primary rounded-xl flex items-center justify-center mb-5'><span class='material-symbols-outlined text-2xl'>accessibility_new</span></div><p class='text-xs font-bold text-primary mb-2'>02</p><h3 class='text-xl font-bold mb-3 text-neutral-900'>통증·교통사고</h3><p class='text-neutral-600 leading-relaxed'>통증 부위, 악화되는 자세, 사고접수번호, 기존 검사 결과가 있다면 함께 가져오시면 좋습니다.</p></div><div class='bg-neutral-50 rounded-2xl p-8 border border-neutral-100 hover:border-primary/40 transition-colors'><div class='w-12 h-12 bg-primary-surface text-primary rounded-xl flex items-center justify-center mb-5'><span class='material-symbols-outlined text-2xl'>face</span></div><p class='text-xs font-bold text-primary mb-2'>03</p><h3 class='text-xl font-bold mb-3 text-neutral-900'>피부미용 상담</h3><p class='text-neutral-600 leading-relaxed'>최근 시술 이력, 사용 중인 화장품, 피부가 예민해진 계기, 원하는 다운타임 범위를 알려주시면 좋습니다.</p></div></div></div>"
}$j$::jsonb, 3, true),

((SELECT id FROM pages WHERE page_key='how-to-come'), 'callout', $j${
  "eyebrow": "Non-covered Fee",
  "heading": "비급여 안내",
  "text": "비급여 항목과 비용은 진료 항목, 부위, 범위에 따라 달라질 수 있습니다. 정확한 비용은 진료 항목과 범위를 확인한 뒤 원내 고지 자료와 상담 안내를 기준으로 말씀드립니다.",
  "theme": "surface"
}$j$::jsonb, 4, true),

((SELECT id FROM pages WHERE page_key='how-to-come'), 'faq', $j${
  "eyebrow": "FAQ",
  "heading": "진료 안내 FAQ",
  "items": [
    {"q": "예약은 어떻게 하나요?", "a": "예약은 전화로 문의해주시면 안내드리겠습니다. 운영 중인 예약 채널은 홈페이지에서 함께 확인하실 수 있습니다."},
    {"q": "초진 때 무엇을 준비하면 좋나요?", "a": "복용 중인 약, 검사 결과, 사고접수번호, 기존 치료 이력, 피부 시술 이력 등이 있다면 가져오시면 진료 방향을 정하는 데 도움이 됩니다."},
    {"q": "비급여 비용은 어디에서 확인하나요?", "a": "비급여 항목과 비용은 진료 항목, 부위, 범위에 따라 달라질 수 있습니다. 내원 시 원내 고지 자료와 상담 안내를 통해 확인하실 수 있습니다."},
    {"q": "주차는 가능한가요?", "a": "건물 주차장을 이용하실 수 있습니다. 만차이거나 주차가 어려운 경우에는 내원 전 전화로 문의해주시면 이용 가능한 방법을 안내드리겠습니다."},
    {"q": "진료시간은 어떻게 되나요?", "a": "평일 09:00~20:00 / 토요일 09:00~14:00 / 공휴일 09:00~13:00 / 일요일 휴진입니다. 공휴일 일정은 변동될 수 있어 내원 전 확인을 권합니다."}
  ]
}$j$::jsonb, 5, true);

-- 되돌리기: DELETE FROM page_contents WHERE page_id = (SELECT id FROM pages WHERE page_key='how-to-come');
