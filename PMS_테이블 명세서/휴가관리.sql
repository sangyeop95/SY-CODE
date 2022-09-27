--<�ް� ����>
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
-- �θ�Ű �� �������� �ʴ´ٴ� ���� �߻�
-- ORA-02291: ���Ἲ ��������(KUTSBANK.SYS_C008885)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�.
-- alter table tb_vac add constraint tb_vac_nm_fk foreign key (vac_nm) references tb_mbr(mbr_nm);
-- alter table tb_vac add constraint tb_vac_sn_fk foreign key (vac_sn) references tb_mbr(mbr_sn);


-- idx �� ����� ������
create sequence seq_vac_idx start with 1;
create sequence seq_vac_sn start with 300;

-- ������ �ʱ�ȭ��
drop sequence seq_vac_idx;
drop sequence seq_vac_sn;

-- ����� �ð��� ���� ��¥ ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy/MM/dd HH24:MI:SS';

-- ���� �׽�Ʈ�� ������ ���� (����� || CONCAT ���)
insert into tb_vac values
(seq_atd_idx.nextval, '������', '20220918'||seq_vac_sn.nextval, '20220920', '20220923', '����', 4, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, '����', '20220223'||seq_vac_sn.nextval, null, null, null, null, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_vac values
(seq_atd_idx.nextval, 'test', '20210912'||seq_vac_sn.nextval, null, null, null, null, null, null, null, null, 'admin', sysdate, null, null);

-- ���̺� Ȯ�� �� �ʱ�ȭ��
select * from tb_vac;
delete from tb_vac;

-- ������ ����
insert into tb_vac
select * from tb_vac
where idx > 0
;

-- COMMIT �ʼ�
commit;

select (TO_DATE(vac_end, 'yyyy/MM/dd') - TO_DATE(vac_str, 'yyyy/MM/dd')) from tb_vac;