-- <��� ����>
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
-- �θ�Ű �� �������� �ʴ´ٴ� ���� �߻�
-- ORA-02291: ���Ἲ ��������(KUTSBANK.SYS_C008885)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�.
-- alter table tb_vac add constraint tb_atd_nm_fk foreign key (atd_nm) references tb_mbr(mbr_nm);
-- alter table tb_vac add constraint tb_atd_sn_fk foreign key (atd_sn) references tb_mbr(mbr_sn);

-- idx �� ����� ������
create sequence seq_atd_idx start with 1;
create sequence seq_atd_sn start with 300;

-- ������ �ʱ�ȭ��
drop sequence seq_atd_idx;
drop sequence seq_atd_sn;

-- ����� �ð��� ���� ��¥ ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy/MM/dd HH24:MI:SS';

-- ���� �׽�Ʈ�� ������ ���� (����� || CONCAT ���)
insert into tb_atd values
(seq_atd_idx.nextval, '������', '20220918'||seq_atd_sn.nextval, sysdate, sysdate, 'N', null, null, 'N', null, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_atd values
(seq_atd_idx.nextval, '����', '20200418'||seq_atd_sn.nextval, sysdate, sysdate, 'Y', '2022/09/18~2022/10/21', '�뱸', 'N', null, null, null, null, null, 'admin', sysdate, null, null);

insert into tb_atd values
(seq_atd_idx.nextval, '�����!!', '20200331'||seq_atd_sn.nextval, sysdate, sysdate, 'N', null, null, 'N', null, null, null, null, null, 'admin', sysdate, null, null);

-- ���̺� Ȯ�� �� �ʱ�ȭ��
select * from tb_atd;
delete from tb_atd;

-- ������ ����
insert into tb_atd
select * from tb_atd
where idx > 0;

-- COMMIT �ʼ�
commit;
