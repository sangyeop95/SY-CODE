--�����ڿ����� ********************************************************************************************************************************************************

-- tb_mbr ����------------------------------------------------------------------------------------------------------------------------------
-- DBMS_CRYPTO ���� �ο�
conn sys as sysdba;
grant execute on dbms_crypto to hr;

CREATE OR REPLACE PACKAGE HR.ENCRYPTION_AES
IS
    FUNCTION ENC_AES (INPUT_STRING IN VARCHAR2) RETURN VARCHAR2;
    FUNCTION DEC_AES (INPUT_STRING IN VARCHAR2) RETURN VARCHAR2;
END ENCRYPTION_AES;
/

CREATE OR REPLACE PACKAGE BODY HR.ENCRYPTION_AES
IS
    FUNCTION ENC_AES(INPUT_STRING IN VARCHAR2) RETURN VARCHAR2
    IS
        V_ORIGINAL_RAW RAW(130); -- ��ȣȭ �� ������
        V_KEY_DATA_RAW RAW(64); -- Ű ��
        ENCRYTED_RAW RAW(320); -- ��ȣȭ �� ������
        CONVERTED_STRING VARCHAR2(320); -- ����ȯ ������
    BEGIN
        V_ORIGINAL_RAW:=UTL_I18N.STRING_TO_RAW(INPUT_STRING,'AL32UTF8'); -- VARCHAR2 -> RAW ����ȯ
        V_KEY_DATA_RAW:=UTL_I18N.STRING_TO_RAW('AKDKEKDKFKGKEKSD','AL32UTF8'); -- Ű�� RAW ����ȯ
        ENCRYTED_RAW:=DBMS_CRYPTO.ENCRYPT(SRC=>V_ORIGINAL_RAW,
                                                TYP=>DBMS_CRYPTO.ENCRYPT_AES128+
                                                DBMS_CRYPTO.CHAIN_CBC+
                                                DBMS_CRYPTO.PAD_PKCS5,
                                                KEY=>V_KEY_DATA_RAW);
        CONVERTED_STRING:=UTL_RAW.cast_to_varchar2(utl_encode.base64_encode(ENCRYTED_RAW));
        -- RAW Ÿ�� -> BASE64_ENCODE() -> (ENCODING) -> VARCHAR2 ����ȯ
        -- VARCHAR2 ����ȯ ���� X -> ORA-06502: PL/SQL: numeric or value error: hex to raw conversion error �߻�
        RETURN CONVERTED_STRING;
    END ENC_AES;
    /******************************************************************************��ȣȭ �Ϸ�******************************************************************************/
    
    /******************************************************************************��ȣȭ ����******************************************************************************/
    FUNCTION DEC_AES(INPUT_STRING IN VARCHAR2) RETURN VARCHAR2
    IS  
        V_KEY_DATA_RAW RAW(64); -- Ű��
        DECRYPTED_RAW RAW(320); -- ��ȣȭ��
        CONVERTED_STRING VARCHAR2(320); -- ����ȯ ������
    BEGIN
        V_KEY_DATA_RAW:=UTL_I18N.STRING_TO_RAW('AKDKEKDKFKGKEKSD','AL32UTF8');
        DECRYPTED_RAW :=DBMS_CRYPTO.DECRYPT(SRC=>utl_encode.base64_decode(utl_raw.cast_to_raw(INPUT_STRING)),
        -- VARCHAR2 -> RAW ����ȯ -> (DECODING)
        -- RAW ����ȯ ���� X -> ORA-06502: PL/SQL: numeric or value error: hex to raw conversion error �߻�
                                                TYP=>DBMS_CRYPTO.ENCRYPT_AES128+
                                                DBMS_CRYPTO.CHAIN_CBC+
                                                DBMS_CRYPTO.PAD_PKCS5,
                                                KEY=>V_KEY_DATA_RAW);
        CONVERTED_STRING:=UTL_I18N.RAW_TO_CHAR(DECRYPTED_RAW,'AL32UTF8'); -- RAW -> VARCHAR2 ����ȯ -> RETURN
        RETURN CONVERTED_STRING;
    END DEC_AES;
/******************************************************************************��ȣȭ �Ϸ�******************************************************************************/
END ENCRYPTION_AES;
/

-- tb_mbr ����------------------------------------------------------------------------------------------------------------------------------
--������
create sequence seq_mbr_idx;
create sequence seq_mbr_sn start with 100;

--���̺�
create table tb_mbr (
    idx number not null,
    mbr_sn varchar2(20) not null,
    mbr_nm varchar2(50) not null,
    mbr_tel varchar2(200), 
    mbr_phone varchar2(200) not null,
    mbr_em varchar2(200),
    mbr_addr_bx varchar2(200) not null,
    mbr_addr_dtl varchar2(200),
    mbr_addr_post varchar2(10) not null,
    mbr_dep_cd varchar2(6) not null,
    mbr_hired_d date,
    mbr_id varchar2(50) not null,
    mbr_pw varchar2(200) not null,
    mbr_cls_cd varchar2(6),
    rgtr_id varchar2(50),
    rgtr_dt date,
    mdfr_id varchar2(50),
    mdfr_dt date
    );

