# 검증 계획 및 결과

## 로컬 정적 검증

- Python 로그 검증기 단위 테스트 3개
- Bash 문법 검사: Ubuntu GitHub Actions의 `bash -n`
- 삭제 대상은 `mktemp -d` 반환값으로 한정
- 관리자 권한·패키지 설치·네트워크 설정 명령 0개

## Ubuntu 실제 실행 검증

워크플로: `.github/workflows/linux-lab.yml`

성공 조건:

1. `scripts/lab.sh` 종료 코드 0
2. `CHECKS_PASSED=8`
3. `LAB_STATUS=PASS`
4. `verify_output.py`가 필수 표식 8개 확인
5. 실행 로그가 `linux-terminal-lab-output` 아티팩트로 생성

## 2026-09-03 실행 결과

- GitHub Actions run: `33694870725`
- 환경: Ubuntu 24.04.4 LTS (`ubuntu-24.04`)
- 워크플로 결론: `success`
- Bash 문법 검사: 통과
- 여섯 실습 실행: 통과
- Python 로그 검증: `verification passed: 8 markers`
- 최종 표식: `CHECKS_PASSED=8`, `LAB_STATUS=PASS`
- 로그 아티팩트 SHA-256: `47f4c7e47121b2418d914b11d13b9b360836af51d73b43482b168bf47531d608`
- 원본 로그: `artifacts/latest-terminal-output.txt`

첫 실행에서 파일 끝의 CRLF 때문에 `$'\\r': command not found`가 표시되었지만 파이프라인이 이를 숨겼다. Bash 파일을 LF로 다시 올리고 워크플로에 `set -o pipefail`을 추가했다. 위 결과는 수정 후 새로 실행한 run 33694870725의 깨끗한 로그다.

## 주장하지 않는 내용

- 리눅스마스터 합격 또는 점수 향상
- 공식 기출문제 재현
- 관리자 권한 실습 완료
- 장기간 반복 학습 효과
