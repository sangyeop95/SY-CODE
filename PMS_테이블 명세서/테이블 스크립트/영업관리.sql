create table TB_AGEN_INFO (
    AGEN_INFO_IDX       NUMBER NOT NULL,
    AGEN_INFO_ACD	    VARCHAR2(50) NOT NULL,
    AGEN_INFO_COUN	    VARCHAR2(50) NOT NULL,
    AGEN_INFO_AN	    VARCHAR2(50) NOT NULL,
    AGEN_INFO_PAN	    VARCHAR2(50),
    AGEN_INFO_BRN	    NUMBER      NOT NULL,
    AGEN_INFO_CRN	    NUMBER      NOT NULL,
    AGEN_INFO_BEN	    VARCHAR2(50),
    AGEN_INFO_RSSN	    NUMBER      NOT NULL,
    AGEN_INFO_RN	    VARCHAR2(50) NOT NULL,
    AGEN_INFO_RTEL	    VARCHAR2(50) NOT NULL,
    AGEN_INFO_RFN	    VARCHAR2(50),
    AGEN_INFO_REMAIL	VARCHAR2(255) NOT NULL,
    AGEN_INFO_ZCODE	    VARCHAR2(50) NOT NULL,
    AGEN_INFO_ADD	    VARCHAR2(255) NOT NULL,
    AGEN_INFO_AWEBSITE	VARCHAR2(255),
    AGEN_INFO_MANAGER	VARCHAR2(50) NOT NULL,
    AGEN_INFO_MSSN	    NUMBER      NOT NULL,
    AGEN_INFO_MTN	    VARCHAR2(50) NOT NULL,
    AGEN_INFO_MEMAIL	VARCHAR2(200) NOT NULL,
    RGTR_ID	        VARCHAR2(50) NOT NULL,
    RGTR_DT	        DATE         NOT NULL,
    MDFR_ID	        VARCHAR2(50) NOT NULL,
    MDFR_DT	        DATE

);

DROP TABLE TB_AGEN_INFO;

alter table TB_AGEN_INFO
add constraint AGEN_INFO_IDX_PK primary key(AGEN_INFO_IDX);


-- Foreign key --
alter table TB_AGEN_INFO
add constraint AGEN_INFO_MANAGER_FK foreign key(AGEN_INFO_MANAGER) references tb_mbr(MBR_NM);

alter table TB_AGEN_INFO
add constraint AGEN_INFO_MSSN_FK foreign key(AGEN_INFO_MSSN) references tb_mbr(MBR_BIRTH);

alter table TB_AGEN_INFO
add constraint AGEN_INFO_MTN_FK foreign key(AGEN_INFO_MTN) references tb_mbr(MBR_DEP_CD);

alter table TB_AGEN_INFO
add constraint AGEN_INFO_MEMAIL_FK foreign key(AGEN_INFO_MEMAIL) references tb_mbr(MBR_EM);

alter table TB_AGEN_INFO
add constraint RGTR_ID_FK foreign key(RGTR_ID) references tb_mbr(mbr_id);

alter table TB_SPEND_INFO
add constraint MDFR_ID_FK foreign key(MDFR_ID) references tb_mbr(mbr_id);


-- idx �� ����� ������
create sequence seq_agen_idx
start with 1
increment by 1;

--create sequence seq_atd_sn
--start with 300
--increment by 1;

-- ������ �ʱ�ȭ��
drop sequence seq_agen_idx;


-- ���� �׽�Ʈ�� ������ ���� (����� || CONCAT ���)

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '101', '���ѹα�', '������', '���뵿��', '1010312345', '123456789', 'KIM', '910854', '�����', '053-1234-5678', '123-123456', 'abc@naver.com','101-05','����� �ý�', 'www.naer.com', '��Ŵ���','900201','�渮��','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);


INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '102', '���ѹα�', '�б�', '����û', '10103155', '987654321', 'PARK', '880854', '�豳��', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','�뱸�� �ý�', 'www.naer.com', '�輱��','900201','������','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '103', '���ѹα�', '��', '����û', '10103155', '987654321', 'PARK', '880854', '�豳��', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','�λ�� �ý�', 'www.naer.com', '�輱��','900201','������','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '104', '���ѹα�', '�п�', '����û', '10103155', '987654321', 'PARK', '880854', '�豳��', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','�ȵ��� �ý�', 'www.naer.com', '�輱��','900201','������','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '105', '���ѹα�', '�б�', '����û', '10103155', '987654321', 'PARK', '880854', '�豳��', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','���̽� �ý�', 'www.naer.com', '�ڼ���','900201','������','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '106', '���ѹα�', '�б�', '����û', '10103155', '987654321', 'PARK', '880854', '�豳��', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','â���� �ý�', 'www.naer.com', '�輱��','900201','������','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '107', '���ѹα�', '�б�', '����û', '10103155', '987654321', 'PARK', '880854', '�豳��', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','�뱸�� �ý�', 'www.naer.com', '�輱��','900201','������','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '108', '���ѹα�', '�б�', '����û', '10103155', '987654321', 'PARK', '880854', '�豳��', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','���ֽ� �ý�', 'www.naer.com', '�輱��','900201','������','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);


