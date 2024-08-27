本手順はDockerだけじゃなく、Podmanでも成功。
⇒[[ファントムファイル or not検証 - 準備 - DB・Webサーバー構築]]

<Dockerイメージ>
https://hub.docker.com/layers/oracledb19c/oracle.19.3.0-ee/oracle19.3.0-ee/images/sha256-2e76fb433e5bfdcea00c08ffbe96541dc32677463e95fac40cb7bb6289bf4f7b?context=explore
![[Pasted image 20231029211429.png]]

### コンテナをイメージから起動する

Pull⇒確認⇒run
```
	naka@naka-NUC13ANHi7:~/ora19c-work$ docker pull oracledb19c/oracle.19.3.0-ee:oracle19.3.0-ee
oracle19.3.0-ee: Pulling from oracledb19c/oracle.19.3.0-ee
Digest: sha256:2e76fb433e5bfdcea00c08ffbe96541dc32677463e95fac40cb7bb6289bf4f7b
Status: Image is up to date for oracledb19c/oracle.19.3.0-ee:oracle19.3.0-ee
docker.io/oracledb19c/oracle.19.3.0-ee:oracle19.3.0-ee

naka@naka-NUC13ANHi7:~/ora19c-work$ docker image ls
REPOSITORY                                    TAG               IMAGE ID       CREATED        SIZE
ghcr.io/project-tsurugi/tsurugidb             latest            438aad9c6c49   3 weeks ago    3.43GB
container-registry.oracle.com/database/free   latest            39cabc8e6db0   8 weeks ago    9.16GB
hello-world                                   latest            9c7a54a9a43c   5 months ago   13.3kB
oracledb19c/oracle.19.3.0-ee                  oracle19.3.0-ee   0ce466e77ef0   2 years ago    6.53GB
mysql                                         8.0.14            71b5c7e10f9b   4 years ago    477MB

```

```
docker run -d --name oracle19c \
	-p 1521:1521 \
	-e ORACLE_SID=ORCLCDB \
	-e ORACLE_PDB=ORCLPDB \
	-e ORACLE_PWD=Oracle19 \
	oracledb19c/oracle.19.3.0-ee:oracle19.3.0-ee
```

上記、Pullもrunも一瞬だった・・・。心配。
とりあえずlog確認。

起動できているか確認。ここで時間がかかった！pullは一瞬で、runが長いね。
```
naka@naka-NUC13ANHi7:~/ora19c-work$ docker logs oracle19c
cat: /sys/fs/cgroup/memory/memory.limit_in_bytes: No such file or directory
cat: /sys/fs/cgroup/memory/memory.limit_in_bytes: No such file or directory
/opt/oracle/runOracle.sh: line 93: [: -lt: unary operator expected
ORACLE EDITION: ENTERPRISE
ORACLE PASSWORD FOR SYS, SYSTEM AND PDBADMIN: Oracle19

LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 29-OCT-2023 12:58:31

Copyright (c) 1991, 2019, Oracle.  All rights reserved.

Starting /opt/oracle/product/19c/dbhome_1/bin/tnslsnr: please wait...

TNSLSNR for Linux: Version 19.0.0.0.0 - Production
System parameter file is /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora
Log messages written to /opt/oracle/diag/tnslsnr/403b9a795a5d/listener/alert/log.xml
Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1)))
Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=0.0.0.0)(PORT=1521)))

Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=IPC)(KEY=EXTPROC1)))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 19.0.0.0.0 - Production
Start Date                29-OCT-2023 12:58:31
Uptime                    0 days 0 hr. 0 min. 0 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora
Listener Log File         /opt/oracle/diag/tnslsnr/403b9a795a5d/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=0.0.0.0)(PORT=1521)))
The listener supports no services
The command completed successfully
Prepare for db operation
8% complete
Copying database files
31% complete
Creating and starting Oracle instance
32% complete
36% complete
```

##### インストール完了まで、ログを定期確認
```
watch -n 2 docker logs oracle19c
```
↑これよりも

これのほうがいい
```
docker logs -f --tail=100 oracle19c
```


