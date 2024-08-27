### Environment
##### Machine
Level∞ 
WSL : Ubuntu 22.04.3 LTS
```
naka@Level:~/dev/20240812-JPetStore/jpetstore-6$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```
##### WorkDirectory
###### ルート：
```
cd /home/naka/dev/20240812-JPetStore/jpetstore-6
```

###### applicationContextXML置き場：
```
cd src/main/webapp/WEB-INF/
```

###### ResourceのMapperXML置き場：
```
cd src/main/resources/org/mybatis/jpetstore/mapper/
```

###### javaのMapperインターフェース置き場：
```
naka@Level:~/dev/20240812-JPetStore/jpetstore-6$ ls -lR src/main/java/org/mybatis/jpetstore/
src/main/java/org/mybatis/jpetstore/:
total 16
drwxr-xr-x 2 naka naka 4096 Aug 12 18:25 domain
drwxr-xr-x 2 naka naka 4096 Aug 12 18:25 mapper
drwxr-xr-x 2 naka naka 4096 Aug 12 18:25 service
drwxr-xr-x 3 naka naka 4096 Aug 12 18:25 web

src/main/java/org/mybatis/jpetstore/domain:
total 44
-rw-r--r-- 1 naka naka 4125 Aug 12 18:25 Account.java
-rw-r--r-- 1 naka naka 3191 Aug 12 18:25 Cart.java
-rw-r--r-- 1 naka naka 1784 Aug 12 18:25 CartItem.java
-rw-r--r-- 1 naka naka 1486 Aug 12 18:25 Category.java
-rw-r--r-- 1 naka naka 3123 Aug 12 18:25 Item.java
-rw-r--r-- 1 naka naka 2682 Aug 12 18:25 LineItem.java
-rw-r--r-- 1 naka naka 7323 Aug 12 18:25 Order.java
-rw-r--r-- 1 naka naka 1651 Aug 12 18:25 Product.java
-rw-r--r-- 1 naka naka 1307 Aug 12 18:25 Sequence.java

src/main/java/org/mybatis/jpetstore/mapper:
total 28
-rw-r--r-- 1 naka naka 1208 Aug 12 18:25 AccountMapper.java
-rw-r--r-- 1 naka naka  950 Aug 12 18:25 CategoryMapper.java
-rw-r--r-- 1 naka naka 1069 Aug 12 18:25 ItemMapper.java
-rw-r--r-- 1 naka naka  966 Aug 12 18:25 LineItemMapper.java
-rw-r--r-- 1 naka naka 1019 Aug 12 18:25 OrderMapper.java
-rw-r--r-- 1 naka naka 1022 Aug 12 18:25 ProductMapper.java
-rw-r--r-- 1 naka naka  931 Aug 12 18:25 SequenceMapper.java

src/main/java/org/mybatis/jpetstore/service:
total 12
-rw-r--r-- 1 naka naka 2113 Aug 12 18:25 AccountService.java
-rw-r--r-- 1 naka naka 2698 Aug 12 18:25 CatalogService.java
-rw-r--r-- 1 naka naka 3895 Aug 12 18:25 OrderService.java

src/main/java/org/mybatis/jpetstore/web:
total 4
drwxr-xr-x 2 naka naka 4096 Aug 12 18:25 actions

src/main/java/org/mybatis/jpetstore/web/actions:
total 32
-rw-r--r-- 1 naka naka 1518 Aug 12 18:25 AbstractActionBean.java
-rw-r--r-- 1 naka naka 5711 Aug 12 18:25 AccountActionBean.java
-rw-r--r-- 1 naka naka 3846 Aug 12 18:25 CartActionBean.java
-rw-r--r-- 1 naka naka 5267 Aug 12 18:25 CatalogActionBean.java
-rw-r--r-- 1 naka naka 5787 Aug 12 18:25 OrderActionBean.java
```

