<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %> <!-- 시간 -->
    
<%@include file = "../includes/header.jsp" %>

<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">게시판 수정</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">수정</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

      <form role="form" action="/board/modify" method="post">
      		<input type='hidden' name='pageNum' value='${cri.pageNum}'>
			<input type='hidden' name='amount' value='${cri.amount}'>
        <div class="form-group">
            <label>bno</label> <input class="form-control" name='bno' value = '${board.bno}' readonly="readonly">
        </div>
        
      	<div class="form-group">
      		<label>제 목</label>	<input class="form-control" name='title' value = '${board.title}'>
    	</div>

      	<div class="form-group">
      		<label>내 용</label>	<textarea class="form-control" rows="3" name='content'>${board.content}</textarea>
	  	</div>

		<div class="form-group">
            <label>작성자</label> <input class="form-control" name='writer' value = '${board.writer}'>
        </div>
        
        <div class="form-group">
            <label>등록일</label> <input class="form-control" name='regdate' value = '<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' readonly>
        </div>
        
        <div class="form-group">
            <label>수정일</label> <input class="form-control" name='updateDate' value = '<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>' readonly>
        </div>
        
          <button type = "submit" data-oper = "modify" class="btn btn-default">수정</button>
          <button type = "submit" data-oper = "remove" class="btn btn-danger">삭제</button>
          <button type = "submit" data-oper = "list" class="btn btn-info">목록</button>
      </form>

      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->

		<script type="text/javascript">
			$(document).ready(function(){
				var formObj = $("form");
				
				$("button").on("click", function(e){
					e.preventDefault();
					
					var operation = $(this).data("oper");
					
					console.log(operation);
					
					if(operation === "remove"){
						formObj.attr("action", "/board/remove");
					}else if(operation === "list"){
						formObj.attr("action", "/board/list").attr("method", "get");
					}
						formObj.submit();
				});
			});
		</script>

<%@include file = "../includes/footer.jsp"%>