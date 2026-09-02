# 리눅스마스터 2급 2차 대비 터미널 실습 기록

리눅스마스터 2급 2차에서 자주 연결되는 파일·권한·텍스트 처리·압축·프로세스·시스템 정보 명령을 **설명만 읽지 않고 실제 Ubuntu 환경에서 실행하고 검증**하기 위한 재현 가능한 실습 저장소다.

기존 `프로그래밍기능사 작업형 대비 웹 학습도구`가 여러 과목의 문제 풀이와 채점을 다뤘다면, 이 저장소는 Linux 명령을 실제로 실행해 입력·출력·검증 결과를 남기는 데만 집중한다.

## 실습 범위

| Lab | 핵심 명령 | 검증 대상 |
|---|---|---|
| 01 기본 환경 | `pwd`, `id`, `uname` | 현재 위치·사용자·커널 출력 |
| 02 파일과 디렉터리 | `mkdir`, `touch`, `cp`, `mv`, `find` | 이동 뒤 파일 경로 |
| 03 권한 | `chmod`, `stat`, `test -x` | 실행 권한 755 |
| 04 텍스트 처리 | `grep`, `sort`, `uniq`, `wc` | ERROR 2행, 고유 사용자 3명 |
| 05 압축 | `tar`, `sha256sum` | 아카이브 생성·목록·해시 |
| 06 프로세스·시스템 | `ps`, `df`, `free`, `uptime` | 명령 성공과 출력 형식 |

## 실행

Ubuntu/Linux에서:

```bash
bash scripts/lab.sh | tee artifacts/latest-terminal-output.txt
python3 src/verify_output.py artifacts/latest-terminal-output.txt
```

GitHub Actions의 `ubuntu-latest`에서도 같은 스크립트를 실행한다. 워크플로가 성공하면 로그 안에 `LAB_STATUS=PASS`와 `CHECKS_PASSED=8`이 남는다.

## 설계 원칙

- 모든 파일 작업은 `mktemp -d`가 만든 임시 디렉터리 안에서 수행한다.
- `trap`으로 실습 종료 시 임시 디렉터리를 정리한다.
- 결과를 외우지 않고 `test`, `grep`, `wc`, `stat`으로 다시 확인한다.
- 비밀번호·사용자 계정·네트워크·패키지 설치·관리자 권한은 다루지 않는다.
- 시험 합격이나 점수 향상은 주장하지 않는다.

## 결과물

- `scripts/lab.sh`: 여섯 영역의 실제 명령 실습
- `src/verify_output.py`: 로그의 8개 검증 표식을 재검사
- `.github/workflows/linux-lab.yml`: Ubuntu 자동 실행
- `index.html`: 명령·예상 결과·체크포인트를 정리한 웹 노트
- `docs/IMR_PORTFOLIO.md`: 과정·문제 해결·한계를 정리한 IMR 원고


