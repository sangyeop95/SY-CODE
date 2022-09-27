--������
create sequence seq_mbr_idx;
create sequence seq_mbr_sn start with 100;

-- ������ �ʱ�ȭ
drop sequence seq_mbr_idx;
drop sequence seq_mbr_sn;

--���̺�
create table tb_mbr (
    idx number not null,
    mbr_sn varchar2(20) not null,
    mbr_nm varchar2(50) not null,
    mbr_tel varchar2(200), 
    mbr_phone varchar2(200) not null,
    mbr_em varchar2(200),
    mbr_addr_bx varchar2(200) not null,
    mbr_addr_dtl varchar2(100),
    mbr_addr_post varchar2(10) not null,
    mbr_dep_cd varchar2(6) not null,
    mbr_hired_d date,
    mbr_id varchar2(50) not null,
    mbr_pw varchar2(20) not null,
    mbr_cls_cd varchar2(6),
    spare1 varchar2(255),
    spare2 varchar2(255),
    spare3 varchar2(255),
    spare4 varchar2(255),
    rgtr_id varchar2(50),
    rgtr_dt date,
    mdfr_id varchar2(50),
    mdfr_dt date
    );

--���̺� Į���Ӽ�����
alter table tb_mbr modify mbr_pw varchar2(50);    
drop table tb_mbr;

--���̺� ��������
alter table tb_mbr add constraint tb_mbr_pk primary key (idx, mbr_nm);
alter table tb_mbr add constraint tb_mbr_sn_uk unique(mbr_sn);
--alter table tb_mbr add constraint tb_mbr_sn_fk foreign key (mbr_sn) references employee (eno); --�ܷ�Ű

--�����ͻ���  
insert into tb_mbr 
values (seq_mbr_idx.nextval, '20180303'||seq_mbr_sn.nextval, '����', '070-8186-2111', ' 010-0000-0000', 'test@naver.com',
        '�뱸 ������ �ϱ� �˴ܵ�', '�˴ܾ���Ʈ', '22222', 'GED11', '2020/09/07', 'test2', '1234', 'GAA011',
        null, null, null, null, 'administrator', '2020/09/05', null, null
        );
        
insert into tb_mbr 
values (seq_mbr_idx.nextval, '20180304'||seq_mbr_sn.nextval, '��', '070-8186-2111', ' 010-0000-0000', 'test@naver.com',
        '����', '�ѹݵ�', '22222', 'GED11', '2020/09/07', 'test2', '1234', 'GAA011',
        null, null, null, null, 'administrator', '2020/09/05', null, null
        ); 
        
insert into tb_mbr 
values (seq_mbr_idx.nextval, '20170304'||seq_mbr_sn.nextval, '�׽�Ʈ��', '010-8133-1422', ' 010-0000-0551', 'test@naver.com',
        'ȭ��', '�����', '22222', 'GED11', '2020/09/07', 'test2', '1234', 'GAA011',
        null, null, null, null, 'administrator', '2020/09/05', null, null
        );           

--��������ȸ �� ����
select * from tb_mbr order by mbr_sn desc;
insert into tb_mbr
select * from tb_mbr
where idx > 0;

delete from tb_mbr;

commit;

