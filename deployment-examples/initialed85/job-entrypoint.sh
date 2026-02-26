#!/bin/bash

set -e

log_file="/tmp/bazel-job-entrypoint-pid-${BAZEL_INVOCATION_ID}-${BAZEL_OPERATION_ID}-$$-$(date '+%s%3N').log"

echo -n "" >"${log_file}"

# shellcheck disable=SC2129
pwd >>"${log_file}"
echo "" >>"${log_file}"

# shellcheck disable=SC2129
env >>"${log_file}"
echo "" >>"${log_file}"

# e.g. (this script)
# shellcheck disable=SC2129
echo "0: ${0}" >>"${log_file}"
echo "" >>"${log_file}"

# e.g. bash
# shellcheck disable=SC2129
echo "1: ${1}" >>"${log_file}"
echo "" >>"${log_file}"

# e.g. -c
# shellcheck disable=SC2129
echo "2: ${2}" >>"${log_file}"
echo "" >>"${log_file}"

# e.g. (massive string containing bazel job)
# shellcheck disable=SC2129
echo "3: ${3}" >>"${log_file}"
echo "" >>"${log_file}"

echo "${3}" >./job-run.sh
chmod +x ./job-run.sh

exec > >(tee -a "${log_file}") 2> >(tee -a "${log_file}" >&2)

exec ./job-run.sh
