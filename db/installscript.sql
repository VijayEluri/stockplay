---------------------------------
--  StockPlay Database Script  --
---------------------------------


-- Users table

CREATE SEQUENCE "STOCKPLAY"."USERID_SEQ" MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 10 CACHE 20 NOORDER NOCYCLE ;

CREATE TABLE "STOCKPLAY"."USERS"
  (
    "ID"        NUMBER NOT NULL ENABLE,
    "NICKNAME"  VARCHAR2(4000 BYTE) NOT NULL ENABLE,
    "PASSWORD"  VARCHAR2(4000 BYTE) NOT NULL ENABLE,
    "IS_ADMIN"  NUMBER(*,0),
    "LASTNAME"  VARCHAR2(4000 BYTE),
    "FIRSTNAME" VARCHAR2(4000 BYTE),
    "REGTIME" TIMESTAMP (6) NOT NULL ENABLE,
    "RRN"    NUMBER,
    "POINTS" NUMBER,
    "STARTAMOUNT" BINARY_DOUBLE,
    "CASH" BINARY_DOUBLE,
    "EMAIL" VARCHAR2(4000 BYTE) NOT NULL ENABLE,
    CONSTRAINT "USERS_PK" PRIMARY KEY ("ID") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "STOCKPLAY" ENABLE
  )
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "STOCKPLAY" ;


-- Administrator account
REM INSERTING into USERS
Insert into USERS (ID,NICKNAME,PASSWORD,IS_ADMIN,LASTNAME,FIRSTNAME,REGTIME,RRN,POINTS,STARTAMOUNT,CASH,EMAIL) values (1,'Administrator','8CA9FCD1748A139054436451F866A0CB34531122EBC339ECF4EBFD1B70A346F8',1,'Strator','Admin',to_timestamp('01/01/10 00:00:00,000000000','DD/MM/RR HH24:MI:SS,FF'),0,0,'0,0','0,0','admin@kapti.com');

-- Account voor transactiemanager
Insert into USERS (ID,NICKNAME,PASSWORD,IS_ADMIN,LASTNAME,FIRSTNAME,REGTIME,RRN,POINTS,STARTAMOUNT,CASH,EMAIL) values (2,'rita','C3D92E7F4EB09302378631E6D99D5379FE97B42F9BBE24DB4F8C943B50C7B943',3,'Manager','Transactie',to_timestamp('08/05/10 16:12:32,404000000','DD/MM/RR HH24:MI:SS,FF'),0,0,'100000,0','100000,0','transactiemanager@kapti.com');

-- Account voor puntenmanager
Insert into USERS (ID,NICKNAME,PASSWORD,IS_ADMIN,LASTNAME,FIRSTNAME,REGTIME,RRN,POINTS,STARTAMOUNT,CASH,EMAIL) values (3,'stefaan','F714C3EF17E5F6A4AB0E145AD407868C4AFE325B11081CA5F59E6DFE39E87863',4,'Manager','Punten',to_timestamp('08/05/10 16:14:09,439000000','DD/MM/RR HH24:MI:SS,FF'),0,0,'100000,0','100000,0','puntenmanager@kapti.com');

-- Account voor scraper
Insert into USERS (ID,NICKNAME,PASSWORD,IS_ADMIN,LASTNAME,FIRSTNAME,REGTIME,RRN,POINTS,STARTAMOUNT,CASH,EMAIL) values (4,'scraper','8CA9FCD1748A139054436451F866A0CB34531122EBC339ECF4EBFD1B70A346F8',2,'scraper','scraper',to_timestamp('13/05/10 17:41:43,173000000','DD/MM/RR HH24:MI:SS,FF'),0,0,'100000,0','100000,0','scraper@kapti.com');

  

-- Roles table
 
CREATE TABLE "STOCKPLAY"."ROLES"
  (
    "ID"                NUMBER NOT NULL ENABLE,
    "NAME"              VARCHAR2(20 BYTE),
    "USER_REMOVE"       NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE,
    "SECURITY_CREATE"   NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE,
    "SECURITY_MODIFY"   NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE,
    "SECURITY_REMOVE"   NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE,
    "SECURITY_UPDATE"   NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE,
    "TRANSACTION_ADMIN" NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE,
    "POINTS_ADMIN"      NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE,
    "BACKEND_ADMIN"     NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE,
    "DATABASE_ADMIN"    NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE,
    "SCRAPER_ADMIN"     NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE,
    CONSTRAINT "ROLES_PK" PRIMARY KEY ("ID") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "STOCKPLAY" ENABLE
  )
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "STOCKPLAY" ;
  
