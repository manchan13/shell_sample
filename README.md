# shell_sample


# cron設定

cron確認
```
crontab -l
```

cron設定
```
crontab -e

#分 時 日 月 曜日 コマンド
#2時間ごとに実行
0 */2 * * * /var/log/sample/createLog.sh
```

