#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
# List unique package names touched between two commits (LibreELEC packages/).
# Usage: scripts/ci/list-pr-packages.sh BASE_SHA HEAD_SHA
# Requires a git checkout where changed paths can be resolved (see resolve_pkg).

set -euo pipefail

if [[ "${#}" -ne 2 ]]; then
  echo "usage: ${0} BASE_SHA HEAD_SHA" >&2
  exit 2
fi

BASE_SHA="${1}"
HEAD_SHA="${2}"

resolve_pkg() {
  local rel="$1"
  [[ "${rel}" == packages/* ]] || return 1
  [[ "${rel}" == packages ]] && return 1

  local dir
  if [[ -f "${rel}" ]]; then
    dir="$(dirname "${rel}")"
  elif [[ -d "${rel}" ]]; then
    dir="${rel}"
  else
    dir="$(dirname "${rel}")"
  fi

  while [[ "${dir}" == packages/* ]] || [[ "${dir}" == packages ]]; do
    if [[ -f "${dir}/package.mk" ]]; then
      basename "${dir}"
      return 0
    fi
    [[ "${dir}" == "packages" ]] && break
    dir="$(dirname "${dir}")"
  done
  return 1
}

declare -A seen=()

while IFS= read -r -d '' rel; do
  pkg="$(resolve_pkg "${rel}" || true)"
  [[ -n "${pkg:-}" ]] || continue
  seen["${pkg}"]=1
done < <(git diff --name-only -z "${BASE_SHA}" "${HEAD_SHA}")

if [[ "${#seen[@]}" -eq 0 ]]; then
  exit 0
fi

mapfile -t sorted < <(printf '%s\n' "${!seen[@]}" | LC_ALL=C sort -u)
printf '%s\n' "${sorted[@]}"
