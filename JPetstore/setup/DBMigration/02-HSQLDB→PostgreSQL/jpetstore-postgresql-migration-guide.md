# JPetstore: HSQLDBからPostgreSQLへの移行ガイド

## 1. 環境準備

### 1.1 PostgreSQLのインストール
- PostgreSQLをダウンロードしてインストールします。
- 新しいデータベースとユーザーを作成します。

#### 新しいデータベースとユーザーの作成方法

1. PostgreSQLにrootユーザー（通常は"postgres"）でログインします：
```
sudo -u postgres psql
```

2. 新しいデータベースを作成します：
```sql
CREATE DATABASE jpetstore;
```

3. 新しいユーザーを作成し、パスワードを設定します：
```sql
CREATE USER jpetstore_user WITH PASSWORD 'your_secure_password';
```

4. 新しいユーザーに対して、作成したデータベースへのすべての権限を付与します：
   ```sql
   GRANT ALL PRIVILEGES ON DATABASE jpetstore TO jpetstore_user;
   ```

5. データベースに接続し、必要なスキーマ権限を付与します：
   ```sql
   \c jpetstore
   ```

```   sql
GRANT ALL ON SCHEMA public TO jpetstore_user;
```

6. PostgreSQLを終了します：
   ```
   \q
   ```

これで、新しいデータベース "jpetstore" とユーザー "jpetstore_user" が作成され、必要な権限が付与されました。


### 1.2 JDBCドライバの追加
`pom.xml`ファイルに以下の依存関係を追加します：

```xml
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <version>42.7.2</version>
</dependency>
```

## 2. データベーススキーマの変換

### 2.1 スキーマの変換
`src/main/resources/database/jpetstore-hsqldb-schema.sql`を`jpetstore-postgresql-schema.sql`としてコピーし、以下の変更を行います：

- `VARCHAR(XXX)` を `VARCHAR(XXX)`のままにします（PostgreSQLでも同じ構文）。
- `BIGINT` を `BIGINT`のままにします。
- HSQLDBの自動増分構文を PostgreSQLの `SERIAL` に変更します。
  例： `ORDERID INT NOT NULL IDENTITY` → `ORDERID SERIAL PRIMARY KEY`

変更後資材↓
![[postgresql-schema.sql]]
### 2.2 データの変換
`src/main/resources/database/jpetstore-hsqldb-data.sql`を`postgresql-data.sql`としてコピーし、以下の変更を行います：

- 日付形式を `YYYY-MM-DD` に統一します。
- シーケンス関連のINSERT文を削除または修正します（PostgreSQLではシーケンスが自動的に管理されます）。

変更後資材↓
![[postgresql-data.sql]]


### 2.3 データロード実行と、データの確認

#### データロード前の準備:

まず、PostgreSQLデータベースに接続します。

```bash
psql -h localhost -U jpetstore_user -d jpetstore
```

##### 既存のデータの確認
データをロードする前に、既存のデータがないことを確認します。

```sql
SELECT COUNT(*) FROM supplier;
SELECT COUNT(*) FROM signon;
SELECT COUNT(*) FROM account;
-- 他のテーブルも同様に確認
```

各テーブルの行数が0であることを確認します。

##### スキーマの作成
まず、スキーマをロードします。

```bash
psql -h localhost -U jpetstore_user -d jpetstore -f postgresql-schema.sql
```

##### データの挿入
次に、データをロードします。

```bash
psql -h localhost -U jpetstore_user -d jpetstore -f postgresql-data.sql
```

#### データロード後の確認

##### テーブルの存在確認
すべてのテーブルが正しく作成されたことを確認します。

```
psql -h localhost -U jpetstore_user -d jpetstore
```

```sql
\dt
```

これにより、データベース内のすべてのテーブルのリストが表示されます。

##### データの確認
各テーブルのデータ数を確認します。

```sql
SELECT COUNT(*) FROM supplier;
SELECT COUNT(*) FROM signon;
SELECT COUNT(*) FROM account;
SELECT COUNT(*) FROM profile;
SELECT COUNT(*) FROM bannerdata;
SELECT COUNT(*) FROM category;
SELECT COUNT(*) FROM product;
SELECT COUNT(*) FROM item;
SELECT COUNT(*) FROM inventory;
```