--REM INSERTING into ROLES
Insert into ROLES (ID,NAME,USER_REMOVE,SECURITY_CREATE,SECURITY_MODIFY,SECURITY_REMOVE,SECURITY_UPDATE,TRANSACTION_ADMIN,POINTS_ADMIN,BACKEND_ADMIN,DATABASE_ADMIN,SCRAPER_ADMIN) values (0,'User',0,0,0,0,0,0,0,0,0,0);
Insert into ROLES (ID,NAME,USER_REMOVE,SECURITY_CREATE,SECURITY_MODIFY,SECURITY_REMOVE,SECURITY_UPDATE,TRANSACTION_ADMIN,POINTS_ADMIN,BACKEND_ADMIN,DATABASE_ADMIN,SCRAPER_ADMIN) values (1,'Administrator',1,1,1,1,1,1,1,1,1,1);
Insert into ROLES (ID,NAME,USER_REMOVE,SECURITY_CREATE,SECURITY_MODIFY,SECURITY_REMOVE,SECURITY_UPDATE,TRANSACTION_ADMIN,POINTS_ADMIN,BACKEND_ADMIN,DATABASE_ADMIN,SCRAPER_ADMIN) values (2,'Scraper',0,1,1,1,1,0,0,0,0,1);
Insert into ROLES (ID,NAME,USER_REMOVE,SECURITY_CREATE,SECURITY_MODIFY,SECURITY_REMOVE,SECURITY_UPDATE,TRANSACTION_ADMIN,POINTS_ADMIN,BACKEND_ADMIN,DATABASE_ADMIN,SCRAPER_ADMIN) values (3,'TransactionsManager',0,0,0,0,0,1,0,0,0,0);
Insert into ROLES (ID,NAME,USER_REMOVE,SECURITY_CREATE,SECURITY_MODIFY,SECURITY_REMOVE,SECURITY_UPDATE,TRANSACTION_ADMIN,POINTS_ADMIN,BACKEND_ADMIN,DATABASE_ADMIN,SCRAPER_ADMIN) values (4,'PointsManager',0,0,0,0,0,0,1,0,0,0);
Insert into ROLES (ID,NAME,USER_REMOVE,SECURITY_CREATE,SECURITY_MODIFY,SECURITY_REMOVE,SECURITY_UPDATE,TRANSACTION_ADMIN,POINTS_ADMIN,BACKEND_ADMIN,DATABASE_ADMIN,SCRAPER_ADMIN) values (5,'AI',0,0,0,0,0,0,0,0,0,0);

-- Pointstransactions table

CREATE TABLE "STOCKPLAY"."POINTSTRANSACTIONS"
  (
    "USERID" NUMBER NOT NULL ENABLE,
    "TIMEST" TIMESTAMP (6) NOT NULL ENABLE,
    "DELTA"    NUMBER,
    "COMMENTS" VARCHAR2(200 BYTE),
    "TYPE"     VARCHAR2(20 BYTE) NOT NULL ENABLE,
    CONSTRAINT "POINTSHISTORY_PK" PRIMARY KEY ("USERID", "TYPE", "TIMEST") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "STOCKPLAY" ENABLE,
    CONSTRAINT "POINTSHISTORY_USERID_FK" FOREIGN KEY ("USERID") REFERENCES "STOCKPLAY"."USERS" ("ID") ON
  DELETE CASCADE ENABLE
  )
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "STOCKPLAY" ;

  
-- Trigger om insert/updates/deletes van deze tabel te weerspiegelen in de users-tabel

  CREATE OR REPLACE TRIGGER "STOCKPLAY"."UPDATEPOINTS" 
AFTER INSERT OR UPDATE ON POINTSTRANSACTIONS 
REFERENCING OLD AS old NEW as new
FOR EACH ROW 
BEGIN
  --alter trigger blockcashandpointsupdate disable;
  UPDATE users u SET u.points=coalesce(u.points,0)+coalesce(:new.delta,0)-coalesce(:old.delta,0) WHERE u.id=coalesce(:new.userid,:old.userid);
  --alter trigger blockcashandpointsupdate enable;
END;
/
ALTER TRIGGER "STOCKPLAY"."UPDATEPOINTS" ENABLE;
 


-- Exchange table

