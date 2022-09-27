-- <출결 관리>
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

drop table tb_atd;

-- pk
alter table tb_atd
add constraint tb_atd_pk primary key(idx);

-- fk
-- 부모키 값 존재하지 않는다는 에러 발생
-- ORA-02291: 무결성 제약조건(KUTSBANK.SYS_C008885)이 위배되었습니다- 부모 키가 없습니다.
-- alter table tb_vac add constraint tb_atd_nm_fk foreign key (atd_nm) references tb_mbr(mbr_nm);
-- alter table tb_vac add constraint tb_atd_sn_fk foreign key (atd_sn) references tb_mbr(mbr_sn);

-- idx 및 사번용 시퀀스
create sequence seq_atd_idx start with 1;
create sequence seq_atd_sn start with 300;

-- 시퀀스 초기화용
drop sequence seq_atd_idx;
drop sequence seq_atd_sn;

-- 출퇴근 시간을 위한 날짜 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy/MM/dd HH24:MI:SS';

-- 매퍼 테스트용 데이터 삽입 (사번은 || CONCAT 사용)
insert into tb_atd values
(seq_atd_idx.nextval, '서정빈', '20220918'||seq_atd_sn.nextval, sysdate, sysdate, 'N', null, null, 'N', null, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_atd values
(seq_atd_idx.nextval, '배사랑', '20200418'||seq_atd_sn.nextval, sysdate, sysdate, 'Y', '2022/09/18~2022/10/21', '대구', 'N', null, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_atd values
(seq_atd_idx.nextval, '가즈아!!', '20200331'||seq_atd_sn.nextval, sysdate, sysdate, 'N', null, null, 'N', null, null, null, null, null, 'admin', sysdate, null, null);

-- 테이블 확인 및 초기화용
select * from tb_atd;
delete from tb_atd;

-- 데이터 복사
insert into tb_atd
select * from tb_atd
where idx > 0;

-- COMMIT 필수
commit;
