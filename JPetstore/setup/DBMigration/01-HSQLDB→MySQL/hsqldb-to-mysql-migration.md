# JPetStoreのデータベース依存関係をHSQLDBからMySQLに変更する手順

## 1. pom.xmlの修正

1. HSQLDBの依存関係を削除または注釈化:
   ```xml
   <!-- 
   <dependency>
     <groupId>org.hsqldb</groupId>
     <artifactId>hsqldb</artifactId>
     <version>${hsqldb.version}</version>
     <classifier>jdk8</classifier>
   </dependency>
   -->
   ```

2. MySQLの依存関係を追加:
   ```xml
   <dependency>
     <groupId>mysql</groupId>
     <artifactId>mysql-connector-java</artifactId>
     <version>8.0.28</version>
   </dependency>
   ```

3. プロパティセクションのhsqldb.versionを削除または注釈化:
   ```xml
   <!-- <hsqldb.version>2.7.3</hsqldb.version> -->
   ```
