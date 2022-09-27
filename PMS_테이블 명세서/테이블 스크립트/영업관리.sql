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


-- idx 및 사번용 시퀀스
create sequence seq_agen_idx
start with 1
increment by 1;

--create sequence seq_atd_sn
--start with 300
--increment by 1;

-- 시퀀스 초기화용
drop sequence seq_agen_idx;


-- 매퍼 테스트용 데이터 삽입 (사번은 || CONCAT 사용)

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '101', '대한민국', '교육원', '고용노동부', '1010312345', '123456789', 'KIM', '910854', '김김진', '053-1234-5678', '123-123456', 'abc@naver.com','101-05','서울시 시시', 'www.naer.com', '김매니저','900201','경리부','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);


INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '102', '대한민국', '학교', '교육청', '10103155', '987654321', 'PARK', '880854', '김교육', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','대구시 시시', 'www.naer.com', '김선생','900201','교육부','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '103', '대한민국', '집', '교육청', '10103155', '987654321', 'PARK', '880854', '김교육', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','부산시 시시', 'www.naer.com', '김선생','900201','교육부','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '104', '대한민국', '학원', '교육청', '10103155', '987654321', 'PARK', '880854', '김교육', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','안동시 시시', 'www.naer.com', '김선생','900201','교육부','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '105', '대한민국', '학교', '교육청', '10103155', '987654321', 'PARK', '880854', '김교육', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','구미시 시시', 'www.naer.com', '박선생','900201','교육부','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '106', '대한민국', '학교', '교육청', '10103155', '987654321', 'PARK', '880854', '김교육', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','창원시 시시', 'www.naer.com', '김선생','900201','교육부','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '107', '대한민국', '학교', '교육청', '10103155', '987654321', 'PARK', '880854', '김교육', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','대구시 시시', 'www.naer.com', '김선생','900201','교육부','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);

INSERT INTO TB_AGEN_INFO VALUES 
(SEQ_AGEN_IDX.NEXTVAL, '108', '대한민국', '학교', '교육청', '10103155', '987654321', 'PARK', '880854', '김교육', '053-9875-5678', '123-123456', 'abc@naver.com','101-21','영주시 시시', 'www.naer.com', '김선생','900201','교육부','bbb@naver.com', '2022/09/19', SYSDATE, '2022/08/19', SYSDATE);


-- 테이블 확인 및 초기화용
select * from TB_AGEN_INFO;
delete from TB_AGEN_INFO;

-- COMMIT 필수
commit;

desc TB_AGEN_INFO;


-- SPEND_INFO 시작 -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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


-- idx 및 사번용 시퀀스
create sequence SEQ_SPEND_IDX
start with 1
increment by 1;

--create sequence seq_atd_sn
--start with 300
--increment by 1;

-- 시퀀스 초기화용
drop sequence SEQ_SPEND_IDX;
 

-- 매퍼 테스트용 데이터 삽입 (사번은 || CONCAT 사용)

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '인사과', '김담당', '정육점', '복리후생비', '점심값', '8000', '법인카드', '한우먹음', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '총무부', '박담당', '카페', '복리후생비', '커피값', '12000', '법인카드', '카페라떼 먹음', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '생산부', '최담당', '카페', '복리후생비', '커피값', '12000', '법인카드', '마끼야또 먹음', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '경리부', '임담당', '카페', '복리후생비', '과자값', '12000', '법인카드', '아이스티 먹음', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '총무부', '박담당', '카페', '식대', '물값', '12000', '법인카드', '물 먹음', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '총무부', '박담당', '카페', '회식', '커피값', '12000', '현금', '아이슈페너 먹음', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '경리부', '박담당', '카페', '복리후생비', '커피값', '12000', '법인카드', '아메리카노 먹음', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);

INSERT INTO TB_SPEND_INFO VALUES 
(SEQ_SPEND_IDX.NEXTVAL, '생산부', '박담당', '카페', '복리후생비', '커피값', '12000', '법인카드', '아메리카노 먹음', '2022/09/17', SYSDATE, '2022/08/12', SYSDATE);



-- 테이블 확인 및 초기화용
select * from TB_SPEND_INFO;
delete from TB_SPEND_INFO;

-- COMMIT 필수
commit;

desc TB_SPEND_INFO;