```

Every 2.0s: docker logs oracle19c                                           naka-NUC13ANHi7: Sun Oct 29 22:08:43 2023

cat: /sys/fs/cgroup/memory/memory.limit_in_bytes: No such file or directory
cat: /sys/fs/cgroup/memory/memory.limit_in_bytes: No such file or directory
/opt/oracle/runOracle.sh: line 93: [: -lt: unary operator expected
ORACLE EDITION: ENTERPRISE
ORACLE PASSWORD FOR SYS, SYSTEM AND PDBADMIN: Oracle19

LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 29-OCT-2023 12:58:31

Copyright (c) 1991, 2019, Oracle.  All rights reserved.

Starting /opt/oracle/product/19c/dbhome_1/bin/tnslsnr: please wait...

TNSLSNR for Linux: Version 19.0.0.0.0 - Production
System parameter file is /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora
Log messages written to /opt/oracle/diag/tnslsnr/403b9a795a5d/listener/alert/log.xml
Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1)))
Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=0.0.0.0)(PORT=1521)))

Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=IPC)(KEY=EXTPROC1)))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 19.0.0.0.0 - Production
Start Date                29-OCT-2023 12:58:31
Uptime                    0 days 0 hr. 0 min. 0 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora
Listener Log File         /opt/oracle/diag/tnslsnr/403b9a795a5d/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=0.0.0.0)(PORT=1521)))
The listener supports no services
The command completed successfully
Prepare for db operation
8% complete
Copying database files
31% complete
Creating and starting Oracle instance
32% complete
36% complete
40% complete
43% complete
46% complete
Completing Database Creation
51% complete
```

