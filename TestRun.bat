@echo off
REM Jekyll 서버를 실행하는 배치 파일

REM 현재 디렉토리 확인
echo 현재 디렉토리: %cd%

REM bundle exec jekyll serve 실행
echo Jekyll 서버를 시작합니다...
bundle exec jekyll serve

REM 서버 실행 후 창이 닫히지 않도록 대기
pause