CREATE TABLE "STOCKPLAY"."EXCHANGES"
  (
    "SYMBOL"   VARCHAR2(10 BYTE) NOT NULL ENABLE,
    "NAME"     VARCHAR2(4000 BYTE),
    "LOCATION" VARCHAR2(4000 BYTE),
    CONSTRAINT "EXCHANGES_PK" PRIMARY KEY ("SYMBOL") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "STOCKPLAY" ENABLE
  )
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "STOCKPLAY" ;
  
-- Securities table

CREATE TABLE "STOCKPLAY"."SECURITIES"
  (
    "SYMBOL"    VARCHAR2(10 BYTE) NOT NULL ENABLE,
    "NAME"      VARCHAR2(4000 BYTE),
    "EXCHANGE"  VARCHAR2(10 BYTE) NOT NULL ENABLE,
    "VISIBLE"   NUMBER(1,0) DEFAULT 1,
    "SUSPENDED" NUMBER(1,0) DEFAULT 0,
    "ISIN"      VARCHAR2(12 BYTE) NOT NULL ENABLE,
    "CURRENCY"  VARCHAR2(3 BYTE),
    CONSTRAINT "SECURITIES_PK" PRIMARY KEY ("ISIN") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "STOCKPLAY" ENABLE,
    CONSTRAINT "SECURITIES_EXCHANGE_FK" FOREIGN KEY ("EXCHANGE") REFERENCES "STOCKPLAY"."EXCHANGES" ("SYMBOL") ENABLE
  )
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "STOCKPLAY" ;
  
  
-- Quotes table

CREATE TABLE "STOCKPLAY"."QUOTES"
  (
    "ISIN" VARCHAR2(12 BYTE) NOT NULL ENABLE,
    "TIMESTAMP" TIMESTAMP (6) NOT NULL ENABLE,
    "PRICE" BINARY_DOUBLE NOT NULL ENABLE,
    "VOLUME" NUMBER,
    "BID" BINARY_DOUBLE NOT NULL ENABLE,
    "ASK" BINARY_DOUBLE NOT NULL ENABLE,
    "LOW" BINARY_DOUBLE NOT NULL ENABLE,
    "HIGH" BINARY_DOUBLE NOT NULL ENABLE,
    "OPEN" BINARY_DOUBLE,
    CONSTRAINT "QUOTES_PK" PRIMARY KEY ("ISIN", "TIMESTAMP") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "STOCKPLAY" ENABLE,
    CONSTRAINT "QUOTES_SECURITIES_FK1" FOREIGN KEY ("ISIN") REFERENCES "STOCKPLAY"."SECURITIES" ("ISIN") DISABLE
  )
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "STOCKPLAY" ;
  
  
-- User_securities table

CREATE TABLE "STOCKPLAY"."USER_SECURITIES"
  (
    "USERID" NUMBER NOT NULL ENABLE,
    "ISIN"   VARCHAR2(12 BYTE) NOT NULL ENABLE,
    "AMOUNT" NUMBER NOT NULL ENABLE,
    CONSTRAINT "USER_SECURITIES_PK" PRIMARY KEY ("USERID", "ISIN") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "STOCKPLAY" ENABLE,
    CONSTRAINT "USER_SECURITIES_USERID_FK" FOREIGN KEY ("USERID") REFERENCES "STOCKPLAY"."USERS" ("ID") ENABLE,
    CONSTRAINT "USER_SECURITIES_SECURITIE_FK1" FOREIGN KEY ("ISIN") REFERENCES "STOCKPLAY"."SECURITIES" ("ISIN") ON
  DELETE CASCADE ENABLE
  )
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "STOCKPLAY" ;
  
-- Indexes table

CREATE SEQUENCE "STOCKPLAY"."INDEXID_SEQ" MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE ;


CREATE TABLE "STOCKPLAY"."INDEXES"
  (
    "NAME"     VARCHAR2(4000 BYTE),
    "EXCHANGE" VARCHAR2(10 BYTE) NOT NULL ENABLE,
    "ISIN"     VARCHAR2(12 BYTE) NOT NULL ENABLE,
    "SYMBOL"   VARCHAR2(10 BYTE) NOT NULL ENABLE,
    CONSTRAINT "INDEXES_PK" PRIMARY KEY ("ISIN") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "STOCKPLAY" ENABLE,
    CONSTRAINT "INDEXES_EXCHANGES_FK" FOREIGN KEY ("EXCHANGE") REFERENCES "STOCKPLAY"."EXCHANGES" ("SYMBOL") ENABLE
  )
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "STOCKPLAY" ;
  
  
-- Index_securities table