完了した！
→202408241427-[[20240812-JPetStore-on-WSL2-Ubuntu-Install#Machine]]のWSL2だと、15分くらい？

```
aka@naka-NUC13ANHi7:~/ora19c-work$ docker logs oracle19c
cat: /sys/fs/cgroup/memory/memory.limit_in_bytes: No such file or directory
cat: /sys/fs/cgroup/memory/memory.limit_in_bytes: No such file or directory
/opt/oracle/runOracle.sh: line 93: [: -lt: unary operator expected
ORACLE EDITION: ENTERPRISE
ORACLE PASSWORD FOR SYS, SYSTEM AND PDBADMIN: Oracle19

LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 29-OCT-2023 12:58:31

Copyright (c) 1991, 2019, Oracle.  All rights reserved.

Starting /opt/oracle/product/19c/dbhome_1/bin/tnslsnr: please wait...

TNSLSNR for Linux: Version 19.0.0.0.0 - Production
System parameter file is /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora
Log messages written to /opt/oracle/diag/tnslsnr/403b9a795a5d/listener/alert/log.xml
Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1)))
Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=0.0.0.0)(PORT=1521)))

Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=IPC)(KEY=EXTPROC1)))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 19.0.0.0.0 - Production
Start Date                29-OCT-2023 12:58:31
Uptime                    0 days 0 hr. 0 min. 0 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora
Listener Log File         /opt/oracle/diag/tnslsnr/403b9a795a5d/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=0.0.0.0)(PORT=1521)))
The listener supports no services
The command completed successfully
Prepare for db operation
8% complete
Copying database files
31% complete
Creating and starting Oracle instance
32% complete
36% complete
40% complete
43% complete
46% complete
Completing Database Creation
51% complete
54% complete
Creating Pluggable Databases
58% complete
77% complete
Executing Post Configuration Actions
100% complete
Database creation complete. For details check the logfiles at:
 /opt/oracle/cfgtoollogs/dbca/ORCLCDB.
Database Information:
Global Database Name:ORCLCDB
System Identifier(SID):ORCLCDB
Look at the log file "/opt/oracle/cfgtoollogs/dbca/ORCLCDB/ORCLCDB.log" for further details.

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Oct 29 13:10:04 2023
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL>
System altered.

SQL>
System altered.

SQL>
Pluggable database altered.

SQL>
PL/SQL procedure successfully completed.

SQL> Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
The Oracle base remains unchanged with value /opt/oracle
#########################
DATABASE IS READY TO USE!
#########################
The following output is now a tail of the alert.log:
ORCLPDB(3):Completed: ALTER DATABASE DEFAULT TABLESPACE "USERS"
2023-10-29T13:10:04.873851+00:00
ALTER SYSTEM SET control_files='/opt/oracle/oradata/ORCLCDB/control01.ctl' SCOPE=SPFILE;
2023-10-29T13:10:04.881113+00:00
ALTER SYSTEM SET local_listener='' SCOPE=BOTH;
   ALTER PLUGGABLE DATABASE ORCLPDB SAVE STATE
Completed:    ALTER PLUGGABLE DATABASE ORCLPDB SAVE STATE
2023-10-29T13:10:05.024250+00:00

XDB initialized.
```

```
naka@naka-NUC13ANHi7:~/ora19c-work$ docker container ls
CONTAINER ID   IMAGE                                          COMMAND                   CREATED          STATUS                    PORTS                                       NAMES
403b9a795a5d   oracledb19c/oracle.19.3.0-ee:oracle19.3.0-ee   "/bin/sh -c 'exec $O…"   16 minutes ago   Up 16 minutes (healthy)   0.0.0.0:1521->1521/tcp, :::1521->1521/tcp   oracle19c
```
接続
```
naka@naka-NUC13ANHi7:~/ora19c-work$ docker exec -it oracle19c sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Sun Oct 29 13:14:58 2023
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 ORCLPDB                        READ WRITE NO
SQL>alter session set container = ORCLPDB;

Session altered.

```



### 表領域について
OMFは無効。
```
SQL> SELECT VALUE FROM V$PARAMETER WHERE NAME = 'db_create_file_dest';

VALUE
--------------------------------------------------------------------------------


SQL> 
```

多分PDBはここ
```
SQL> !ls /opt/oracle/oradata/ORCLCDB/ORCLPDB/
sysaux01.dbf  system01.dbf  temp01.dbf  undotbs01.dbf  users01.dbf

```

OMFに設定するならここでいいのかな。
→[[oracle-enable-omf]]
```
SQL> !ls /opt/oracle/oradata/
ORCLCDB  dbconfig
```

```
ALTER SYSTEM SET db_create_file_dest = '/opt/oracle/oradata/' SCOPE=BOTH;
```
できた。

再起動
```
docker container restart oracle19c
```

```
docker exec -it oracle19c sqlplus / as sysdba
```
```
alter session set container = ORCLPDB;
```

以下設定されていた
```
SQL> SELECT VALUE FROM V$PARAMETER WHERE NAME = 'db_create_file_dest';

VALUE
--------------------------------------------------------------------------------
/opt/oracle/oradata/
```

OMF（ファイルパスなく）で作成できる。
```
SQL> CREATE TABLESPACE app_data DATAFILE SIZE 1G AUTOEXTEND ON NEXT 10M MAXSIZE 10G;

Tablespace created.
```

PDBで作った表領域でもCDBのディレクトリはいかに作られてるっぽいなぁ。こだわりがあれば、PDB配下へ。
```
SQL> !ls /opt/oracle/oradata/ORCLCDB/ORCLPDB
206833C2659A1247E063020011AC9091  control02.ctl  redo02.log    system01.dbf   users01.dbf
ORCLPDB                           pdbseed        redo03.log    temp01.dbf
control01.ctl                     redo01.log     sysaux01.dbf  undotbs01.dbf

SQL> !ls /opt/oracle/oradata/ORCLCDB/ORCLPDB
sysaux01.dbf  system01.dbf  temp01.dbf  undotbs01.dbf  users01.dbf
```



### dockerへ外部からのJDBC接続テスト

Point:
★Docker外部からの接続はlocalhostじゃなくて、ローカルIPで接続すること
https://qiita.com/ekzemplaro/items/b9e04c6b1e6a935a6fc6

```OracleConnectionTest.java
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class OracleConnectionTest {
    public static void main(String[] args) {
        //String jdbcUrl = "jdbc:oracle:thin:@localhost:1521/ORCLPDB";
        String jdbcUrl = "jdbc:oracle:thin:@172.17.0.2:1521/ORCLPDB";

        //debug
        System.setProperty("oracle.jdbc.Trace", "true");
        System.setProperty("oracle.jdbc.driver.T4CConnection.DEBUG", "true");

        String username = "jpetstore";
        String password = "We1come!";
        Properties props = new Properties();
        props.setProperty("user", username);
        props.setProperty("password", password);
        props.setProperty("oracle.net.CONNECT_TIMEOUT", "10000"); // 10秒のタイムアウト

        try {
            System.out.println("Connecting to Oracle database...");
            Connection connection = DriverManager.getConnection(jdbcUrl, props);
            System.out.println("Connected Success to Oracle Database!");
            connection.close();
        } catch (SQLException e) {
            System.out.println("Connection failed : " + e.getMessage());
            e.printStackTrace();
        }
    }
}
```

Test実行
```
naka@Level:~/OracleInstall/ConnectOracleTest$ ls -lR
.:
total 12
-rw-rw-r-- 1 naka naka 1923 Aug 24 20:44 OracleConnectionTest.class
-rw-rw-r-- 1 naka naka 1207 Aug 24 20:41 OracleConnectionTest.java
drwxr-xr-x 2 naka naka 4096 Aug 24 20:20 lib

./lib:
total 5068
-rwxrwxrwx 1 naka naka 5189606 Aug 24 20:07 ojdbc11.jar
naka@Level:~/OracleInstall/ConnectOracleTest$ javac OracleConnectionTest.java
naka@Level:~/OracleInstall/ConnectOracleTest$ java -classpath .:./lib/ojdbc11.jar OracleConnectionTest
Connecting to Oracle database...
Connected Success to Oracle Database!
```
成功。