--���̺� ��������
alter table tb_mbr add constraint tb_mbr_pk primary key (idx, mbr_nm);
alter table tb_mbr add constraint tb_mbr_sn_uk unique(mbr_sn);

--�����ͻ���
insert into tb_mbr values (seq_mbr_idx.nextval, '20200907'||seq_mbr_sn.nextval, '����ȯ', '7400', ENCRYPTION_AES.ENC_AES('010-6678-2273'), 'ojh22@naver.com', 
                           '����Ư���� ���ʱ� ������27�� 29', ENCRYPTION_AES.ENC_AES('���絿, �������'), '13789', 
                           'GENAFF', '2020/09/07', 'testid', ENCRYPTION_AES.ENC_AES('whdghks4268'), 'GAAM01', 'administrator', '2020/09/05', null, null);
insert into tb_mbr values (seq_mbr_idx.nextval, '20200908'||seq_mbr_sn.nextval, '�׽�Ʈ1', '7400', ENCRYPTION_AES.ENC_AES('010-0000-2273'), 'test1@naver.com', 
                           '�뱸������ �ϱ�', ENCRYPTION_AES.ENC_AES('ħ�굿'), '00089', 
                           'GENAFF', '2020/09/08', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);
insert into tb_mbr values (seq_mbr_idx.nextval, '20200909'||seq_mbr_sn.nextval, '�׽�Ʈ2', '7400', ENCRYPTION_AES.ENC_AES('010-0000-0000'), 'test2@naver.com', 
                           '�뱸������ ����', ENCRYPTION_AES.ENC_AES('������'), '13700', 
                           'GENAFF', '2020/09/09', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);
insert into tb_mbr values (seq_mbr_idx.nextval, '20200909'||seq_mbr_sn.nextval, '�׽�Ʈ3', '7400', ENCRYPTION_AES.ENC_AES('010-0000-0000'), 'test3@naver.com', 
                           '�뱸������ ����', ENCRYPTION_AES.ENC_AES('������'), '13700', 
                           'GENAFF', '2020/09/09', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);
insert into tb_mbr values (seq_mbr_idx.nextval, '20200909'||seq_mbr_sn.nextval, '�׽�Ʈ4', '7400', ENCRYPTION_AES.ENC_AES('010-0000-0000'), 'test4@naver.com', 
                           '�뱸������ ����', ENCRYPTION_AES.ENC_AES('������'), '13700', 
                           'GENAFF', '2020/09/09', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);                             
insert into tb_mbr values (seq_mbr_idx.nextval, '20200909'||seq_mbr_sn.nextval, '�׽�Ʈ5', '7400', ENCRYPTION_AES.ENC_AES('010-0000-0000'), 'test5@naver.com', 
                           '�뱸������ ����', ENCRYPTION_AES.ENC_AES('������'), '13700', 
                           'GENAFF', '2020/09/09', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);  
insert into tb_mbr values (seq_mbr_idx.nextval, '20200909'||seq_mbr_sn.nextval, '�׽�Ʈ6', '7400', ENCRYPTION_AES.ENC_AES('010-0000-0000'), 'test6@naver.com', 
                           '�뱸������ ����', ENCRYPTION_AES.ENC_AES('������'), '13700', 
                           'GENAFF', '2020/09/09', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);  
insert into tb_mbr values (seq_mbr_idx.nextval, '20200909'||seq_mbr_sn.nextval, '�׽�Ʈ7', '7400', ENCRYPTION_AES.ENC_AES('010-0000-0000'), 'test7@naver.com', 
                           '�뱸������ ����', ENCRYPTION_AES.ENC_AES('������'), '13700', 
                           'GENAFF', '2020/09/09', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);  
insert into tb_mbr values (seq_mbr_idx.nextval, '20200909'||seq_mbr_sn.nextval, '�׽�Ʈ8', '7400', ENCRYPTION_AES.ENC_AES('010-0000-0000'), 'test8@naver.com', 
                           '�뱸������ ����', ENCRYPTION_AES.ENC_AES('������'), '13700', 
                           'GENAFF', '2020/09/09', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);  
insert into tb_mbr values (seq_mbr_idx.nextval, '20200909'||seq_mbr_sn.nextval, '�׽�Ʈ9', '7400', ENCRYPTION_AES.ENC_AES('010-0000-0000'), 'test9@naver.com', 
                           '�뱸������ ����', ENCRYPTION_AES.ENC_AES('������'), '13700', 
                           'GENAFF', '2020/09/09', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);                             
insert into tb_mbr values (seq_mbr_idx.nextval, '20200909'||seq_mbr_sn.nextval, '�׽�Ʈ10', '7400', ENCRYPTION_AES.ENC_AES('010-0000-0000'), 'test10@naver.com', 
                           '�뱸������ ����', ENCRYPTION_AES.ENC_AES('������'), '13700', 
                           'GENAFF', '2020/09/09', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);  
insert into tb_mbr values (seq_mbr_idx.nextval, '20200909'||seq_mbr_sn.nextval, '�׽�Ʈ11', '7400', ENCRYPTION_AES.ENC_AES('010-0000-0000'), 'test11@naver.com', 
                           '�뱸������ ����', ENCRYPTION_AES.ENC_AES('������'), '13700', 
                           'GENAFF', '2020/09/09', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);                             