CREATE TABLE "STOCKPLAY"."INDEX_SECURITIES"
  (
    "INDEX_ISIN"    VARCHAR2(12 BYTE) NOT NULL ENABLE,
    "SECURITY_ISIN" VARCHAR2(12 BYTE) NOT NULL ENABLE,
    CONSTRAINT "INDEXES_SECURITIES_SECURI_FK1" FOREIGN KEY ("SECURITY_ISIN") REFERENCES "STOCKPLAY"."SECURITIES" ("ISIN") ENABLE
  )
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "STOCKPLAY" ;
  
-- Orders table

CREATE SEQUENCE "STOCKPLAY"."ORDERID_SEQ" MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE ;

CREATE TABLE "STOCKPLAY"."ORDERS"
  (
    "ID"     NUMBER NOT NULL ENABLE,
    "USERID" NUMBER NOT NULL ENABLE,
    "ISIN"   VARCHAR2(12 BYTE) NOT NULL ENABLE,
    "LIMIT" BINARY_DOUBLE NOT NULL ENABLE,
    "AMOUNT" NUMBER NOT NULL ENABLE,
    "TYPE"   VARCHAR2(18 BYTE) NOT NULL ENABLE,
    "STATUS" VARCHAR2(10 BYTE) NOT NULL ENABLE,
    "CREATIONTIME" TIMESTAMP (6) NOT NULL ENABLE,
    "EXPIRATIONTIME" TIMESTAMP (6),
    "EXECUTIONTIME" TIMESTAMP (6),
    "SECONDAIRYLIMIT" BINARY_DOUBLE,
    CONSTRAINT "ORDERS_PK" PRIMARY KEY ("ID") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "STOCKPLAY" ENABLE,
    CONSTRAINT "ORDERS_USERID_FK" FOREIGN KEY ("ISIN") REFERENCES "STOCKPLAY"."SECURITIES" ("ISIN") ON
  DELETE CASCADE ENABLE
  )
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "STOCKPLAY" ;
  
  
-- Transactions table

CREATE SEQUENCE "STOCKPLAY"."TRANSACTIONID_SEQ" MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE ;

CREATE TABLE "STOCKPLAY"."TRANSACTIONS"
  (
    "ID"     NUMBER NOT NULL ENABLE,
    "USERID" NUMBER NOT NULL ENABLE,
    "TIMEST" TIMESTAMP (6) NOT NULL ENABLE,
    "ISIN"   VARCHAR2(12 BYTE),
    "TYPE"   VARCHAR2(10 BYTE) NOT NULL ENABLE,
    "AMOUNT" NUMBER NOT NULL ENABLE,
    "PRICE" BINARY_DOUBLE NOT NULL ENABLE,
    "COMMENTS" VARCHAR2(2000 BYTE),
    CONSTRAINT "TRANSACTIONS_PK" PRIMARY KEY ("ID") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "STOCKPLAY" ENABLE,
    CONSTRAINT "TRANSACTIONS_SECURITIES_FK1" FOREIGN KEY ("ISIN") REFERENCES "STOCKPLAY"."SECURITIES" ("ISIN") ENABLE,
    CONSTRAINT "TRANSACTIONS_USERID_FK" FOREIGN KEY ("USERID") REFERENCES "STOCKPLAY"."USERS" ("ID") ON
  DELETE CASCADE ENABLE
  )
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "STOCKPLAY" ;
  
  
-- Trigger om toevoeging van transactie te verwerken naar user-table


  CREATE OR REPLACE TRIGGER "STOCKPLAY"."UPDATECASH" 
AFTER INSERT OR UPDATE ON TRANSACTIONS 
REFERENCING OLD AS old NEW as new
FOR EACH ROW 
declare
  us_exists number;