###### WEBアプリのHTML、gifやjsp
```
naka@Level:~/dev/20240812-JPetStore/jpetstore-6$ ls -lR src/main/webapp/
src/main/webapp/:
total 28
drwxr-xr-x 2 naka naka 4096 Aug 12 18:25 META-INF
drwxr-xr-x 3 naka naka 4096 Aug 24 20:48 WEB-INF
drwxr-xr-x 2 naka naka 4096 Aug 12 18:25 css
-rw-r--r-- 1 naka naka 6357 Aug 12 18:25 help.html
drwxr-xr-x 2 naka naka 4096 Aug 12 18:25 images
-rw-r--r-- 1 naka naka 1156 Aug 12 18:25 index.html

src/main/webapp/META-INF:
total 4
-rw-r--r-- 1 naka naka 23 Aug 12 18:25 MANIFEST.MF

src/main/webapp/WEB-INF:
total 16
-rw-r--r-- 1 naka naka 3671 Aug 24 20:48 applicationContext.xml
-rw-r--r-- 1 naka naka 2879 Aug 17 15:43 applicationContext.xml.org
drwxr-xr-x 7 naka naka 4096 Aug 12 18:25 jsp
-rw-r--r-- 1 naka naka 2338 Aug 12 18:25 web.xml

src/main/webapp/WEB-INF/jsp:
total 20
drwxr-xr-x 2 naka naka 4096 Aug 12 18:25 account
drwxr-xr-x 2 naka naka 4096 Aug 12 18:25 cart
drwxr-xr-x 2 naka naka 4096 Aug 12 18:25 catalog
drwxr-xr-x 2 naka naka 4096 Aug 12 18:25 common
drwxr-xr-x 2 naka naka 4096 Aug 12 18:25 order

src/main/webapp/WEB-INF/jsp/account:
total 16
-rw-r--r-- 1 naka naka 1431 Aug 12 18:25 EditAccountForm.jsp
-rw-r--r-- 1 naka naka 2235 Aug 12 18:25 IncludeAccountFields.jsp
-rw-r--r-- 1 naka naka 1319 Aug 12 18:25 NewAccountForm.jsp
-rw-r--r-- 1 naka naka 1279 Aug 12 18:25 SignonForm.jsp

src/main/webapp/WEB-INF/jsp/cart:
total 12
-rw-r--r-- 1 naka naka 3378 Aug 12 18:25 Cart.jsp
-rw-r--r-- 1 naka naka 2242 Aug 12 18:25 Checkout.jsp
-rw-r--r-- 1 naka naka 1116 Aug 12 18:25 IncludeMyList.jsp

src/main/webapp/WEB-INF/jsp/catalog:
total 20
-rw-r--r-- 1 naka naka 1383 Aug 12 18:25 Category.jsp
-rw-r--r-- 1 naka naka 2049 Aug 12 18:25 Item.jsp
-rw-r--r-- 1 naka naka 3221 Aug 12 18:25 Main.jsp
-rw-r--r-- 1 naka naka 2146 Aug 12 18:25 Product.jsp
-rw-r--r-- 1 naka naka 1663 Aug 12 18:25 SearchProducts.jsp

src/main/webapp/WEB-INF/jsp/common:
total 16
-rw-r--r-- 1 naka naka  777 Aug 12 18:25 Error.jsp
-rw-r--r-- 1 naka naka 1084 Aug 12 18:25 IncludeBottom.jsp
-rw-r--r-- 1 naka naka 4737 Aug 12 18:25 IncludeTop.jsp

src/main/webapp/WEB-INF/jsp/order:
total 24
-rw-r--r-- 1 naka naka 3027 Aug 12 18:25 ConfirmOrder.jsp
-rw-r--r-- 1 naka naka 1353 Aug 12 18:25 ListOrders.jsp
-rw-r--r-- 1 naka naka 2361 Aug 12 18:25 NewOrderForm.jsp
-rw-r--r-- 1 naka naka 1775 Aug 12 18:25 ShippingForm.jsp
-rw-r--r-- 1 naka naka 4522 Aug 12 18:25 ViewOrder.jsp

src/main/webapp/css:
total 8
-rw-r--r-- 1 naka naka 5681 Aug 12 18:25 jpetstore.css

src/main/webapp/images:
total 368
-rw-r--r-- 1 naka naka  6437 Aug 12 18:25 banner_birds.gif
-rw-r--r-- 1 naka naka  6674 Aug 12 18:25 banner_cats.gif
-rw-r--r-- 1 naka naka  6161 Aug 12 18:25 banner_dogs.gif
-rw-r--r-- 1 naka naka  6451 Aug 12 18:25 banner_fish.gif
-rw-r--r-- 1 naka naka  6556 Aug 12 18:25 banner_reptiles.gif
-rw-r--r-- 1 naka naka 12012 Aug 12 18:25 bird1.gif
-rw-r--r-- 1 naka naka 11383 Aug 12 18:25 bird2.gif
-rw-r--r-- 1 naka naka   471 Aug 12 18:25 birds_icon.gif
-rw-r--r-- 1 naka naka    96 Aug 12 18:25 cart.gif
-rw-r--r-- 1 naka naka 12767 Aug 12 18:25 cat1.gif
-rw-r--r-- 1 naka naka 12703 Aug 12 18:25 cat2.gif
-rw-r--r-- 1 naka naka   408 Aug 12 18:25 cats_icon.gif
-rw-r--r-- 1 naka naka 12106 Aug 12 18:25 dog1.gif
-rw-r--r-- 1 naka naka 12312 Aug 12 18:25 dog2.gif
-rw-r--r-- 1 naka naka 12146 Aug 12 18:25 dog3.gif
-rw-r--r-- 1 naka naka 12277 Aug 12 18:25 dog4.gif
-rw-r--r-- 1 naka naka 12710 Aug 12 18:25 dog5.gif
-rw-r--r-- 1 naka naka 12688 Aug 12 18:25 dog6.gif
-rw-r--r-- 1 naka naka   306 Aug 12 18:25 dogs.gif
-rw-r--r-- 1 naka naka   468 Aug 12 18:25 dogs_icon.gif
-rw-r--r-- 1 naka naka   271 Aug 12 18:25 fish.gif
-rw-r--r-- 1 naka naka 12638 Aug 12 18:25 fish1.gif
-rw-r--r-- 1 naka naka 13315 Aug 12 18:25 fish2.gif
-rw-r--r-- 1 naka naka 11479 Aug 12 18:25 fish3.gif
-rw-r--r-- 1 naka naka 11335 Aug 12 18:25 fish4.gif
-rw-r--r-- 1 naka naka   439 Aug 12 18:25 fish_icon.gif
-rw-r--r-- 1 naka naka 13314 Aug 12 18:25 lizard1.gif
-rw-r--r-- 1 naka naka  3808 Aug 12 18:25 logo-topbar.gif
-rw-r--r-- 1 naka naka  2775 Aug 12 18:25 poweredby.gif
-rw-r--r-- 1 naka naka   669 Aug 12 18:25 reptiles_icon.gif
-rw-r--r-- 1 naka naka    46 Aug 12 18:25 separator.gif
-rw-r--r-- 1 naka naka   251 Aug 12 18:25 sm_birds.gif
-rw-r--r-- 1 naka naka   289 Aug 12 18:25 sm_cats.gif
-rw-r--r-- 1 naka naka   306 Aug 12 18:25 sm_dogs.gif
-rw-r--r-- 1 naka naka   271 Aug 12 18:25 sm_fish.gif
-rw-r--r-- 1 naka naka   398 Aug 12 18:25 sm_reptiles.gif
-rw-r--r-- 1 naka naka 13078 Aug 12 18:25 snake1.gif
-rw-r--r-- 1 naka naka 36097 Aug 12 18:25 splash.gif
```

