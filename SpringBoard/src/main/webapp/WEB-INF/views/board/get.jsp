<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                        
                        
                        <!-- 댓글 -->
                        <div class ="row">
                        	<div class="col-lg-12">
                        		<div class="panel panel-default">
                        			<div class ="panel-heading">
                        				<i class="fa fa-comments fa-fw"></i> Reply
                        			<button id ="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
                        			</div>
                        				<div class="panel-body">
                        					<ul class="chat">
	                        					<!-- <li class="left clearfix" data-rno="12">
	                        						<div>
	                        							<div class="header">
	                        								<strong class="primary-font">user00</strong>
	                        								<small class="pull-right text-muted">2020-10-10</small>
	                        							</div>
	                        							<p>Good job!</p>
	                        						</div>
	                        					</li> -->
                        					</ul>
                        				</div>
                        		</div>
                        	</div>
                        </div>
                        
             
                        
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


<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		//댓글 목록 불러옴
		
		var bnoValue = "<c:out value='${board.bno}'/>";
		var replyUL = $(".chat");
		
		//기본 페이지값을 1로 aJax함수 호출  
		showList(1);
		
		//Ajax함수
		function showList(page) {
			
			//매객밧으로 bno, page, callback함수를 준다.
			// 페이지 파라미터가 없을 경우 1로 처리
			replyService.getList({bno:bnoValue, page:page|| 1}, function(list){
				
				var str = "";
				
				//콜백함수의 매개변수, Ajax의 리턴값에 대한 처리
				// 값이 없으면 html 출력하지말고 종료
				if(list == null || list.length == 0) {
					replyUL.html("");
					return;
				}
				
			       for (var i = 0, len = list.length||0; i<len; i++) {
			    	   str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
			           str +=" <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>"; 
			           str +=" <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
			           str +="  <p>"+list[i].reply+"</p></div></li>";
			            }
				
				replyUL.html(str);
			});
		}	
		
		

		
		
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

<!-- AjaxTest -->
<!-- <script type="text/javascript">
	
	console.log("=================");
	console.log("JS TEST");
	
	var bnoValue = "<c:out value='${board.bno}'/>";
	
	//for replyService add test (등록)
	replyService.add(
	
		{reply:"JS Test", replyer:"tester", bno:bnoValue}
		,
		function(result) {
			alert("RESULT : " + result);
		}
	
	);

	
	//for getList test (목록)
	
	replyService.getList({bno:bnoValue, page:1}, function(list){
		
		for(var i =0, len = list.length || 0; i<len; i++) {
			console.log(list[i]);
		}
		
	});
	
	
	
	// for delete test(삭제)
	
	replyService.remove(23, function(count){
		
		console.log(count);
		
		if(count === "success") {
			alert("REMOVED");
		}
	}, 
		function(err) {
			alert("ERROR");
		}
	);
	
	
	//for update (수정)
	replyService.update({
		rno:22,
		bno:bnoValue,
		reply:"Modifyed Reply..."
	}, 
	function(result) {
		alert("수정 완료");
	
	});
	
	
	//for get(조회)
	replyService.get(10,function(data){
		console.log(data);
	});
	
</script> -->



</html>