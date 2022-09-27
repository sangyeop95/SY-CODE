create table tb_eqm(
    idx number not null,
    eqm_nm varchar2(100) not null,
    eqm_use_dep_CD varchar2(6) not null,
    eqm_man_dep_CD varchar2(6) not null,
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
    spare3 varchar2(255),
    rgtr_id varchar2(64) not null,
    rgtr_dt date not null,
    mdfr_id varchar2(64) not null,
    mdfr_dt date not null
);

drop table tb_eqm;
select * from tb_eqm;

alter table tb_eqm
add constraint tb_eqm_pk primary key(idx);

create sequence seq_eqm_idx
start with 1
increment by 1;

insert into tb_eqm VALUES(seq_eqm_idx.nextval, '컴퓨터', '영업', '영업','sjt-17865','LG',sysdate,sysdate,'070-1234-1234', '','',15,700000,'','','','kim',sysdate,'kim',sysdate);

create table tb_sw(
    idx number not null,
    sw_nm varchar2(100) not null,
    sw_use_dep_CD varchar2(6) not null,
    sw_man_dep_CD varchar2(6) not null,
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
    spare3 varchar2(255),
    rgtr_id varchar2(64) not null,
    rgtr_dt date not null,
    mdfr_id varchar2(64) not null,
    mdfr_dt date not null
);

drop table tb_sw;
select * from tb_sw;

alter table tb_sw
add constraint tb_sw_pk primary key(idx);

create sequence seq_sw_idx
start with 1
increment by 1;

insert into tb_sw values(seq_sw_idx.nextval, 'windows10', '영업','영업','s7gh-k7h3-t2y9-y9p6','microsoft','2007-03-25','2007-03-25','','070-0000-0000', 15,300000,'','','','lee',sysdate,'lee',sysdate);

create table tb_fct(
    idx number not null,
    fct_nm VARCHAR(20),
    fct_user_sn VARCHAR(20),
    fct_str date,
    fct_end date,
    spare1 varchar2(255),
    spare2 varchar2(255),
    spare3 varchar2(255),
    rgtr_id varchar2(64) not null,
    rgtr_dt date not null,
    mdfr_id varchar2(64) not null,
    mdfr_dt date not null
 );

alter table tb_fct
add constraint tb_fct_pk primary key(idx);

create sequence seq_fct_idx
start with 1
increment by 1;

insert into tb_fct VALUES(seq_fct_idx.nextval, '회의실', 'ftt-20030512', '2022/09/20','2022/09/20','','','','kang',sysdate,'kang',sysdate);

drop table tb_fct;
select * from tb_fct;
