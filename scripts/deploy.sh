#!/bin/bash
# AiDocPlus-Main deploy.sh
# 将主程序源码部署到 AiDocPlus/ 构建目标
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MAIN_DIR="$(dirname "$SCRIPT_DIR")"
PARENT_DIR="$(dirname "$MAIN_DIR")"
TARGET_DIR="${PARENT_DIR}/AiDocPlus"

echo "[deploy] AiDocPlus-Main -> ${TARGET_DIR}"

# 确保目标目录存在
mkdir -p "${TARGET_DIR}"

# 同步主程序源码到构建目标（排除不需要的文件）
rsync -av --delete \
  --exclude='node_modules' \
  --exclude='.git' \
  --exclude='.github' \
  --exclude='.turbo' \
  --exclude='target' \
  --exclude='.DS_Store' \
  --exclude='plugins-repo' \
  --exclude='.claude' \
  --exclude='scripts/deploy.sh' \
  --exclude='pnpm-lock.yaml' \
  --exclude='packages/shared-types/src/generated/*.generated.ts' \
  --exclude='apps/desktop/src-tauri/bundled-resources' \
  --exclude='apps/desktop/src-ui/src/plugins/*/'\
  "${MAIN_DIR}/" "${TARGET_DIR}/"

# 确保 generated 目录存在（各资源仓库 deploy 写入）
mkdir -p "${TARGET_DIR}/packages/shared-types/src/generated"

echo "[done] AiDocPlus-Main deployed successfully"