insert into tb_mbr values (seq_mbr_idx.nextval, '20200909'||seq_mbr_sn.nextval, '�׽�Ʈ12', '7400', ENCRYPTION_AES.ENC_AES('010-0000-0000'), 'test12@naver.com', 
                           '�뱸������ ����', ENCRYPTION_AES.ENC_AES('������'), '13700', 
                           'GENAFF', '2020/09/09', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);  
insert into tb_mbr values (seq_mbr_idx.nextval, '20200909'||seq_mbr_sn.nextval, '�׽�Ʈ13', '7400', ENCRYPTION_AES.ENC_AES('010-0000-0000'), 'test13@naver.com', 
                           '�뱸������ ����', ENCRYPTION_AES.ENC_AES('������'), '13700', 
                           'GENAFF', '2020/09/09', 'testid', ENCRYPTION_AES.ENC_AES('1234'), 'GAAM01', 'administrator', '2020/09/05', null, null);                             
--��������ȸ
select * from tb_mbr;
delete from tb_mbr;

commit;
show user;

 -- tb_atd ����------------------------------------------------------------------------------------------------------------------------------
-- idx �� ����� ������
create sequence seq_atd_idx
start with 1
increment by 1;

-- ����� �ð��� ���� ��¥ ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy/MM/dd HH24:MI:SS';

create sequence seq_atd_sn
start with 300
increment by 1;

create table tb_atd (
    idx         number      not null,
    atd_nm      varchar2(50) not null,
    atd_sn      varchar2(20),
    atd_gw      date,
    atd_lw      date,
    atd_bt      char(1),
    atd_bt_dt   varchar2(25),
    atd_bt_ct   varchar2(10),
    atd_dp      char(1),
    atd_dp_dt   varchar2(25),
    atd_dp_ct   varchar2(10),
    spare1       varchar2(255),
    spare2       varchar2(255),
    spare3       varchar2(255),
    rgtr_id      varchar2(64),
    rgtr_dt      date,
    mdfr_id      varchar2(64),
    mdfr_dt      date
);

-- pk
alter table tb_atd
add constraint tb_atd_pk primary key(idx);

-- ������ �ʱ�ȭ��
drop sequence seq_atd_idx;
drop sequence seq_atd_sn;


-- ���� �׽�Ʈ�� ������ ���� (����� || CONCAT ���)
insert into tb_atd values
(seq_atd_idx.nextval, 'test1', '20220918'||seq_atd_sn.nextval, sysdate, sysdate, 'N', null, null, 'N', null, null, null, null, null, 'admin', sysdate, null, null);
insert into tb_atd values
(seq_atd_idx.nextval, 'test2', '20200418'||seq_atd_sn.nextval, sysdate, sysdate, 'Y', '2022/09/18~2022/10/21', '�뱸', 'N', null, null, null, null, null, 'admin', sysdate, null, null);
insert into tb_atd values
(seq_atd_idx.nextval, 'test3', '20220918'||seq_atd_sn.nextval, sysdate, sysdate, 'N', null, null, 'N', null, null, null, null, null, 'admin', sysdate, null, null);
insert into tb_atd values
(seq_atd_idx.nextval, 'test4', '20220918'||seq_atd_sn.nextval, sysdate, sysdate, 'N', null, null, 'N', null, null, null, null, null, 'admin', sysdate, null, null);
insert into tb_atd values
(seq_atd_idx.nextval, 'test5', '20220918'||seq_atd_sn.nextval, sysdate, sysdate, 'N', null, null, 'N', null, null, null, null, null, 'admin', sysdate, null, null);
insert into tb_atd values
(seq_atd_idx.nextval, 'test6', '20200418'||seq_atd_sn.nextval, sysdate, sysdate, 'Y', '2022/09/18~2022/10/21', '�λ�', 'N', null, null, null, null, null, 'admin', sysdate, null, null);
insert into tb_atd values
(seq_atd_idx.nextval, 'test7', '20200418'||seq_atd_sn.nextval, sysdate, sysdate, 'Y', '2022/09/30~2022/10/3', '�뱸', 'N', null, null, null, null, null, 'admin', sysdate, null, null);
insert into tb_atd values
(seq_atd_idx.nextval, 'test8', '20220918'||seq_atd_sn.nextval, sysdate, sysdate, 'N', null, null, 'N', null, null, null, null, null, 'admin', sysdate, null, null);
insert into tb_atd values
(seq_atd_idx.nextval, 'test9', '20220918'||seq_atd_sn.nextval, sysdate, sysdate, 'N', null, null, 'N', null, null, null, null, null, 'admin', sysdate, null, null);
insert into tb_atd values
(seq_atd_idx.nextval, 'test10', '20220918'||seq_atd_sn.nextval, sysdate, sysdate, 'N', null, null, 'N', null, null, null, null, null, 'admin', sysdate, null, null);
insert into tb_atd values
(seq_atd_idx.nextval, 'test11', '20200418'||seq_atd_sn.nextval, sysdate, sysdate, 'Y', '2022/09/30~2022/10/3', '�뱸', 'N', null, null, null, null, null, 'admin', sysdate, null, null);
insert into tb_atd values
(seq_atd_idx.nextval, 'test12', '20200418'||seq_atd_sn.nextval, sysdate, sysdate, 'N', null, null, 'Y', '2022/03/20~2023/03/21', null, null, null, null, 'admin', sysdate, null, null);


