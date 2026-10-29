HEUNG STUDIO 홈페이지 + Design Work 관리자 기능
==================================================

포함 파일
- index.html : 방문자용 홈페이지
- admin.html : 작품 추가/수정/삭제 관리자 페이지
- config.js : 온라인 저장소 설정값
- supabase_setup.sql : 데이터베이스와 이미지 저장 권한 설정 SQL

중요
이 패키지는 관리자 화면과 연동 코드를 포함한 설치용 파일입니다.
아직 도메인/호스팅/온라인 저장소가 설정되지 않았으므로 바로 공개된 사이트가 된 것은 아닙니다.
Supabase 연결 설정을 완료해야 작품 업로드 및 홈페이지 반영이 실제로 작동합니다.

1) Supabase 프로젝트 만들기
- https://supabase.com/ 에서 계정을 만들고 New project를 선택합니다.
- 프로젝트가 만들어지면 Project Settings > API (또는 Connect)에서 Project URL과 anon/public key를 복사합니다.
- service_role key는 절대 사용하거나 공개하지 마세요.

2) 데이터베이스/이미지 저장 설정
- Supabase 프로젝트의 SQL Editor를 엽니다.
- 이 폴더의 supabase_setup.sql 내용을 붙여 넣고 Run을 실행합니다.
- Authentication > Users에서 관리자 이메일 사용자를 직접 생성합니다.
- 공개 회원가입(Signups)은 비활성화하는 것을 권장합니다. 관리자 사용자만 생성하세요.

보안 참고:
현재 SQL 정책은 로그인된 사용자에게 쓰기 권한을 줍니다. 공개 회원가입을 비활성화하고, 관리자 사용자만 직접 생성하세요.
더 엄격한 운영 보안이 필요하면 관리자 전용 역할/정책을 추가할 수 있습니다.

3) config.js 설정
파일을 텍스트 편집기로 열고 아래 값을 바꿉니다.
window.HEUNG_SUPABASE_URL = 'YOUR_SUPABASE_PROJECT_URL';
window.HEUNG_SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';

Project URL과 anon/public key만 사용하세요. service_role key는 절대 프런트엔드에 넣지 마세요.

4) 사이트 공개
- index.html, admin.html, config.js를 같은 폴더에 둡니다.
- 이 폴더를 GitHub Pages 등 정적 웹호스팅에 배포합니다.
- 관리자 페이지 주소는 사이트 주소 뒤에 /admin.html 을 붙인 주소입니다.
- 예: https://내도메인.kr/admin.html
- GitHub Pages를 사용한다면 커스텀 도메인과 DNS 설정도 별도로 해야 합니다.

5) 사용 방법
- /admin.html 접속 → 관리자 이메일/비밀번호 로그인
- 제목, 연도, 카테고리, 설명 입력 → 이미지 선택 → 저장하기
- 수정/삭제는 등록된 프로젝트 목록에서 진행
- 방문자용 홈페이지에서 새로고침하면 변경된 작품이 표시됩니다.

카테고리 키
- identity = Brand Identity
- graphic = Graphic
- package = Package
- digital = Digital

현재 홈페이지는 Supabase에 작품이 등록되어 있으면 등록된 작품을 표시합니다.
연동 전에는 데모 프로젝트가 보입니다.
