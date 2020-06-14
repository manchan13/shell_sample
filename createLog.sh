#!/bin/bash
#
# ログファイル出力
#
# 日付を出力
#

cd "$(dirname ${0})"
DATE="$(date +'%m%d')"
LOG_ERR="log/err${DATE}.log"
LOG="log/log${DATE}.log"

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >> ${LOG_ERR}
}

echo "開始:$(date)" >> ${LOG}

#引数チェック
echo "argument_Check" >> ${LOG}

if [[ $# -ne 1 ]]; then
  err "no argument"
  exit 1
fi

#メッセージをログに出力
echo "$1" >> ${LOG}


echo "終了:$(date)" >> ${LOG}

