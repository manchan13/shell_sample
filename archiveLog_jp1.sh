#!/bin/bash
#
# 指定日数より前のファイルを圧縮し、さらに指定日数より古いアーカイブファイルを削除
#
ARCHIVE_DAYS=1
DELETE_DAYS=7
TARGET_DIR="$(cd $(dirname $0)/log && pwd)"
OUTPUT="${TARGET_DIR}/$(date +%Y%m%d)_log.tar.gz"

# 対象ディレクトリへ移動
cd ${TARGET_DIR}

# 圧縮するファイル(拡張子は、.logまたは.txt)のリストを作成
find ${TARGET_DIR} -daystart -mtime +${ARCHIVE_DAYS} -name '*.log' > ${TARGET_DIR}/file.list

# 圧縮対象ファイルが存在するかのチェック
NUM_LINE="$(cat ${TARGET_DIR}/file.list | wc -l)"
if [[ ${NUM_LINE} -gt 0 ]]; then

  # リストに従ってzipファイルを作成
  tar -zcf ${OUTPUT} -T ${TARGET_DIR}/file.list

  # リストに従って元ファイルを削除
  for i in "$(cat ${TARGET_DIR}/file.list)"
    do
    rm -rf ${i}
  done
else
  echo "ERROR: More than ${ARCHIVE_DAYS} days before the file does not exist !!"
  exit 1
fi

# 指定日数より古いアーカイブファイルを削除
find ${TARGET_DIR} -daystart -mtime +${DELETE_DAYS} -name "*.tar.gz" -exec rm -f {} \;

# リストファイルを削除
rm -f ${TARGET_DIR}/file.list

exit 0

