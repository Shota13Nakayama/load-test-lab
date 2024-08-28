# JPetStore Oracle移行手順

## 1. Oracle環境の準備

1. Oracleデータベースをインストールし、設定します。
2. JPetStore用の新しいデータベースとユーザーを作成します：

[[oracle-create-user-with-tablespaces#ベストプラクティス]]
```sql
CREATE USER JPETSTORE IDENTIFIED BY "Mypassword" DEFAULT TABLESPACE app_data TEMPORARY TABLESPACE temp QUOTA UNLIMITED ON app_data;
```
```
GRANT CONNECT, RESOURCE TO jpetstore;
```


## 2. プロジェクトの依存関係の更新

★以降に必要な資材について、動作確認が済んでいるファイルは以下に置いている。

```
github/Obsidian/02-Application/WebApp/SampleApplication/JPetstore/20240812-JPetstoreOnWSL2/Oracle-Sizai
```
上記を格納すればおｋ
```
cd /home/naka/dev/20240812-JPetStore/jpetstore-6
``` 
プロジェクトフォルダ
```
naka@Level:~/dev/20240812-JPetStore/jpetstore-6$ ls -l
total 84
-rw-r--r--  1 naka naka   754 Aug 25 13:31 Dockerfile
-rw-r--r--  1 naka naka 11360 Aug 25 13:31 LICENSE
-rw-r--r--  1 naka naka   627 Aug 25 13:31 LICENSE_HEADER
-rw-r--r--  1 naka naka  2594 Aug 25 13:31 NOTICE
-rw-r--r--  1 naka naka  2971 Aug 25 13:31 README.md
-rw-r--r--  1 naka naka   781 Aug 25 13:31 docker-compose.yaml
-rw-r--r--  1 naka naka   762 Aug 25 13:31 format.xml
-rwxr-xr-x  1 naka naka 11173 Aug 25 13:31 mvnw
-rw-r--r--  1 naka naka  7698 Aug 25 13:31 mvnw.cmd
-rw-r--r--  1 naka naka 15791 Aug 25 13:31 pom.xml
-rw-r--r--  1 naka naka   114 Aug 25 13:31 renovate.json
drwxr-xr-x  5 naka naka  4096 Aug 25 13:31 src
drwxr-xr-x 12 naka naka  4096 Aug 25 13:32 target
```

```
cp -rp /mnt/c/Users/jmpda/Documents/github/Obsidian/0
2-Application/WebApp/SampleApplication/JPetstore/20240812-JPetstoreOnWSL2/Oracle-Sizai/* ./
```

この手順を実施した場合、すぐにビルド可能。変更箇所など詳細は以下参照のこと。


1. `pom.xml` ファイルを編集し、MySQL依存関係を削除して Oracle JDBC ドライバーを追加します：

jdbc11の場合
```xml
<dependency>
    <groupId>com.oracle.database.jdbc</groupId>
    <artifactId>ojdbc11</artifactId>
    <version>21.5.0.0</version>
</dependency>
```

jdbc8
```xml
<dependency>
    <groupId>com.oracle.database.jdbc</groupId>
    <artifactId>ojdbc8</artifactId>
    <version>21.5.0.0</version>
</dependency>
```

## 3. データベース接続設定の変更

1. src/main/webapp/WEB-INF/applicationContext.xml ファイルを編集し、データソース設定を変更します：

```xml
<bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
    <property name="driverClassName" value="oracle.jdbc.OracleDriver"/>
    <property name="url" value="jdbc:oracle:thin:@localhost:1521/ORCLPDB"/>
    <property name="username" value="jpetstore"/>
    <property name="password" value="your_password"/>
</bean>
```


## 4. SQL文の修正

1. MyBatisのマッパーXMLファイル（src/main/resources/org/mybatis/jpetstore/mapper/内）を確認し、Oracle固有のSQL構文に合わせて修正します。

```
cd src/main/resources/org/mybatis/jpetstore/mapper/
```

主な変更点：
- `LIMIT` 句を `ROWNUM` を使用した形式に変更
- 日付/時間関数の調整
- シーケンス生成の方法の変更

例：
```xml
<!-- MySQL -->
<select id="getRecentOrders" resultType="Order">
    SELECT * FROM ORDERS ORDER BY ORDERDATE DESC LIMIT 5
</select>

<!-- Oracle -->
<select id="getRecentOrders" resultType="Order">
    SELECT * FROM (
        SELECT * FROM ORDERS ORDER BY ORDERDATE DESC
    ) WHERE ROWNUM <= 5
</select>
```

Claude3にxml提供して、Ｏｒａｃｌｅ用を作ってもらった。


資材↓![[OrderMapper-oracle.xml]]![[ProductMapper-oracle.xml]]![[SequenceMapper-oracle.xml]]
![[AccountMapper-oracle.xml]]

Oracle用、ＭｙＳＱＬ用を分けて、バックアップしておいた。
![[Pasted image 20240824153544.png]]

## 5. スキーマとデータの移行

1. 既存のMySQLスキーマスクリプトをOracleに適合するように修正します。
2. データ移行スクリプトを作成し、実行します。

例：シーケンスの作成
```sql
CREATE SEQUENCE order_seq START WITH 1000 INCREMENT BY 1;
```

```
cd src/main/resources/database/
```

##### 資材↓
![[oracle-schema.sql]]

![[oracle-dataload.sql]]

資材をコンテナ内に送る。
```
docker cp ./oracle-dataload.sql oracle19c:/home/oracle/
```
```
docker cp ./oracle-schema.sql oracle19c:/home/oracle/
```

SQL実行する。
```
docker exec -it oracle19c sqlplus JPETSTORE/"Mypassword"@ORCLPDB
```
```
@oracle-schema.sql
```
```
@oracle-dataload.sql
```
## 6. アプリケーションのビルドとテスト

1. プロジェクトをクリーンビルドします：
   ```
   ./mvnw clean package -DskipTests
   ```

2. アプリケーションを起動し、テストします：
   ```
   ./mvnw cargo:run -P tomcat90
   ```

##### やり直したい場合は以下。

Oracle接続確認まで行けず。
Fishや、Sign-on後のj2eeログインなどを押すと、Javaの500エラーになった。
おそらくJDBCが接続できていないか何か。

[[jpetstore-oracle-migration やり直し]]

## 7. トラブルシューティング

- Oracleの接続エラーが発生した場合、TNSリスナーの設定を確認してください。
- SQL構文エラーが発生した場合、該当するマッパーXMLファイルを確認し、Oracle構文に適合しているか確認してください。
- パフォーマンスの問題が発生した場合、Oracleに適したインデックスの作成やクエリの最適化を検討してください。

## 注意点

- Oracleは大文字小文字を区別します。テーブル名やカラム名の大文字小文字の使用に注意してください。
- OracleとMySQLでは日付/時間の扱いが異なる場合があります。日付関連の操作を確認してください。
- トランザクション管理やコネクションプーリングの設定を確認し、必要に応じて調整してください。

この移行プロセスは複雑な場合があります。段階的にアプローチし、各ステップでテストを行うことをお勧めします。