-- ���̺� Ȯ�� �� �ʱ�ȭ��
select * from tb_atd;
delete from tb_atd;

-- COMMIT �ʼ�
commit;

 -- tb_vac ����------------------------------------------------------------------------------------------------------------------------------
-- idx �� ����� ������
create sequence seq_vac_idx
start with 1
increment by 1;

create sequence seq_vac_sn
start with 300
increment by 1;

create table tb_vac (
    idx          number      not null,
    vac_nm       varchar2(50) not null,
    vac_sn       varchar2(20),
    vac_str      date,
    vac_end      date,
    vac_type     varchar2(10),
    vac_cnt      number,
    spare1       varchar2(255),
    spare2       varchar2(255),
    spare3       varchar2(255),
    spare4       varchar2(255),
    rgtr_id      varchar2(64),
    rgtr_dt      date,
    mdfr_id      varchar2(64),
    mdfr_dt      date
);

-- pk
alter table tb_vac
add constraint tb_vac_pk primary key(idx);

-- ����� �ð��� ���� ��¥ ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy/MM/dd HH24:MI:SS';

-- ���� �׽�Ʈ�� ������ ���� (����� || CONCAT ���)
insert into tb_vac values
(seq_atd_idx.nextval, 'test1', '20220918'||seq_vac_sn.nextval, '20220920', '20220923', '����', 4, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test2', '20220223'||seq_vac_sn.nextval, null, null, null, null, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test3', '20220918'||seq_vac_sn.nextval, '20220920', '20220923', '����', 4, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test4', '20220708'||seq_vac_sn.nextval, null, null, null, null, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test5', '20220918'||seq_vac_sn.nextval, '20220920', '20220923', '����', 4, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test6', '20220223'||seq_vac_sn.nextval, null, null, null, null, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test7', '20220918'||seq_vac_sn.nextval, '20220920', '20220923', '����', 4, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test8', '20220708'||seq_vac_sn.nextval, null, null, null, null, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test9', '20220918'||seq_vac_sn.nextval, '20221020', '20221021', '����', 2, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test10', '20220223'||seq_vac_sn.nextval, null, null, null, null, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test11', '20220918'||seq_vac_sn.nextval, '20220921', '20220923', '����', 3, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test12', '20220708'||seq_vac_sn.nextval, null, null, null, null, null, null, null, null, 'admin', sysdate, null, null);

-- ���̺� Ȯ�� �� �ʱ�ȭ��
select * from tb_vac;
delete from tb_vac;

-- COMMIT �ʼ�
commit;

--�����ڿ����� ********************************************************************************************************************************************************

--���-----------------------------------------
--���̺� ����
create table tb_eqm(
    idx number not null,
    eqm_nm varchar2(100) not null,
    eqm_use_dep varchar2(50) not null,
    eqm_man_dep varchar2(50) not null,
    eqm_num varchar2(100),
    eqm_com varchar2(50),
    eqm_buy_date date,
    eqm_ins_date date,
    eqm_tel varchar2(20),
    eqm_rep_req_date date,
    eqm_rep_com_date date,
    eqm_amount number,
    eqm_price number,
    spare1 varchar2(255),
    spare2 varchar2(255),
    spare3 varchar2(255)
);
-- ���̺� ��ȸ, ����
drop table tb_eqm;
select * from tb_eqm;
-- PK ���
alter table tb_eqm
add constraint tb_eqm_pk primary key(idx);
-- ������ ����, ����
drop sequence seq_eqm_idx;
create sequence seq_eqm_idx
start with 1
increment by 1;
--DB ������ ���� �ڵ� 
insert into tb_eqm VALUES(seq_eqm_idx.nextval, '��ǻ��', '�ѹ�', '����','sjt-17865','LG',sysdate,sysdate,'070-1234-1234', '2022-04-06','2022-05-11',7,14000000,'','','');
insert into tb_eqm VALUES(seq_eqm_idx.nextval, '��Ʈ��', '�ѹ�', '����','NT900X5N-X58','SAMSUNG',sysdate,sysdate,'02-789-1234', '2022-05-03','2022-06-12',5,907100,'','','');
insert into tb_eqm VALUES(seq_eqm_idx.nextval, '�����', '�λ�', '����','G25-10,65FEGAC2KR','DELL',sysdate,sysdate,'070-1234-1234', '','',6,6045000,'','','');
insert into tb_eqm VALUES(seq_eqm_idx.nextval, 'Ű����', '��ȹ', '����','vsf-17865','',sysdate,sysdate,'053-668-4567', '','',5,250000,'','','');
insert into tb_eqm VALUES(seq_eqm_idx.nextval, 'å��', '����1', '����','qrwer-17865','iloom',sysdate,sysdate,'053-259-5942', '2022-09-06','2022-09-08',1,700000,'','','');
insert into tb_eqm VALUES(seq_eqm_idx.nextval, '����', '����2', '����','dfFD56','desker',sysdate,sysdate,'010-2562-0080', '2022-09-27','',3,3789000,'','','');
insert into tb_eqm VALUES(seq_eqm_idx.nextval, 'å��', '��ȹ', '����','dfd5fe','LG',sysdate,sysdate,'010-3698-1754', '','',5,5580000,'','','');

--������ �뷮 ����, Ȯ�� 
insert into tb_eqm (IDX, eqm_nm, eqm_use_dep, eqm_man_dep, eqm_num, eqm_com, eqm_buy_date, eqm_ins_date, eqm_tel, eqm_rep_req_date, eqm_rep_com_date, eqm_amount, eqm_price)
(select SEQ_EQM_IDX.NEXTVAL, eqm_nm, eqm_use_dep, eqm_man_dep, eqm_num, eqm_com, eqm_buy_date, eqm_ins_date, eqm_tel, eqm_rep_req_date, eqm_rep_com_date, eqm_amount, eqm_price from TB_EQM);

select count(*) from tb_EQM;


commit;


--S/W-----------------------------------------------------------------------------------------
--���̺� ����
create table tb_sw(
    idx number not null,
    sw_nm varchar2(100) not null,
    sw_use_dep varchar2(50) not null,
    sw_man_dep varchar2(50) not null,
    sw_num varchar2(100),
    sw_com varchar2(50),
    sw_buy_date date,
    sw_ins_date date,
    sw_renew_date date,
    sw_tel varchar2(20),
    sw_amount number,
    sw_price number,
    spare1 varchar2(255),
    spare2 varchar2(255),
    spare3 varchar2(255)
);
-- ���̺� ��ȸ, ����
drop table tb_sw;
select * from tb_sw;
-- PK�� ���
alter table tb_sw
add constraint tb_sw_pk primary key(idx);
-- ������ ����, ����
drop sequence seq_sw_idx;
create sequence seq_sw_idx
start with 1
increment by 1;

--DB ������ ���� 
insert into tb_sw values(seq_sw_idx.nextval, 'windows10', 'ȸ��','����','s7gh-k7h3-t2y9-y9p6','microsoft','2021-05-04','2021-05-04','2023-09-15','070-0000-0000',1 ,250000,'','','');
insert into tb_sw values(seq_sw_idx.nextval, 'windows10', '����','����','T87-KE7-008-EY0','microsoft','2023-09-15','2023-09-15','2024-09-15','070-0000-0000', 1,300000,'','','');
insert into tb_sw values(seq_sw_idx.nextval, 'intellij', '����','����','M2K345','JetBrains','2021-06-03','2021-06-03','2022-07-03','070-846-8888', 1,600000,'','','');
insert into tb_sw values(seq_sw_idx.nextval, 'intellij', '����','����','INF2546','JetBrains','2022-05-04','2022-05-04','2025-09-06','070-846-8888', 1,600000,'','','');
insert into tb_sw values(seq_sw_idx.nextval, 'SqlDeveloper', 'ȸ��','����','k7h3','ORACLE','2022-09-27','','2023-09-15','070-0000-0000', 3,300000,'','','');
insert into tb_sw values(seq_sw_idx.nextval, 'Adobe Premiere Pro', '������','����','SGR7805FE3','Adobe','2021-05-04','2023-09-15','','', 1,1520000,'','','');
insert into tb_sw values(seq_sw_idx.nextval, 'VisualStudioCode', '������','����','s7gh-k7h3-t2y9-y9p6','microsoft','2021-05-04','2023-09-15','','', 2,800000,'','','');

-- ������ �뷮 ����, ��ȸ
insert into tb_SW (IDX, sw_nm,sw_use_dep,sw_man_dep,sw_num,sw_com,sw_buy_date,sw_ins_date,sw_renew_date,sw_tel,sw_amount,sw_price)
(select SEQ_SW_IDX.NEXTVAL, sw_nm,sw_use_dep,sw_man_dep,sw_num,sw_com,sw_buy_date,sw_ins_date,sw_renew_date,sw_tel,sw_amount,sw_price from TB_SW);

select count(*) from tb_SW;

commit;

            
--�ü�-------------------------------------------------------------------------------
--���̺� ����
create table tb_fct(
    idx number not null,
    fct_nm VARCHAR(20),
    fct_user_sn VARCHAR(20),
    fct_str date,
    fct_end date,
    spare1 varchar2(255),
    spare2 varchar2(255),
    spare3 varchar2(255)
 );
--���̺� ��ȸ, ����
drop table tb_fct;
select * from tb_fct;
-- PK�� ����
alter table tb_fct
add constraint tb_fct_pk primary key(idx);
--������ ����, ����
DROP SEQUENCE SEQ_FCT_IDX;
create sequence seq_fct_idx
start with 1
increment by 1;

--DB ������ ����
insert into tb_fct VALUES(seq_fct_idx.nextval, 'ȸ�ǽ�1', 'QEX789', '2022/09/20','2022/09/20','','','');
insert into tb_fct VALUES(seq_fct_idx.nextval, '���̳���1', 'QEX789', '2022/09/23','2022/09/23','','','');
insert into tb_fct VALUES(seq_fct_idx.nextval, 'ȸ�ǽ�2', 'QEW500', '2022/07/20','2022/07/20','','','');
insert into tb_fct VALUES(seq_fct_idx.nextval, 'ȸ�ǽ�2', 'MER258', '2022/09/21','2022/09/21','','','');
insert into tb_fct VALUES(seq_fct_idx.nextval, '���̳���2', 'BRW023', '2022/08/19','2022/08/20','','','');
insert into tb_fct VALUES(seq_fct_idx.nextval, '���߽�', 'BRW011', '2022/08/12','2022/08/13','','','');
--�뷮 ����, ��ȸ
insert into tb_FCT (IDX, FCT_NM, FCT_USER_SN, FCT_STR, FCT_END)
(select SEQ_FCT_IDX.NEXTVAL, FCT_NM, FCT_USER_SN, FCT_STR, FCT_END from TB_FCT);

commit;


--������Ʈ �ڿ� ���� ********************************************************************************************************************************************************

--������Ʈ �������� ���̺� �ۼ�
create table prj_info_tb (
 idx number NOT NULL,
 prjinfo_prjnm varchar(50) not null,
 prjinfo_ef varchar(200),
 prjinfo_cp varchar(100),
 prjinfo_task varchar(200),
 prjinfo_req varchar(200),
 prjinfo_sales varchar(200),
 prjinfo_tool varchar(200),
 prjinfo_cpmanager varchar(30),
 prjinfo_cptel varchar(50),
 prjinfo_cpfax varchar(50)
 );
 

--���̺� ���� �� ��ȸ
DROP TABLE PRJ_INFO_TB;
SELECT * FROM PRJ_INFO_TB;

--������Ʈ �������� Primary key �ۼ�
alter table prj_info_tb add constraint TB_PRJINFO_PK
primary key (idx);

--������Ʈ �������� IDX ������ �ۼ�
create sequence SEQ_PRJINFO_IDX
start with 1
increment by 1;
--DROP SEQUENCE SEQ_PRJINFO_IDX;

--������Ʈ �������� �����ͻ���
insert into prj_info_tb values
(SEQ_PRJINFO_IDX.nextval, 'prjkit','�繫�۾��� ������','ETU','PMS����','���� �� ����','300,000,000','Eclipse','������','053-281-1590','053-109-9090');
insert into prj_info_tb values
(SEQ_PRJINFO_IDX.nextval, 'prjkit',NULL,'KITE',NULL,NULL,'',NULL,NULL,'010-9090-8080',NULL);
insert into prj_info_tb values
(SEQ_PRJINFO_IDX.nextval, 'prjkit','���ο� �۾��� ������',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert into prj_info_tb values
(SEQ_PRJINFO_IDX.nextval, 'prjkit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert into prj_info_tb values
(SEQ_PRJINFO_IDX.nextval, 'prjetu','���ȿ��','ETU','�������','��û����','1,200,000,000','eclipse','������','053-998-0000','053-104-1390');
insert into prj_info_tb values
(SEQ_PRJINFO_IDX.nextval, 'prjetu',NULL,NULL,NULL,'��û����2',NULL,'spring',NULL,NULL,NULL);
insert into prj_info_tb values
(SEQ_PRJINFO_IDX.nextval, 'prjetu',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert into prj_info_tb values
(SEQ_PRJINFO_IDX.nextval, 'prjsb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);


--������ �뷮 ����
INSERT INTO PRJ_INFO_TB (IDX, PRJINFO_PRJNM, PRJINFO_EF,PRJINFO_CP,PRJINFO_TASK,PRJINFO_REQ,PRJINFO_SALES,PRJINFO_TOOL,PRJINFO_CPMANAGER,PRJINFO_CPTEL,PRJINFO_CPFAX)
(SELECT SEQ_PRJINFO_IDX.nextval, PRJINFO_PRJNM, PRJINFO_EF,PRJINFO_CP,PRJINFO_TASK,PRJINFO_REQ,PRJINFO_SALES,PRJINFO_TOOL,PRJINFO_CPMANAGER,PRJINFO_CPTEL,PRJINFO_CPFAX FROM PRJ_INFO_TB);

select count(*) from PRJ_INFO_TB;

COMMIT;


--������Ʈ �ο����� ���̺� �ۼ�
create table prj_mbr_tb(
	idx number not null,
	prjmbr_prjnm varchar(50) not null,
	prjmbr_total number,
	prjmbr_lev varchar(30) not null,
	prjmbr_mbrnm varchar(30) not null,
	prjmbr_mbrtask varchar(30) not null
);

DROP TABLE PRJ_MBR_TB;
SELECT * FROM PRJ_MBR_TB;
 
--������Ʈ �ο����� PRIMARY KEY �ۼ�
alter table prj_mbr_tb add constraint TB_PRJMBR_PK
primary key (idx);

--������Ʈ �ο����� IDX ������ �ۼ�
create sequence SEQ_PRJMBR_IDX
start with 1
increment by 1;

--������Ʈ �ο����� ������ ����
DROP SEQUENCE SEQ_PRJMBR_IDX;

--������Ʈ �ο����� �����ͻ���
insert into prj_mbr_tb values
(SEQ_PRJMBR_IDX.nextval, 'prjkit','8','����','�����','�Ѱ�');
insert into prj_mbr_tb values
(SEQ_PRJMBR_IDX.nextval, 'prjkit','8','������','����ȣ','������');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjkit','8','����','Ȳ����','������');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjkit','8','����','���쿵','����');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjkit','8','����','Ȳ����','����');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjkit','8','����','���缺','����');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjkit','8','����','��±�','����');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjkit','8','����','�迵��','����');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjetu','6','����','���ؼ�','�Ѱ�');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjetu','6','������','�̽���','������');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjetu','6','����','��ȫ��','����');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjetu','6','����','������','����');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjetu','6','����','�賫��','����');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjetu','6','����','������','����');

