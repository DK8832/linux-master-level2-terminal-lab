#!/usr/bin/env bash
set -euo pipefail

LAB_ROOT="$(mktemp -d)"
trap 'rm -rf -- "$LAB_ROOT"' EXIT
cd "$LAB_ROOT"

pass_count=0
check() {
  local label="$1"
  shift
  if "$@"; then
    printf 'CHECK PASS | %s\n' "$label"
    pass_count=$((pass_count + 1))
  else
    printf 'CHECK FAIL | %s\n' "$label" >&2
    exit 1
  fi
}

printf '=== LAB 01: ENVIRONMENT ===\n'
printf 'PWD=%s\n' "$(pwd)"
printf 'USER_ID=%s\n' "$(id -u)"
printf 'KERNEL=%s\n' "$(uname -s)"
check 'kernel is Linux' test "$(uname -s)" = 'Linux'

printf '\n=== LAB 02: FILES ===\n'
mkdir -p workspace/inbox workspace/archive
printf 'alpha\n' > workspace/inbox/a.txt
printf 'beta\n' > workspace/inbox/b.txt
cp workspace/inbox/a.txt workspace/inbox/a-copy.txt
mv workspace/inbox/b.txt workspace/archive/b.txt
find workspace -type f -printf '%P\n' | sort
check 'moved file exists' test -f workspace/archive/b.txt
check 'source file was moved' test ! -e workspace/inbox/b.txt

printf '\n=== LAB 03: PERMISSIONS ===\n'
cat > workspace/run.sh <<'SCRIPT'
#!/usr/bin/env bash
printf 'permission-ok\n'
SCRIPT
chmod 755 workspace/run.sh
mode="$(stat -c '%a' workspace/run.sh)"
printf 'MODE=%s\n' "$mode"
workspace/run.sh
check 'script mode is 755' test "$mode" = '755'
check 'script is executable' test -x workspace/run.sh

printf '\n=== LAB 04: TEXT PIPELINE ===\n'
cat > workspace/app.log <<'LOG'
INFO user=jiyeol action=start
ERROR user=jiyeol action=read
INFO user=mina action=start
ERROR user=seo action=write
INFO user=mina action=end
LOG
grep '^ERROR' workspace/app.log | tee workspace/errors.log
error_count="$(wc -l < workspace/errors.log | tr -d ' ')"
unique_users="$(awk '{for(i=1;i<=NF;i++) if($i ~ /^user=/){split($i,a,"="); print a[2]}}' workspace/app.log | sort -u | wc -l | tr -d ' ')"
printf 'ERROR_COUNT=%s\n' "$error_count"
printf 'UNIQUE_USERS=%s\n' "$unique_users"
check 'two error lines' test "$error_count" = '2'
check 'three unique users' test "$unique_users" = '3'

printf '\n=== LAB 05: ARCHIVE ===\n'
tar -czf workspace-log.tar.gz -C workspace app.log errors.log
printf 'ARCHIVE_CONTENTS\n'
tar -tzf workspace-log.tar.gz | sort
printf 'ARCHIVE_SHA256=%s\n' "$(sha256sum workspace-log.tar.gz | awk '{print $1}')"
check 'archive is not empty' test -s workspace-log.tar.gz

printf '\n=== LAB 06: PROCESS AND SYSTEM ===\n'
printf 'PROCESS_SAMPLE\n'
ps -eo pid,comm --sort=pid | head -n 6 || true
printf 'DISK_ROOT\n'
df -h / | tail -n 1
printf 'MEMORY\n'
free -h | head -n 2
printf 'UPTIME\n'
uptime

printf '\nCHECKS_PASSED=%s\n' "$pass_count"
if [ "$pass_count" -eq 8 ]; then
  printf 'LAB_STATUS=PASS\n'
else
  printf 'LAB_STATUS=FAIL\n' >&2
  exit 1
fi
