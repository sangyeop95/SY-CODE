--<휴가 관리>
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

-- fk
-- 부모키 값 존재하지 않는다는 에러 발생
-- ORA-02291: 무결성 제약조건(KUTSBANK.SYS_C008885)이 위배되었습니다- 부모 키가 없습니다.
-- alter table tb_vac add constraint tb_vac_nm_fk foreign key (vac_nm) references tb_mbr(mbr_nm);
-- alter table tb_vac add constraint tb_vac_sn_fk foreign key (vac_sn) references tb_mbr(mbr_sn);


-- idx 및 사번용 시퀀스
create sequence seq_vac_idx start with 1;
create sequence seq_vac_sn start with 300;

-- 시퀀스 초기화용
drop sequence seq_vac_idx;
drop sequence seq_vac_sn;

-- 출퇴근 시간을 위한 날짜 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy/MM/dd HH24:MI:SS';

-- 매퍼 테스트용 데이터 삽입 (사번은 || CONCAT 사용)
insert into tb_vac values
(seq_atd_idx.nextval, '서정빈', '20220918'||seq_vac_sn.nextval, '20220920', '20220923', '연차', 4, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, '정빈서', '20220223'||seq_vac_sn.nextval, null, null, null, null, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test', '20210912'||seq_vac_sn.nextval, null, null, null, null, null, null, null, null, 'admin', sysdate, null, null);

-- 테이블 확인 및 초기화용
select * from tb_vac;
delete from tb_vac;

-- 데이터 복사
insert into tb_vac
select * from tb_vac
where idx > 0
;

-- COMMIT 필수
commit;

select (TO_DATE(vac_end, 'yyyy/MM/dd') - TO_DATE(vac_str, 'yyyy/MM/dd')) from tb_vac;