<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../include/header.jsp" %>

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
                           	
                           	
					<button data-oper="modify" class="btn btn-default">Modify</button>
					<button data-oper="list" class="btn btn-info">List</button>
                           	 
                           	 
                           	 
					<!-- 게시물 수정,삭제를 위해 게시물 번호를 저장하는 히든폼을 만듬-->
					<form id="operForm" action="/board/modify" method="get">
						<input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}' />"> 
						<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
						<input type="hidden" name="amount" value="<c:out value= '${cri.amount}'/>"> 
						<input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
						<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
					</form>


                        </div>
                        <!-- /.panel-body -->
                        
                        
                        <!-- 댓글 -->
			<div class='row'>
			  <div class="col-lg-12">
			    <!-- /.panel -->
			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <i class="fa fa-comments fa-fw"></i> Reply
			        <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
			      </div>      
			
			      <!-- /.panel-heading -->
			      <div class="panel-body">        
			      
			        <ul class="chat"></ul>
			        <!-- ./ end ul -->
			      </div>
			      <!-- /.panel .chat-panel -->
				<div class="panel-footer"></div>

			</div>
	       </div>
			  <!-- ./ end row -->
			</div>
                        
                
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

        </div>
        <!-- /#page-wrapper -->



     <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
                </div>
                <div class="modal-body">
                
				    <div class="form-group">
				      <label>Reply</label> 
				      <input class="form-control" name='reply' value=''>
				    </div>      
				    <div class="form-group">
				      <label>Replyer</label> 
				      <input class="form-control" name='replyer' value=''>
				    </div>
				    <div class="form-group">
				      <label>Reply Date</label> 
				      <input class="form-control" name='replyDate' value="">
				    </div>
                       
                       </div>
                       <div class="modal-footer">
	                       	<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
							<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
							<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
							<button id='modalCloseBtn' type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                       </div>
              </div>
                   <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->









<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		//댓글 목록 불러옴
		
		var bnoValue = "<c:out value='${board.bno}'/>";
		  
		var replyUL = $(".chat");
		
		console.log("bnovlaue" + bnoValue);
		//기본 페이지값을 1로 aJax 호출  
		
		showList(1);
		
		//Ajax
		function showList(page) {
			
			//매개값으로 bno, page, callback함수를 준다.
			// 페이지 파라미터가 없을 경우 1로 처리
			replyService.getList({bno:bnoValue,page: page|| 1 }, function(list) {
				
				console.log("list : " + list);
				var str = "";
				
				//콜백함수의 매개변수, Ajax의 리턴값에 대한 처리
				// 값이 없으면 html 출력하지말고 종료
			       if(list == null || list.length == 0){     
			           replyUL.html("");		           
			           return;
				}
				
	                for (var i = 0, len = list.length || 0; i < len; i++) {
	                    str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
	                    str += "<div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>";
	                    str += "<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
	                    str += "<p>" + list[i].reply + "</p></div></li>";
	                }
	                replyUL.html(str);
			});
		}	
		
		
	//댓글작성버튼처리

		
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


	//댓글 모달창이벤트 처리
	
	
	//각 요소와 버튼을 변수로 저장
	  var modal = $(".modal");
	  var modalInputReply = modal.find("input[name='reply']");
	  var modalInputReplyer = modal.find("input[name='replyer']");
	  var modalInputReplyDate = modal.find("input[name='replyDate']");
	  
	  var modalModBtn = $("#modalModBtn");
	  var modalRemoveBtn = $("#modalRemoveBtn");
	  var modalRegisterBtn = $("#modalRegisterBtn");
	
	//댓글등록 버튼을 누르면
	$("#addReplyBtn").on("click", function(e){
		
		//modal의 input 값을 전부 비움
		modal.find("input").val("");
		//ReplyDate의 상위요소중 가장 가까운"div" 요소를 숨김처리 즉, 날짜란을 지움
		modalInputReplyDate.closest("div").hide();
		//모달창 닫기버튼을 제외한 버튼 전부 숨김처리
		modal.find("button[id !='modalCloseBtn']").hide();
		//댓글 등록버튼 보이기처리
		modalRegisterBtn.show();
		//모달창 호출
        $(".modal").modal("show");      
    });
	
	
	//댓글 모달창의 글 등록 버튼 이벤트처리
	
	
	//댓글 등록 버튼 누르면
	modalRegisterBtn.on("click",function(e){
		
		//변수의 값을 객체로 저장
        var reply = {
              reply: modalInputReply.val(),
              replyer:modalInputReplyer.val(),
              bno:bnoValue
            };
		
		//Ajax호출
		replyService.add(reply, function(result){
			
			alert(result);
			
            modal.find("input").val("");
            modal.modal("hide");
			
			showList(1);
		});
		
	});
	
	
	
	//특정 댓글을 눌렀을 때의 이벤트 처리
	//이미 존재하는 요소인 .chat에 이벤트를 걸고 실제 이벤트 대상은 각각의 li태그가 되도록 처리
	$(".chat").on("click","li",function(e){
		
		var rno = $(this).data("rno");
		
		console.log("댓글 클릭 rno :" + rno);
		
	//특정 댓글을 눌렀을 때 모달창을 띄우도록 이벤트 처리
		replyService.get(rno, function(reply){
			
		 modalInputReply.val(reply.reply);
		 modalInputReplyer.val(reply.replyer);
		 modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
		 modal.data("rno",reply.rno);
		 
		 modal.find("button[id != 'modalCloseBtn']").hide();
		 modalModBtn.show();
		 modalRemoveBtn.show();
		 
		 modal.modal("show");
		})
	});
	
	
	//댓글의 수정 삭제 이벤트 처리
	
	modalModBtn.on("click",function(e){
		
		var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
		
		replyService.update(reply,function(result){
			
			alert(result);
			modal.modal("hide");
			showList(1);
		});
	});
		
	
	 //댓글 삭제
	 
	 modalRemoveBtn.on("click",function(e){
		
		 var rno = modal.data("rno"); 
		 
		 replyService. remove(rno, function(result) {
			
			 alert(result);
			 modal.modal("hide");
			 showList(pageNum);
			 
		 });
		 
	 });
	 
	
	
	});
	
</script>


<%@ include file="../include/footer.jsp" %>

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

