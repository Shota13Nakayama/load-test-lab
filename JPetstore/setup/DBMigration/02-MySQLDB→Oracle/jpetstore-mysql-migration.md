# JPetStoreのデータベースをMySQLに移行する手順

## 1. MySQLのセットアップ

1. MySQLをインストールし、起動していることを確認します。
	[[mysql-installation-guide]]

1. MySQLに新しいデータベースを作成します：
   ```sql
   CREATE DATABASE jpetstore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```
3. JPetStore用のユーザーを作成し、権限を付与します：
   ```sql
   CREATE USER 'jpetstore'@'localhost' IDENTIFIED BY 'We1come!';
   GRANT ALL PRIVILEGES ON jpetstore.* TO 'jpetstore'@'localhost';
   FLUSH PRIVILEGES;
   ```

## 2. プロジェクトの依存関係追加

1. pom.xmlファイルにMySQL Connectorの依存関係を追加します：
   ```xml
   <dependency>
       <groupId>mysql</groupId>
       <artifactId>mysql-connector-java</artifactId>
       <version>8.0.28</version>
   </dependency>
   ```

↑変更について詳細
[[hsqldb-to-mysql-migration]]

## 3. データベース設定の変更

1. `src/main/webapp/WEB-INF/applicationContext.xml` ファイルを編集します。以下の部分を:

バックアップ
```
cp -p src/main/webapp/WEB-INF/applicationContext.xml src/main/webapp/WEB-INF/applicationContext.xml.org
```

   ```xml
   <jdbc:embedded-database id="dataSource">
       <jdbc:script location="classpath:database/jpetstore-hsqldb-schema.sql"/>
       <jdbc:script location="classpath:database/jpetstore-hsqldb-dataload.sql"/>
   </jdbc:embedded-database>
   ```

   次のように変更します:

   ```xml
   <bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
     <property name="driverClassName" value="com.mysql.cj.jdbc.Driver"/>
     <property name="url" value="jdbc:mysql://localhost:3306/jpetstore?useSSL=false&amp;serverTimezone=UTC"/>
     <property name="username" value="jpetstore"/>
     <property name="password" value="We1come!"/>
   </bean>
   ```

2. `sqlSessionFactory` bean の設定を以下のように更新します:

   ```xml
   <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
       <property name="dataSource" ref="dataSource" />
       <property name="typeAliasesPackage" value="org.mybatis.jpetstore.domain" />
       <property name="mapperLocations" value="classpath*:org/mybatis/jpetstore/mapper/*.xml" />
   </bean>
   ```


ここで一度MySQLにつながるかを試してみる

- プロジェクトをクリーンビルドします：
```
./mvnw clean package -DskipTests
```

- ビルドが成功したら、`target`ディレクトリに`jpetstore.war`ファイルが生成されていることを確認します。
- その後、再度アプリケーションを起動してみてください：
```
./mvnw cargo:run -P tomcat90
```

## 4. スキーマとデータの移行

1. `src/main/resources/database/` ディレクトリにある以下のSQLスクリプトをMySQLに適合するように修正します:
   - `jpetstore-hsqldb-schema.sql` を `jpetstore-mysql-schema.sql` として
   - `jpetstore-hsqldb-dataload.sql` を `jpetstore-mysql-dataload.sql` として

   主な変更点:
   - AUTO_INCREMENT の使用
   - データ型の調整（例：VARCHAR -> VARCHAR(255)）
   - MySQL固有の構文への対応

以下はデータロードなどは、特にビルドしなおしなどしなくても大丈夫。

#### 資材↓
![[jpetstore-mysql-dataload.sql]]

![[jpetstore-mysql-schema.sql]]



2. MySQL用のスキーマ作成スクリプトを実行します:
   ```bash
   mysql -u jpetstore -p jpetstore < src/main/resources/database/jpetstore-mysql-schema.sql
   ```

3. MySQL用のデータ挿入スクリプトを実行します:
   ```bash
   mysql -u jpetstore -p jpetstore < src/main/resources/database/jpetstore-mysql-dataload.sql
   ```


## 5. アプリケーションのビルドとテスト

1. プロジェクトをクリーンビルドします：
   ```bash
./mvnw clean package -DskipTests
   ```

2. アプリケーションを起動します：
   ```bash
   ./mvnw cargo:run -P tomcat90
   ```

3. ブラウザでアプリケーションにアクセスし（通常 http://localhost:8080/jpetstore/ ）、すべての機能が正常に動作することを確認します。

## ## 6. トラブルシューティング

- `applicationContext.xml` の変更が正しく行われているか再確認してください。
- MySQL Connector/J ライブラリがクラスパスに正しく追加されているか確認してください。
- `target/cargo/configurations/tomcat9x/logs/`ディレクトリ内のログファイルを確認し、データベース接続エラーがないか確認します。
- MySQLの接続設定（ホスト、ポート、ユーザー名、パスワード）が正しいことを確認します。
- 必要に応じて、MySQLのタイムゾーン設定を確認・調整します。

## 注意点

- 本番データがある場合は、事前にバックアップを取ってください。
- セキュリティのため、本番環境ではデータベースのパスワードを適切に管理してください。
- パフォーマンスの問題が発生した場合は、MySQLの設定やインデックスの最適化を検討してください。