各テーブルの行数が期待通りであることを確認します。

##### サンプルデータの確認
いくつかのテーブルからサンプルデータを取得して、内容を確認します。

```sql
SELECT * FROM supplier LIMIT 5;
SELECT * FROM product LIMIT 5;
SELECT * FROM item LIMIT 5;
```

データの内容が正しいことを確認します。

##### シーケンス作成
```
CREATE SEQUENCE ordernum_seq START 1000;
```

```
SELECT * FROM pg_sequences WHERE sequencename = 'ordernum_seq';
```


```
SELECT * FROM SEQUENCE WHERE NAME = 'ordernum';
```

```
INSERT INTO SEQUENCE (NAME, NEXTID) VALUES ('ordernum', 1000);
```


##### クリーンアップ（必要な場合）

データをリセットする必要がある場合は、以下のコマンドを使用します：

```sql
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
```

その後、スキーマの作成とデータの挿入を再度行います。


## 3. アプリケーション設定の変更

### 3.1 applicationContext.xmlの修正

`src/main/webapp/WEB-INF/applicationContext.xml` ファイルを以下のように修正します：

1. 既存の `jdbc:embedded-database` 要素を削除します。
2. 以下のデータソース定義を追加します：
```xml
<bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
    <property name="driverClassName" value="org.postgresql.Driver"/>
    <property name="url" value="jdbc:postgresql://localhost:5432/jpetstore"/>
    <property name="username" value="jpetstore_user"/>
    <property name="password" value="your_password"/>
</bean>
```
3. `SqlSessionFactoryBean` の設定を以下のように更新します（必要に応じて）：
```xml
 <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
    <property name="dataSource" ref="dataSource" />
    <property name="typeAliasesPackage" value="org.mybatis.jpetstore.domain" />
    <property name="mapperLocations" value="classpath*:org/mybatis/jpetstore/mapper/*.xml" />
</bean>   
```

これらの変更により、アプリケーションは PostgreSQL データベースを使用するように設定されます。

### 3.2 注意点

1. パスワードなどの機密情報を直接 XML ファイルに記述することは、セキュリティ上のリスクがあります。本番環境では、環境変数や外部の設定管理システムを使用することを検討してください。
2. データベースの接続情報（ホスト、ポート、データベース名）は、実際の環境に合わせて適切に設定してください。
3. `mapperLocations` プロパティを追加することで、MyBatis マッパー XML ファイルが確実に読み込まれるようになります。既存の設定で問題なければ、この変更は不要です。

### 3.2 MyBatis設定の更新
`src/main/resources/org/mybatis/jpetstore/mapper`ディレクトリ内のXMLファイルを確認し、必要に応じてSQL文を PostgreSQL 用に調整します。

変更後資材↓
![[ItemMapper.xml]]

![[02-Application/WebApp/SampleApplication/JPetstore/20240812-JPetstoreOnWSL2/PostgreSQL-Sizai/src/main/resources/org/mybatis/jpetstore/mapper/OrderMapper.xml]]

## 4. テストとデバッグ

### 4.1 ローカルでのテスト

1. プロジェクトをクリーンビルドします：
   ```bash
./mvnw clean package -DskipTests
   ```

2. アプリケーションを起動します：
```bash
./mvnw cargo:run -P tomcat90
```


### 4.2 統合テストの更新
`src/test`ディレクトリ内のテストクラスを確認し、必要に応じてPostgreSQL用に更新します。

## 5. 本番環境への展開

### 5.1 データ移行
1. 既存のHSQLDBからデータをエクスポートします。
2. エクスポートしたデータをPostgreSQLにインポートします。

### 5.2 アプリケーションのデプロイ
1. 更新されたWARファイルを作成します：`mvn clean package`
2. 新しいWARファイルを本番環境にデプロイします。

## 6. 監視とメンテナンス

- アプリケーションログを監視し、データベース関連のエラーがないか確認します。
- 定期的にデータベースのパフォーマンスを確認し、必要に応じてインデックスを追加または最適化します。

## 注意事項
- この移行プロセス中はアプリケーションのダウンタイムが発生します。ユーザーに事前に通知することを推奨します。
- 移行前に必ずデータのバックアップを取ってください。
- テスト環境で十分にテストを行ってから本番環境に適用してください。