insert into prj_mbr_tb values 
(SEQ_PRJMBR_IDX.nextval, 'prjsb','1','����','������','�ӽ�');


--������Ʈ �ο����� ������ �뷮���� ����
INSERT INTO PRJ_MBR_TB(IDX,PRJMBR_PRJNM,PRJMBR_TOTAL,PRJMBR_LEV,PRJMBR_MBRNM,PRJMBR_MBRTASK)
(SELECT SEQ_PRJMBR_IDX.nextval,PRJMBR_PRJNM,PRJMBR_TOTAL,PRJMBR_LEV,PRJMBR_MBRNM,PRJMBR_MBRTASK FROM PRJ_MBR_TB);

select count(*) from PRJ_MBR_TB;

COMMIT;


 --������Ʈ �������� ���̺� �ۼ�
create table prj_sche_tb(
	idx number not null,
	prjsche_prjnm varchar(50) not null,
	prjsche_sdate date,
	prjsche_edate date
);
 
--���̺� ��ȸ, ����
drop table PRJ_SCHE_TB;
select * from PRJ_SCHE_TB; 

--������Ʈ �������� PRIMARY KEY �ۼ�
alter table prj_sche_tb add constraint TB_PRJSCHE_PK
primary key (idx);

--������ �ʱ�ȭ��
DROP SEQUENCE SEQ_PRJSCHE_IDX;