begin

  select count(1) into us_exists from user_securities us WHERE us.userid = coalesce(:new.userid, :old.userid) AND us.isin = coalesce(:new.isin,:old.isin);


  if coalesce(:new.type, :old.type) = 'SELL' then
      UPDATE users u SET u.cash=u.cash+coalesce(:new.price*:new.amount,0)-coalesce(:old.price*:old.amount,0) WHERE u.id=coalesce(:new.userid,:old.userid);
      
      if coalesce(:new.isin, :old.isin) <> null then
      if us_exists > 0 then

            UPDATE user_securities us SET us.amount=us.amount-coalesce(:new.amount,0)+coalesce(:old.amount,0) WHERE us.userid = coalesce(:new.userid, :old.userid) AND us.isin = coalesce(:new.isin,:old.isin);
      else
            INSERT INTO user_securities (userid, isin, amount) VALUES( coalesce(:new.userid, :old.userid), coalesce(:new.isin,:old.isin), -coalesce(:new.amount, :old.amount) );
      end if;
      end if;
          
  elsif coalesce(:new.type, :old.type) = 'BUY' then
      UPDATE users u SET u.cash=u.cash-coalesce(:new.price*:new.amount,0)+coalesce(:old.price*:old.amount,0) WHERE u.id=coalesce(:new.userid,:old.userid);
      
      if coalesce(:new.isin, :old.isin) <> null then
        if us_exists > 0 then
  
              UPDATE user_securities us SET us.amount=us.amount+coalesce(:new.amount,0)-coalesce(:old.amount,0) WHERE us.userid = coalesce(:new.userid, :old.userid) AND us.isin = coalesce(:new.isin,:old.isin);
        else
              INSERT INTO user_securities (userid, isin, amount) VALUES( coalesce(:new.userid, :old.userid), coalesce(:new.isin,:old.isin), coalesce(:new.amount, :old.amount) );
        end if;
      end if;
  
  else
  --MANUAL TYPE
      UPDATE users u SET u.cash=u.cash+coalesce(:new.price*:new.amount,0)-coalesce(:old.price*:old.amount,0) WHERE u.id=coalesce(:new.userid,:old.userid);
  end if;
END;
/
ALTER TRIGGER "STOCKPLAY"."UPDATECASH" ENABLE;
 


-- Trigger om transactie te checken op geldigheid vooraleer hem door te voeren


  CREATE OR REPLACE TRIGGER "STOCKPLAY"."CHECKTRANSACTION" 
BEFORE INSERT OR UPDATE ON TRANSACTIONS 
FOR EACH ROW 
declare
  money_user number;
  has_sec number;
  amount_owned number;
begin
  if :new.type <>'MANUAL' and (:new.price < 0 or :new.amount < 0) then
    raise_application_error(-20000, 'Price and amount should ALWAYS be positive!');
  end if;
  
  
  if (:new.type = 'BUY') then
  
    select cash into money_user from users u WHERE u.id = :new.userid;
    if ((money_user - (:new.price*:new.amount)) < 0) then
      raise_application_error(-20001, 'User doesnt have enough cash!');
    end if;

  elsif (:new.type = 'SELL') then
    select count(1) into has_sec from user_securities us where us.userid = :new.userid and us.isin = :new.isin;
    
    if(has_sec > 0) then 
    
      select amount into amount_owned from user_securities us where us.userid = :new.userid and us.isin = :new.isin;
      if (:new.amount > amount_owned) then
        raise_application_error(-20001, 'User doesnt have enough securities of that ISIN!');
      end if;
    else
        raise_application_error(-20001, 'User doesnt have securities of that ISIN!');
    end if;
  end if;
END;
/
ALTER TRIGGER "STOCKPLAY"."CHECKTRANSACTION" ENABLE;
 


-- Functie voor quotes


  CREATE OR REPLACE FUNCTION "STOCKPLAY"."TIME_DIFF" (
DATE_1 IN DATE, DATE_2 IN DATE) RETURN NUMBER IS
 
NDATE_1   NUMBER;
NDATE_2   NUMBER;
NSECOND_1 NUMBER(5,0);
NSECOND_2 NUMBER(5,0);
 
BEGIN
  -- Get Julian date number from first date (DATE_1)
  NDATE_1 := TO_NUMBER(TO_CHAR(DATE_1, 'J'));
 
  -- Get Julian date number from second date (DATE_2)
  NDATE_2 := TO_NUMBER(TO_CHAR(DATE_2, 'J'));
 
  -- Get seconds since midnight from first date (DATE_1)
  NSECOND_1 := TO_NUMBER(TO_CHAR(DATE_1, 'SSSSS'));
 
  -- Get seconds since midnight from second date (DATE_2)
  NSECOND_2 := TO_NUMBER(TO_CHAR(DATE_2, 'SSSSS'));
 
  RETURN (((NDATE_2 - NDATE_1) * 86400)+(NSECOND_2 - NSECOND_1));
END time_diff;
/
 
--Nodig om statistieken op te halen
grant select on sys.v_$instance to stockplay;