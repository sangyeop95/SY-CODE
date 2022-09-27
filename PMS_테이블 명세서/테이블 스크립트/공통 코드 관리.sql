-- ���̺� ����
create table tb_commoncode (
    total_cd    varchar2(6)     not null,
    main_cd     varchar2(3)     not null,
    sub_cd      varchar2(3)     not null,
    code_nm     varchar2(50)    not null,
    code_val    varchar2(255),
    sort        number(11)      not null,
    use_yn      char(1)         not null,
    edit_yn     char(1)         not null,
    spare1      varchar2(255),
    spare2      varchar2(255),
    spare3      varchar2(255),
    spare4      varchar2(255),
    rgtr_id     varchar2(64)    not null,
    rgtr_dt     date            not null,
    mdfr_id     varchar2(64)    not null,
    mdfr_dt     date            not null
);

-- pk
alter table tb_commoncode
add constraint tb_commoncode_pk primary key (total_cd);

-- ���� ������
insert into tb_commoncode
values ('KIT001', 'KIT', '001', 'TEST', null, 1, 'Y', 'Y', null, null, null, null, '�׽�Ʈ', sysdate, '�׽�Ʈ', sysdate);

insert into tb_commoncode
values ('KIT002', 'KIT', '002', 'TEST1', null, 2, 'N', 'N', null, null, null, null, '�׽�Ʈ1', sysdate, '�׽�Ʈ1', sysdate);

select * from tb_commoncode;
delete from tb_commoncode;

-- Ʈ���� ���� (�̽� ���� ����)
--create or replace trigger total_cd_insert
--after insert on tb_commoncode
--for each row
--declare
--begin
--    update tb_commoncode set total_cd = :new.main_cd
--    where sort = :new.sort;
--end;
--/

-- drop trigger total_cd_insert;