--������Ʈ �������� IDX ������ �ۼ�
create sequence SEQ_PRJSCHE_IDX
start with 1
increment by 1;

--������Ʈ �������� �����ͻ���
insert into prj_sche_tb values 
(SEQ_PRJSCHE_IDX.nextval, 'prjkit','2022-09-16','2022-09-28');

insert into prj_sche_tb values 
(SEQ_PRJSCHE_IDX.nextval, 'prjetu','2022-08-10','2022-10-29');

insert into prj_sche_tb values 
(SEQ_PRJSCHE_IDX.nextval, 'prjsb','2022-09-30','2022-12-31');

INSERT INTO PRJ_SCHE_TB(IDX,PRJSCHE_PRJNM,PRJSCHE_SDATE,PRJSCHE_EDATE)
(SELECT SEQ_PRJSCHE_IDX.NEXTVAL,PRJSCHE_PRJNM,PRJSCHE_SDATE,PRJSCHE_EDATE FROM PRJ_SCHE_TB);

select count(*) from PRJ_SCHE_TB;

COMMIT;

--TABLE ������ �ʱ�ȭ��
TRUNCATE TABLE PRJ_INFO_TB;
TRUNCATE TABLE PRJ_MBR_TB;
TRUNCATE TABLE PRJ_SCHE_TB;