###### Maven内のTomcatがある場所
```
cd ~/dev/20240812-JPetStore/jpetstore-6/target/cargo/installs/apache-tomcat-9.0.85/apache-tomcat-9.0.85
```

##### Middleware
起動後。デフォルトだとHSQLDBとTomcatがMavenによって展開されるだけ。
```MiddlewareChcekScript.sh
naka@Level:~/dev/20240812-JPetStore/jpetstore-6/MyTool$ sh MiddlewareChcekScript.sh
===== Middleware Environment Check =====


>>>Summary
-------------------------------------
Web Server:
  Running: 3 process(es)
  Type: /usr/sbin/apache2
Application Server:
  Running: 2 process(es)
  Type: /usr/lib/jvm/java-17-openjdk-amd64/bin/java
Database Server:
  Running: 1 process(es)
  Type: /usr/sbin/mysqld
Searching ... Embedded/File-based Databases:
-------------------------------------

--- System Information ---
Linux Level 5.15.153.1-microsoft-standard-WSL2 #1 SMP Fri Mar 29 23:14:13 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux

--- Running Processes ---
root         251  0.0  0.0   7116  4932 ?        Ss   13:40   0:00 /usr/sbin/apache2 -k start
www-data     252  0.0  0.1 1998580 10900 ?       Sl   13:40   0:00 /usr/sbin/apache2 -k start
www-data     253  0.0  0.1 1998580 10900 ?       Sl   13:40   0:00 /usr/sbin/apache2 -k start
mysql        309  0.5  5.2 2309172 418120 ?      Ssl  13:40   0:25 /usr/sbin/mysqld
naka        8486  0.4  4.4 6733876 356960 pts/0  Sl+  14:05   0:13 /usr/lib/jvm/java-17-openjdk-amd64/bin/java -classpath /home/naka/dev/20240812-JPetStore/jpetstore-6/.mvn/wrapper/maven-wrapper.jar -Dmaven.multiModuleProjectDirectory=/home/naka/dev/20240812-JPetStore/jpetstore-6 org.apache.maven.wrapper.MavenWrapperMain cargo:run -P tomcat90
naka        8655  0.4  4.7 6068084 382028 pts/0  Sl+  14:05   0:13 /usr/lib/jvm/java-17-openjdk-amd64/bin/java -Xms128m -Xmx512m -Dcatalina.home=/home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/installs/apache-tomcat-9.0.85/apache-tomcat-9.0.85 -Dcatalina.base=/home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/configurations/tomcat9x -Djava.io.tmpdir=/home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/configurations/tomcat9x/temp -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file=/home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/configurations/tomcat9x/conf/logging.properties -classpath /home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/installs/apache-tomcat-9.0.85/apache-tomcat-9.0.85/bin/tomcat-juli.jar:/home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/installs/apache-tomcat-9.0.85/apache-tomcat-9.0.85/bin/bootstrap.jar org.apache.catalina.startup.Bootstrap start

--- Installed Packages ---
ii  apache2                       2.4.52-1ubuntu4.12                      amd64        Apache HTTP Server
ii  apache2-bin                   2.4.52-1ubuntu4.12                      amd64        Apache HTTP Server (modules and other binary files)
ii  apache2-data                  2.4.52-1ubuntu4.12                      all          Apache HTTP Server (common files)
ii  apache2-utils                 2.4.52-1ubuntu4.12                      amd64        Apache HTTP Server (utility programs for web servers)
ii  libaprutil1-dbd-sqlite3:amd64 1.6.1-5ubuntu4.22.04.2                  amd64        Apache Portable Runtime Utility Library - SQLite3 Driver
ii  libsqlite3-0:amd64            3.37.2-2ubuntu0.3                       amd64        SQLite 3 shared library
ii  mysql-client-8.0              8.0.39-0ubuntu0.22.04.1                 amd64        MySQL database client binaries
ii  mysql-client-core-8.0         8.0.39-0ubuntu0.22.04.1                 amd64        MySQL database core client binaries
ii  mysql-common                  5.8+1.0.8                               all          MySQL database common files, e.g. /etc/mysql/my.cnf
ii  mysql-server                  8.0.39-0ubuntu0.22.04.1                 all          MySQL database server (metapackage depending on the latest version)
ii  mysql-server-8.0              8.0.39-0ubuntu0.22.04.1                 amd64        MySQL database server binaries and system database setup
ii  mysql-server-core-8.0         8.0.39-0ubuntu0.22.04.1                 amd64        MySQL database server binaries

--- Service Status ---
  apache2.service                                        loaded active running The Apache HTTP Server
  mysql.service                                          loaded active running MySQL Community Server

--- Network Connections ---
tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN      309/mysqld
tcp        0      0 127.0.0.1:33060         0.0.0.0:*               LISTEN      309/mysqld
tcp6       0      0 :::80                   :::*                    LISTEN      251/apache2

--- Configuration Files ---
Apache:
total 80
-rw-r--r-- 1 root root  7224 Jul 18 03:57 apache2.conf
drwxr-xr-x 2 root root  4096 Aug 12 19:19 conf-available
drwxr-xr-x 2 root root  4096 Aug 12 19:19 conf-enabled
-rw-r--r-- 1 root root  1782 Dec  5  2023 envvars
-rw-r--r-- 1 root root 31063 Dec  5  2023 magic
drwxr-xr-x 2 root root 12288 Aug 12 19:19 mods-available
drwxr-xr-x 2 root root  4096 Aug 12 19:20 mods-enabled
-rw-r--r-- 1 root root   320 Dec  5  2023 ports.conf
drwxr-xr-x 2 root root  4096 Aug 12 20:48 sites-available
drwxr-xr-x 2 root root  4096 Aug 12 20:21 sites-enabled
Nginx:
Tomcat:
MySQL:
total 24
drwxr-xr-x 2 root root 4096 Aug 12 20:56 conf.d
-rwxr-xr-x 1 root root  120 Jul 24 20:08 debian-start
-rw------- 1 root root  317 Aug 12 20:56 debian.cnf
lrwxrwxrwx 1 root root   24 Aug 12 20:56 my.cnf -> /etc/alternatives/my.cnf
-rw-r--r-- 1 root root  839 Oct 20  2020 my.cnf.fallback
-rw-r--r-- 1 root root  682 Jun 15  2023 mysql.cnf
drwxr-xr-x 2 root root 4096 Aug 12 20:56 mysql.conf.d
PostgreSQL:
MongoDB:

--- Log Files ---
Apache:
total 24
-rw-r----- 1 root adm   4084 Aug 12 20:18 access.log
-rw-r----- 1 root adm   7929 Aug 17 13:40 error.log
-rw-r--r-- 1 root root 11757 Aug 17 14:09 jpetstore_access.log
-rw-r--r-- 1 root root     0 Aug 12 19:22 jpetstore_error.log
-rw-r----- 1 root adm      0 Aug 12 19:19 other_vhosts_access.log
Nginx:
Tomcat:
MySQL:
total 8
-rw-r----- 1 mysql adm 8098 Aug 17 13:55 error.log
PostgreSQL:
MongoDB:

--- Database Version Information ---
MySQL version:
mysql  Ver 8.0.39-0ubuntu0.22.04.1 for Linux on x86_64 ((Ubuntu))
HSQLDB detected (version information not available)

===== End of Middleware Environment Check =====
```

