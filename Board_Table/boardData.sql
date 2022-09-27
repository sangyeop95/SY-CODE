create sequence seq_board;

create table tbl_board (
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(1000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate);
    
alter table tbl_board add constraint pk_board primary key (bno);

insert into tbl_board (bno, title, content, writer) values (seq_board.nextval, '力格5', '郴侩5', 'user05');

select * from hr.tbl_board order by bno desc;
select /*+ index_desc(tbl_board_pk_board) */ * from tbl_board where bno > 0;

-- 其捞隆 贸府
select rn, bno, title, content from (
select /*+ index_desc(tbl_board_pk_board) */ rownum rn, bno, title, content from tbl_board where rownum <= 20
) where rn > 10;

commit;

delete from tbl_board where bno=6;

insert into tbl_board (bno, title, content, writer)
(select seq_board.nextval, title, content, writer from tbl_board);

select count(*) from tbl_board;