--�����Խ���/��������/�ڷ�� ********************************************************************************************************************************************************


--DROP TABLE TB_COMMUNITY;
--DROP TABLE TB_POST;
--DROP TABLE TB_REFERENCEROOM;
-- ���� �Խ���
CREATE TABLE TB_COMMUNITY(
    IDX NUMBER(20) NOT NULL, -- �ε���
    CUM_TITLE VARCHAR2(255) NOT NULL, -- ����
    CUM_CONTENTS VARCHAR2(3000) NOT NULL, -- ����
    CUM_WRITER VARCHAR2(255) NOT NULL, -- �ۼ���
    CUM_REGISTER_TIME DATE -- �ð�
);
ALTER TABLE TB_COMMUNITY
ADD CONSTRAINT TB_COMMUNITY_PK PRIMARY KEY(IDX);

--��������
CREATE TABLE TB_POST(
    IDX NUMBER(20) NOT NULL, --�ε���
    POST_TITLE VARCHAR2(100) NOT NULL, -- ����
    POST_CONTENT VARCHAR2(3000) NOT NULL, -- ����
    POST_WRITER  VARCHAR2(20) NOT NULL, -- �ۼ���
    POST_REGISTER_TIME DATE -- �ð�
);
ALTER TABLE TB_POST
ADD CONSTRAINT TB_POST_PK PRIMARY KEY(IDX);


-- idx �� ����� ������
CREATE SEQUENCE TB_COMMUNITY_IDX
START WITH 1
INCREMENT BY 1;

-- idx �� ����� ������
CREATE SEQUENCE TB_POST_IDX
START WITH 1
INCREMENT BY 1;


