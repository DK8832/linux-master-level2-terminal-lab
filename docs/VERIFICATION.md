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

## 주장하지 않는 내용

- 리눅스마스터 합격 또는 점수 향상
- 공식 기출문제 재현
- 관리자 권한 실습 완료
- 장기간 반복 학습 효과


