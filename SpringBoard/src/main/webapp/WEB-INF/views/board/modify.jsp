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
                          
                         <form role="form" action="/board/modify" method="post">
                         <!--  입력 폼 페이지 -->
      	
                           	<div class="form-group">
                           		<label>Bno</label>
                           		<input class="form-control" name="bno" value="${board.bno}" readonly>                           	
                           	</div>
                           	
                           	<div class="form-group">
                           		<label>Title</label>
                           		<input class="form-control" name="title" value="${board.title}" >                           	
                           	</div>
                           	
                           	

                      		<div class="form-group">
                      			<label>Text area</label>
                      			<textarea class="form-control" rows="3" name="content" >${board.content}</textarea>
                      		</div>
                           		
                           		
                       		<div class="form-group">
                       			<label>Writer</label>
                       			<input class="form-control" name="writer" value="${board.writer}">
                       		</div>           
                       		
                       		<div class="form-group">
                       			<label>Update Date</label>
                       			<input class="form-control" name="updateDate" value="<fmt:formatDate pattern='yyyy/MM/dd' value='${board.updateDate}'/>" readonly>
                       		</div>                	
                           	
                           	
                           	<button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
                           	<button type="submit" data-oper="modify" class="btn btn-danger">Remove</button>
                           	<button type="submit" data-oper="list" class="btn btn-info">List</button>
                           	 

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
		
		var formObj = $("form");
		
		$("button").on("click",function(e){
			
			e.preventDefault();
			
			//this(button)의 data-oper속성
			var operation = $(this).data("oper");
			
			if(operation === "remove") {	
				formObj.attr("action","/board/remove");
			}else if(operation === "list") {
				//location.href ="/board/list";
				
			//리스트로 이동시 폼안의 내용을 전부 삭제처리 (안그러면 모달창 뜸)	
				formObj.attr("action","/board/list").attr("method","get");
				formObj.empty();
			}	
			formObj.submit();	
		});
		
		
		
	});



</script>


</html>