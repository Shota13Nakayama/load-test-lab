# Oracle Database 性能試験前設定ガイド

このガイドは、Oracle Database を使用した 3 層 Web アプリケーション構成での性能試験を行う前に実施すべき設定変更について説明します。

## 1. 初期化パラメータの調整

1. データベースに接続:
[[Oracle接続]]

2. 現在の設定を確認:
   ```sql
   SHOW PARAMETER;
   ```

3. 性能試験用のパラメータ設定:
   ```sql
   ALTER SYSTEM SET statistics_level = ALL SCOPE=SPFILE;
   ALTER SYSTEM SET timed_statistics = TRUE SCOPE=SPFILE;
   ALTER SYSTEM SET sga_target = 0 SCOPE=SPFILE;
   ALTER SYSTEM SET memory_target = 0 SCOPE=SPFILE;
   ALTER SYSTEM SET sga_max_size = 4G SCOPE=SPFILE;
   ALTER SYSTEM SET db_cache_size = 3G SCOPE=SPFILE;
   ALTER SYSTEM SET shared_pool_size = 1G SCOPE=SPFILE;
   ALTER SYSTEM SET pga_aggregate_target = 2G SCOPE=SPFILE;
   ALTER SYSTEM SET processes = 300 SCOPE=SPFILE;
   ALTER SYSTEM SET sessions = 300 SCOPE=SPFILE;
   ALTER SYSTEM SET open_cursors = 300 SCOPE=SPFILE;
   ```

   注意: メモリサイズはシステムリソースに応じて適切に調整してください。

[[#参考：設定反映のため再起動]]
## 2. AWR スナップショット設定

-- DBID 確認(CDB/PDB)
![[DBID.sql]]

-- 現在の AWR 設定を表示
![[CheckAWRConfig.sql]]


2. AWR スナップショット間隔の設定:
![[SetAWRConfig.sql]]


AWRスナップショットの見積もりガイド：
[[awr-snapshot-sizing-guide]]

参考：
Jさんクラウドリフト案件だと：
```
retention => 
interval => 
で
容量：　○○MB
```

2. 手動でベースラインスナップショットを取得:

![[TakeAWRSnapshot.sql]]
![[test-img.sql]]

## 3. SQL トレースの有効化

1. セッションレベルで SQL トレースを有効化:
   ```sql
   ALTER SESSION SET STATISTICS_LEVEL = ALL;
   ALTER SESSION SET EVENTS '10046 TRACE NAME CONTEXT FOREVER, LEVEL 12';
   ```

2. インスタンスレベルで SQL トレースを有効化（注意して使用）:
   ```sql
   ALTER SYSTEM SET EVENTS '10046 TRACE NAME CONTEXT FOREVER, LEVEL 12';
   ```

## 4. テストデータの準備

1. テスト用テーブルスペースの作成:
   ```sql
   CREATE TABLESPACE performance_test
   DATAFILE '/u01/app/oracle/oradata/ORCL/performance_test01.dbf'
   SIZE 10G AUTOEXTEND ON NEXT 1G MAXSIZE UNLIMITED;
   ```

2. テストユーザーの作成:
   ```sql
   CREATE USER test_user IDENTIFIED BY test_password
   DEFAULT TABLESPACE performance_test
   QUOTA UNLIMITED ON performance_test;
   
   GRANT CONNECT, RESOURCE TO test_user;
   ```

## 5. その他の重要な設定

1. UNDO 保持期間の設定:
   ```sql
   ALTER SYSTEM SET undo_retention = 3600 SCOPE=BOTH;
   ```

2. パラレル実行の制御:
   ```sql
   ALTER SYSTEM SET parallel_max_servers = 16 SCOPE=BOTH;
   ```

3. ログバッファサイズの調整:
   ```sql
   ALTER SYSTEM SET log_buffer = 128M SCOPE=SPFILE;
   ```

## 6. 性能試験後の確認事項

1. AWR レポートの生成:
   ```sql
   @?/rdbms/admin/awrrpt.sql
   ```

2. SQL トレースファイルの解析:
   ```
   tkprof <trace_file_name>.trc <output_file_name>.txt
   ```

3. 重要な性能ビューの確認:
   ```sql
   SELECT * FROM v$sysstat WHERE name IN ('db block gets', 'consistent gets', 'physical reads');
   SELECT * FROM v$system_event ORDER BY time_waited DESC;
   SELECT * FROM v$sqlarea ORDER BY elapsed_time DESC;
   ```

これらの設定を行うことで、性能試験のための環境が整います。試験後は必ず設定を元に戻すことを忘れないでください。また、実際の運用環境とテスト環境の違いを考慮し、結果の解釈には注意が必要です。


### 参考：設定反映のため再起動
・データベースを再起動して変更を適用:
 ```sql
SHUTDOWN IMMEDIATE;
STARTUP;
```

・dockerコンテナを再起動する場合
```
docker container restart -it oracle19c
docker container exec -it oracle19c sqlplus / as sysdba
```