-- ������ �ʱ�ȭ��
--DROP SEQUENCE TB_COMMUNITY_IDX;
--DROP SEQUENCE TB_POST_IDX;
--DROP SEQUENCE TB_REFERENCEROOM_IDX;

-- ��¥ ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy-MM-dd';


--
SELECT * FROM TB_COMMUNITY;
SELECT * FROM TB_POST;
--SELECT * FROM TB_REFERENCEROOM;


DESC TB_COMMUNITY;
DESC TB_POST;

insert into tb_community (IDX, CUM_TITLE,CUM_CONTENTS,CUM_WRITER) values (TB_COMMUNITY_IDX.NEXTVAL,'���������ٱ�','�Ķ������ٱ�','ȭ��Ǳͽ�');
insert into tb_community (IDX, CUM_TITLE,CUM_CONTENTS,CUM_WRITER) values (TB_COMMUNITY_IDX.NEXTVAL,'������ ������','���','������');
insert into tb_community (IDX, CUM_TITLE,CUM_CONTENTS,CUM_WRITER) values (TB_COMMUNITY_IDX.NEXTVAL,'�󱸴�','����','����Ŭ����');
insert into tb_community (IDX, CUM_TITLE,CUM_CONTENTS,CUM_WRITER) values (TB_COMMUNITY_IDX.NEXTVAL,'������','4����ȭ','����ȯ');
insert into tb_community (IDX, CUM_TITLE,CUM_CONTENTS,CUM_WRITER) values (TB_COMMUNITY_IDX.NEXTVAL,'��������','0ų5����','�߽���');
insert into tb_community (IDX, CUM_TITLE,CUM_CONTENTS,CUM_WRITER) values (TB_COMMUNITY_IDX.NEXTVAL,'�ٹ��','�������','�ٹ��');
insert into tb_community (IDX, CUM_TITLE,CUM_CONTENTS,CUM_WRITER) values (TB_COMMUNITY_IDX.NEXTVAL,'��Ÿũ����Ʈ','20��°','�ʺ���');
insert into tb_community (IDX, CUM_TITLE,CUM_CONTENTS,CUM_WRITER) values (TB_COMMUNITY_IDX.NEXTVAL,'�츮��','����','�ֽ�');
insert into tb_community (IDX, CUM_TITLE,CUM_CONTENTS,CUM_WRITER) values (TB_COMMUNITY_IDX.NEXTVAL,'������','�Ⱦ�����','������');
insert into tb_community (IDX, CUM_TITLE,CUM_CONTENTS,CUM_WRITER) values (TB_COMMUNITY_IDX.NEXTVAL,'��������','��������','�ŵ���');

insert into tb_post (IDX,POST_TITLE,POST_CONTENT,POST_WRITER ) values (TB_POST_IDX.NEXTVAL,'���������ٱ�','�Ķ������ٱ�','ȭ��Ǳͽ�');
insert into tb_post (IDX,POST_TITLE,POST_CONTENT,POST_WRITER) values (TB_POST_IDX.NEXTVAL,'������ ������','���','������');
insert into tb_post (IDX,POST_TITLE,POST_CONTENT,POST_WRITER) values (TB_POST_IDX.NEXTVAL,'�󱸴�','����','����Ŭ����');
insert into tb_post (IDX,POST_TITLE,POST_CONTENT,POST_WRITER) values (TB_POST_IDX.NEXTVAL,'������','4����ȭ','����ȯ');
insert into tb_post (IDX,POST_TITLE,POST_CONTENT,POST_WRITER) values (TB_POST_IDX.NEXTVAL,'��������','0ų5����','�߽���');
insert into tb_post (IDX,POST_TITLE,POST_CONTENT,POST_WRITER) values (TB_POST_IDX.NEXTVAL,'�ٹ��','����̳���','�ٹ��');
insert into tb_post (IDX,POST_TITLE,POST_CONTENT,POST_WRITER) values (TB_POST_IDX.NEXTVAL,'��Ÿũ����Ʈ','�׶�Ȳ��','�ӿ�ȯ');
insert into tb_post (IDX,POST_TITLE,POST_CONTENT,POST_WRITER) values (TB_POST_IDX.NEXTVAL,'�츮��','�̵�','����');
insert into tb_post (IDX,POST_TITLE,POST_CONTENT,POST_WRITER) values (TB_POST_IDX.NEXTVAL,'�ܿ￡','���ִ�','�ؾ');
insert into tb_post (IDX,POST_TITLE,POST_CONTENT,POST_WRITER) values (TB_POST_IDX.NEXTVAL,'������','���ñ���','��ȸ�ǿ�');

insert into tb_community (IDX, CUM_TITLE, CUM_CONTENTS, CUM_WRITER, CUM_REGISTER_TIME)
(select TB_COMMUNITY_IDX.NEXTVAL, CUM_TITLE, CUM_CONTENTS, CUM_WRITER, SYSDATE from TB_COMMUNITY);

insert into tb_post (IDX, POST_TITLE, POST_CONTENT, POST_WRITER, POST_REGISTER_TIME)
(select TB_POST_IDX.NEXTVAL, POST_TITLE, POST_CONTENT, POST_WRITER, SYSDATE from TB_POST);

COMMIT;

desc tb_mbr;

select count(*) from tb_fct;