[[#疑問：Tomcatインストールされていない？]]

[[#疑問：MavenプロジェクトにTomcatを含めることで性能など何かデメリットはある？]]

##### password
MySQL
```RootLogin
sudo mysql
```

```jpetstoreLogin
CREATE USER 'jpetstore'@'localhost' IDENTIFIED BY 'We1come!';
```

Oracle
```
CREATE USER JPETSTORE IDENTIFIED BY "We1come!";
```

##### Build

1. プロジェクトをクリーンビルドします：
   ```bash
./mvnw clean package -DskipTests
   ```

2. アプリケーションを起動します：
```bash
./mvnw cargo:run -P tomcat90
```

##### StartWebService
```
cd /home/naka/dev/20240812-JPetStore/jpetstore-6
```
```
./mvnw cargo:run -P tomcat90
```

[[#疑問：mvnw runは内部的に何をやっているの？]]

##### WebAccess
```Chrome
http://localhost:8080/jpetstore/
```

# install

1. WSLを以下でインストール(Javaも)
	[[How to use WSL2]]
2. [[20240406-JPetStore(ペット販売アプリ)-展開]]を参照して、AmazonLinuxの奴と同じように展開
```
cd jpetstore-6
./mvnw clean package
```
ERROR発生。Javaバージョンが悪い。

![[Pasted image 20240812181530.png]]

8でもエラーだった。17以降っぽい。17でやってみる
[[202408121828-jpetstore-java-version17-fix]]

17のJavaインストールして後に以下をすると成功。
結構待った
```
./mvnw clean package
```

こちらも一発成功!
Apache、Tomcatを勝手にインストールしてくれるんかな。インストール先がよくわからない。
→もしかしたらTomcatインストールされてるわけじゃないっぽい？
```
./mvnw cargo:run -P tomcat90
```

ブラウザで接続確認：
```
http://localhost:8080/jpetstore/
```
![[Pasted image 20240812184331.png]]

→MySQLとApache構成に変更する
[[20240812-JPetstore-on-WSL2-Ubuntu-展開-Change-MySQL]]

→Oracle構成に変更する
[[jpetstore-oracle-migration]]

→アンインストール手順


##### Tomcat確認

以下ファイルにいろいろ書かれているっぽい。
```
/home/naka/dev/20240812-JPetStore/jpetstore-6/pom.xml
```
tomcat 9.0.85
```
 <profiles>
    <!-- Profiles for Application Server -->
    <profile>
      <id>tomcat90</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <properties>
        <tomcat.major-version>9</tomcat.major-version>
        <tomcat.version>9.0.85</tomcat.version>
      </properties>
    </profile>
```

##### Conf周り

Tomcat :
Server.xml
```
/home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/configurations/tomcat9x/conf/server.xml
```

##### Log

```
~/dev/20240812-JPetStore/jpetstore-6/target/cargo/configurations/tomcat9x/logs
```
localhost_access_log..2024-08-12.txt


##### 疑問：Tomcatインストールされていない？
端末起動直後、WSLに入ると、Tomcatは入っていない。
[[#Start]]を実行するとTomcatが立ち上がる。
```
調べてみると、以下のようにTomcatがいるように見える。
が、これはmvnw runというコマンドを実施いないといけない。Tomcatはインストールされていないの？

--- Summary ---
Web Server:
  Running: 3 process(es)
  Type: /usr/sbin/apache2
Application Server:
  Running: 2 process(es)
  Type: /usr/lib/jvm/java-17-openjdk-amd64/bin/java
Database Server:
  Running: 1 process(es)
  Type: /usr/sbin/mysqld
--- System Information ---
Linux Level 5.15.153.1-microsoft-standard-WSL2 #1 SMP Fri Mar 29 23:14:13 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
--- Running Processes ---
root         251  0.0  0.0   7116  4932 ?        Ss   13:40   0:00 /usr/sbin/apache2 -k start
www-data     252  0.0  0.1 1998580 10900 ?       Sl   13:40   0:00 /usr/sbin/apache2 -k start
www-data     253  0.0  0.1 1998580 10900 ?       Sl   13:40   0:00 /usr/sbin/apache2 -k start
mysql        309  0.6  5.2 2309172 418120 ?      Ssl  13:40   0:10 /usr/sbin/mysqld
naka        8486 10.6  4.2 6733876 342480 pts/0  Sl+  14:05   0:09 /usr/lib/jvm/java-17-openjdk-amd64/bin/java -classpath /home/naka/dev/20240812-JPetStore/jpetstore-6/.mvn/wrapper/maven-wrapper.jar -Dmaven.multiModuleProjectDirectory=/home/naka/dev/20240812-JPetStore/jpetstore-6 org.apache.maven.wrapper.MavenWrapperMain cargo:run -P tomcat90
naka        8655 11.7  4.3 6068084 351352 pts/0  Sl+  14:05   0:08 /usr/lib/jvm/java-17-openjdk-amd64/bin/java -Xms128m -Xmx512m -Dcatalina.home=/home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/installs/apache-tomcat-9.0.85/apache-tomcat-9.0.85 -Dcatalina.base=/home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/configurations/tomcat9x -Djava.io.tmpdir=/home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/configurations/tomcat9x/temp -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file=/home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/configurations/tomcat9x/conf/logging.properties -classpath /home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/installs/apache-tomcat-9.0.85/apache-tomcat-9.0.85/bin/tomcat-juli.jar:/home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/installs/apache-tomcat-9.0.85/apache-tomcat-9.0.85/bin/bootstrap.jar org.apache.catalina.startup.Bootstrap start
--- Installed Packages ---
ii  apache2                       2.4.52-1ubuntu4.12                      amd64        Apache HTTP Server
ii  apache2-bin                   2.4.52-1ubuntu4.12                      amd64        Apache HTTP Server (modules and other binary files)
ii  apache2-data                  2.4.52-1ubuntu4.12                      all          Apache HTTP Server (common files)
ii  apache2-utils                 2.4.52-1ubuntu4.12                      amd64        Apache HTTP Server (utility programs for web servers)
ii  mysql-client-8.0              8.0.39-0ubuntu0.22.04.1                 amd64        MySQL database client binaries
ii  mysql-client-core-8.0         8.0.39-0ubuntu0.22.04.1                 amd64        MySQL database core client binaries
ii  mysql-common                  5.8+1.0.8                               all          MySQL database common files, e.g. /etc/mysql/my.cnf
ii  mysql-server                  8.0.39-0ubuntu0.22.04.1                 all          MySQL database server (metapackage depending on the latest version)
ii  mysql-server-8.0              8.0.39-0ubuntu0.22.04.1                 amd64        MySQL database server binaries and system database setup
ii  mysql-server-core-8.0         8.0.39-0ubuntu0.22.04.1                 amd64        MySQL database server binaries
--- Service Status ---
  apache2.service                                        loaded active running The Apache HTTP Server
  mysql.service                                          loaded active running MySQL Community Server




ご提供いただいた情報から、以下のことが分かります：

Tomcatは直接インストールされていないようです。代わりに、MavenのCargoプラグインを使用してTomcatを動的に実行しているようです。
具体的には、mvnw runコマンド（Maven Wrapperを使用）を実行することで、TomcatがMavenプロジェクトの一部として起動されています。
プロセス一覧を見ると、以下の2つのJavaプロセスが関連しています：
Maven Wrapper (org.apache.maven.wrapper.MavenWrapperMain)を実行するプロセス
Tomcat (org.apache.catalina.startup.Bootstrap)を実行するプロセス
Tomcatは/home/naka/dev/20240812-JPetStore/jpetstore-6/target/cargo/ディレクトリ以下に一時的にインストールされ、実行されているようです。
システムにグローバルにインストールされているのは、Apache HTTPサーバーとMySQLのみです。
このセットアップは、開発環境でよく使用される方法です。Tomcatを直接インストールする代わりに、Mavenプロジェクトの一部として管理することで、以下のメリットがあります：

プロジェクト固有の設定を容易に管理できる
異なるバージョンのTomcatを異なるプロジェクトで使用できる
開発環境のセットアップが簡単になる
Tomcatをシステムにグローバルにインストールする必要はありません。現在の設定で、アプリケーションサーバーとしてTomcatが正常に機能しているようです。

もし、システム全体で使用するためにTomcatをインストールしたい場合は、別途パッケージマネージャーを使用してインストールすることができます。ただし、現在の開発セットアップでは必要ないでしょう。

スクリプトを改善するには、Mavenプロジェクトの一部として実行されているTomcatも検出できるように修正することができます。その場合、Javaプロセスの中からTomcat関連のものを特定する必要があります。
```



##### 疑問：MavenプロジェクトにTomcatを含めることで性能など何かデメリットはある？
```
Mavenプロジェクトに組み込まれたTomcatを使用することには、いくつかの潜在的なデメリットがありますが、多くの場合、メリットの方が上回ります。以下に主なポイントをまとめます：

デメリット：

1. 起動時間： プロジェクトを実行するたびにTomcatをダウンロードして設定する必要があるため、初回の起動時間が長くなる可能性があります。ただし、一度ダウンロードされると、キャッシュされるので、その後の起動は速くなります。
2. ディスク使用量： 各プロジェクトが独自のTomcatインスタンスを持つため、複数のプロジェクトがある場合、ディスク使用量が増加する可能性があります。
3. メモリ使用量： 各プロジェクトが独自のJVMでTomcatを実行するため、システム全体のメモリ使用量が増加する可能性があります。
4. 設定の複雑さ： 高度なTomcatの設定が必要な場合、Mavenプロジェクト内での設定が複雑になる可能性があります。
5. 本番環境との差異： 開発環境と本番環境でTomcatの設定や動作が異なる可能性があり、環境間の差異によるイシューが発生する可能性があります。

メリット：

1. 環境の一貫性： すべての開発者が同じバージョンのTomcatを使用することが保証されます。
2. バージョン管理： プロジェクトごとに異なるバージョンのTomcatを使用できます。
3. 設定の簡易さ： プロジェクト固有の設定を容易に管理できます。
4. ポータビリティ： プロジェクトを別のマシンに移動させても、同じ環境で動作させることができます。
5. CI/CDとの統合： 継続的インテグレーション/デリバリーのプロセスに組み込みやすくなります。
6. 依存関係の明確化： プロジェクトの依存関係が明確になり、管理が容易になります。

結論： 性能面では、システムにグローバルにインストールされたTomcatと比較して、顕著な違いはありません。起動時間やメモリ使用量にわずかな影響がある可能性はありますが、多くの場合、開発の効率性や環境の一貫性というメリットの方が大きいと考えられます。

実際の運用環境では、パフォーマンスや設定の最適化が必要な場合、専用のTomcatインスタンスを使用することが一般的です。開発環境でMavenに組み込まれたTomcatを使用し、本番環境で別途最適化されたTomcatを使用するというアプローチも多く採用されています。

プロジェクトの規模、チームの大きさ、開発プロセスなどを考慮して、最適なアプローチを選択することが重要です。
```



##### 疑問：mvnw runは内部的に何をやっているの？
```
`mvnw run` コマンド（正確には `./mvnw cargo:run`）は、Maven Wrapper を使用して Maven の Cargo プラグインを実行しています。このプロセスの内部では、以下のような一連の操作が行われています：

1. Maven Wrapper の実行: `mvnw` は Maven Wrapper のスクリプトで、プロジェクトに指定されたバージョンの Maven を自動的にダウンロードし、使用します。
2. Cargo プラグインの起動: Maven は `cargo:run` ゴールを実行します。Cargo は Java EE アプリケーションのデプロイメントを自動化するためのツールです。
3. Tomcat のダウンロードと展開: Cargo プラグインは、プロジェクトの設定に基づいて指定されたバージョンの Tomcat をダウンロードし、一時ディレクトリ（通常は `target/cargo` 以下）に展開します。
4. アプリケーションのビルド: プロジェクトのソースコードがコンパイルされ、WAR（Web Application Archive）ファイルが生成されます。
5. Tomcat の設定: Cargo は Tomcat の設定ファイル（server.xml, context.xml など）を生成または修正し、アプリケーションの要件に合わせます。
6. アプリケーションのデプロイ: ビルドされた WAR ファイルが Tomcat の `webapps` ディレクトリにデプロイされます。
7. Tomcat の起動: 設定された Tomcat インスタンスが起動され、アプリケーションがデプロイされます。
8. プロセスの監視: Cargo プラグインは Tomcat プロセスを監視し続け、必要に応じて再起動やシャットダウンを行います。

このプロセスの利点は、開発者がローカル環境に Tomcat をインストールする必要がなく、プロジェクトの依存関係として Tomcat を管理できることです。また、異なるプロジェクトで異なるバージョンの Tomcat を使用することも容易になります。

`mvnw run` の実行時に、以下のようなログ出力を見ることができます：

1. Maven Wrapper がプロジェクトに適したバージョンの Maven をダウンロード/使用する様子
2. 依存関係のダウンロードとビルドプロセス
3. Cargo プラグインが Tomcat をダウンロードし、設定する過程
4. アプリケーションのコンパイルとパッケージング
5. Tomcat の起動とアプリケーションのデプロイ

このアプローチは、特に複数の開発者が関わるプロジェクトや、CI/CD パイプラインでの使用に適しています。環境の一貫性を保ち、「動作環境」の問題を最小限に抑えることができます。
```


# Install追加作業

### 202408180103-新規商品Nakafishを登録してみる

```
INSERT INTO PRODUCT VALUES ('FI-FW-99','FISH', 'Nakafish','<image src="../images/fish2.gif">Fresh Water fish from China'); 
INSERT INTO ITEM (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES('EST-1000','FI-FW-99',1800.50,1000.00,1,'P','Spotless'); 
INSERT INTO INVENTORY (itemid, qty ) VALUES ('EST-1000',10);
```

DB登録しただけだったら新規標品が表示されることはなかった。。。

以下ファイルたちが、新規製品を取得し更新するメソッドが実装されているかチェックしろと言われたので見たけど大丈夫そうだった。
```
src/main/resources/org/mybatis/jpetstore/mapper/ProductMapper.xml
src/main/java/org/mybatis/jpetstore/service/CatalogService.java
src/main/webapp/WEB-INF/jsp/catalog/Category.jsp
```

新規製品チェックがどのくらいの頻度で実行されるのかがわかんない。
参考まで一般的な新規製品チェックのアプローチは１時間更新とかキャッシュの２４時間までとか：
[[new-product-check-frequency]]


とりあえず再起動をおすすめされたので再起動してみる。

再起動後Nakafishが表示された。
![[Pasted image 20240818005921.png]]


後片付け
```
-- INVENTORYテーブルからデータを削除
DELETE FROM INVENTORY WHERE itemid = 'EST-1000';

-- ITEMテーブルからデータを削除
DELETE FROM ITEM WHERE itemid = 'EST-1000';

-- PRODUCTテーブルからデータを削除
DELETE FROM PRODUCT WHERE productid = 'FI-FW-99';
```