-- ���̺� Ȯ�� �� �ʱ�ȭ��
select * from TB_AGEN_INFO;
delete from TB_AGEN_INFO;

-- COMMIT �ʼ�
commit;

desc TB_AGEN_INFO;


-- SPEND_INFO ���� -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create table TB_SPEND_INFO (
    SPEND_MANA_IDX NUMBER NOT NULL,
    SPEND_MANA_DEP VARCHAR2(20) NOT NULL,
    SPEND_MANA_MANA VARCHAR2(50) NOT NULL,
    SPEND_MANA_ACC VARCHAR2(50) NOT NULL,
    SPEND_MANA_AS  VARCHAR2(250) NOT NULL,
    SPEND_MANA_BRI VARCHAR2(250) NOT NULL,
    SPEND_MANA_AMO NUMBER NOT NULL,
    SPEND_MANA_COSTP VARCHAR2(250) NOT NULL,
    SPEND_MANA_MEMO VARCHAR2(250),
    RGTR_ID VARCHAR2(64) NOT NULL,
    RGTR_DT DATE NOT NULL,
    MDFR_ID VARCHAR2(64) NOT NULL,
    MDFR_DT DATE     
);

DROP TABLE TB_SPEND_INFO;

alter table TB_SPEND_INFO
add constraint SPEND_MANA_IDX_PK primary key(SPEND_MANA_IDX);

-- FOREIGN KEY --
alter table TB_SPEND_INFO
add constraint SPEND_MANA_DEP_FK foreign key(SPEND_MANA_DEP) references tb_mbr(MBR_DEP_CD);

alter table TB_SPEND_INFO
add constraint SPEND_MANA_MANA_FK foreign key(SPEND_MANA_MANA) references tb_mbr(mbr_nm);

alter table TB_SPEND_INFO
add constraint RGTR_ID_FK foreign key(RGTR_ID) references tb_mbr(mbr_id);

alter table TB_SPEND_INFO
add constraint MDFR_ID_FK foreign key(MDFR_ID) references tb_mbr(mbr_id);


-- idx �� ����� ������
create sequence SEQ_SPEND_IDX
start with 1
increment by 1;

--create sequence seq_atd_sn
--start with 300
--increment by 1;

-- ������ �ʱ�ȭ��
drop sequence SEQ_SPEND_IDX;
 

-- ���� �׽�Ʈ�� ������ ���� (����� || CONCAT ���)

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '�λ��', '����', '������', '�����Ļ���', '���ɰ�', '8000', '����ī��', '�ѿ����', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '�ѹ���', '�ڴ��', 'ī��', '�����Ļ���', 'Ŀ�ǰ�', '12000', '����ī��', 'ī��� ����', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '�����', '�ִ��', 'ī��', '�����Ļ���', 'Ŀ�ǰ�', '12000', '����ī��', '�����߶� ����', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '�渮��', '�Ӵ��', 'ī��', '�����Ļ���', '���ڰ�', '12000', '����ī��', '���̽�Ƽ ����', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '�ѹ���', '�ڴ��', 'ī��', '�Ĵ�', '����', '12000', '����ī��', '�� ����', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '�ѹ���', '�ڴ��', 'ī��', 'ȸ��', 'Ŀ�ǰ�', '12000', '����', '���̽���� ����', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '�渮��', '�ڴ��', 'ī��', '�����Ļ���', 'Ŀ�ǰ�', '12000', '����ī��', '�Ƹ޸�ī�� ����', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '�����', '�ڴ��', 'ī��', '�����Ļ���', 'Ŀ�ǰ�', '12000', '����ī��', '�Ƹ޸�ī�� ����', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);



-- ���̺� Ȯ�� �� �ʱ�ȭ��
select * from TB_SPEND_INFO;
delete from TB_SPEND_INFO;

-- COMMIT �ʼ�
commit;

desc TB_SPEND_INFO;