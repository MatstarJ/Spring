<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../include/header.jsp" %>
<!DOCTYPE html>
<html lang="en">

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Register</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Board Register
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                           
                         <!--  입력 폼 페이지 -->
      	
                           	<div class="form-group">
                           		<label>Bno</label>
                           		<input class="form-control" name="bno" value="${board.bno}" readonly>                           	
                           	</div>
                           	
                           	<div class="form-group">
                           		<label>Title</label>
                           		<input class="form-control" name="title" value="${board.title}" readonly>                           	
                           	</div>
                           	
                           	

                      		<div class="form-group">
                      			<label>Text area</label>
                      			<textarea class="form-control" rows="3" name="content" readonly>${board.content}</textarea>
                      		</div>
                           		
                           		
                       		<div class="form-group">
                       			<label>Writer</label>
                       			<input class="form-control" name="writer" value="${board.writer}" readonly>
                       		</div>                           	
                           	
                           	
                           	<button data-oper="modify" class="btn btn-default" >Modify</button>
                           	<button data-oper="list" class="btn btn-info" >List</button>
                           	 
                           	 
                           	 
							<form id="operForm" action="/board/modify" method="get">
								<input type="hidden" id="bno" name="bno" value="${board.bno}">
								<!-- 페이지 유지를 위한 값, list로부터 넘겨 받아 수정 페이지로 넘긴다. -->
								<input type="hidden" name="pageNum" value="${cri.pageNum}">
								<input type="hidden" name="amount" value="${cri.amount}">
								<!-- 검색어 유지 -->
								<input type="hidden" name="keyword" value="${cri.keyword}">
								<input type="hidden" name="type" value="${cri.type}">
								
							</form>


                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->



        </div>
        <!-- /#page-wrapper -->

<%@ include file="../include/footer.jsp" %>
</body>


<script type="text/javascript">

	$(document).ready(function(){

		
		
	//버튼 이벤트 처리
		var operForm = $("#operForm");
		
	//수정 버튼 누르면 폼 속성을 바꾼 후 전송
		$("button[data-oper='modify']").on("click",function(e){
			
			operForm.attr("action","/board/modify").submit();
		});
		
	// 목록 버튼을 누르면 폼에 저장된 글 번호를 지우고 목록으로 이동	
		$("button[data-oper='list']").on("click",function(e){
			
			operForm.find("#bno").remove();
			operForm.attr("action","/board/list");
			operForm.submit();
			
		});
		
		
		
	});

</script>




</html>