<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../include/header.jsp" %>

     <style>
		.uploadResult {
		  width:100%;
		  background-color: gray;
		}
		.uploadResult ul{
		  display:flex;
		  flex-flow: row;
		  justify-content: center;
		  align-items: center;
		}
		.uploadResult ul li {
		  list-style: none;
		  padding: 10px;
		  align-content: center;
		  text-align: center;
		}
		.uploadResult ul li img{
		  width: 100px;
		}
		.uploadResult ul li span {
		  color:white;
		}
		.bigPictureWrapper {
		  position: absolute;
		  display: none;
		  justify-content: center;
		  align-items: center;
		  top:0%;
		  width:100%;
		  height:100%;
		  background-color: gray; 
		  z-index: 100;
		  background:rgba(255,255,255,0.5);
		}
		.bigPicture {
		  position: relative;
		  display:flex;
		  justify-content: center;
		  align-items: center;
		}
		
		.bigPicture img {
		  width:600px;
		}        
      </style>


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
                           	
                           	
					
					<sec:authentication property="principal" var="pinfo"/>
						<sec:authorize access="isAuthenticated()">
							<c:if test="${pinfo.username eq board.writer}">
								<button data-oper="modify" class="btn btn-default">Modify</button>
							</c:if>
						</sec:authorize>
					
					
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
         

         
         
         <!-- 첨부파일 영역 -->               
         <div class="bigPictureWrapper">
         	<div class="bigPicture">
         	</div>
         </div>
         

         
         <div class="row">
         	<div class="col-lg-12">
         		<div class="panel panel-default">
         			<div class="panel-heading">Files</div>
         			<div class="panel-body">
         				<div class="uploadResult">
         					<ul>
         					</ul>
         				</div> 
         			</div>  <!-- end panel body -->
         		</div> <!-- end panel -->
         	</div>
         </div>
         
         
                        
         <!-- 댓글 -->
			<div class='row'>
			  <div class="col-lg-12">
			    <!-- /.panel -->
			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <i class="fa fa-comments fa-fw"></i> Reply
			        <sec:authorize access="isAuthenticated()">
			        <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
			        </sec:authorize>
			      </div>      
			
			      <!-- /.panel-heading -->
			      <div class="panel-body">        
			      
			        <ul class="chat"></ul>
			        <!-- ./ end ul -->
			      </div>
			      <!-- /.panel .chat-panel -->
			      <!-- 댓글 페이지부분 -->
				<div class="panel-footer">
					
				
				</div>

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
			replyService.getList({bno:bnoValue,page: page|| 1 }, function(replyCnt,list) {
				
				console.log("replyCnt : "+ replyCnt);
				console.log("list : " + list);
	
			//페이지 번호가 -1로 전달되면 마지막 페이지를 찾아서 다시 호출한다.
				if(page == -1) {
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				
				var str = "";
				
				//콜백함수의 매개변수, Ajax의 리턴값에 대한 처리
				// 값이 없으면 html 출력하지말고 종료
			       if(list == null || list.length == 0){     
			           replyUL.html("");		           
			           return;
				}
				
			       for (var i = 0, len = list.length || 0; i < len; i++) {
			    	   str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
			           str +=" <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>"; 
			           str +=" <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
			           str +="  <p>"+list[i].reply+"</p></div></li>";
			            }
			       
	                replyUL.html(str);
	                // 댓글 페이지 번호 출력
	                showReplyPage(replyCnt);
			});
		}	
	
	
	
	//댓글 페이지 처리
	
	//현재 페이지 번호
	var pageNum = 1;
	
	var replyPageFooter = $(".panel-footer");
	
	function showReplyPage(replyCnt){
	
		//마지막 페이지
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		
		// 시작 페이지
		var startNum = endNum -9;
		
		// 이전
		var prev = startNum != 1;
		
		// 다음
		var next = false;
		
		
		//마지막 페이지를 실제 계산한 값과 비교한다. 
		//10을 곱한 이유는 replyCnt값이 총 데이터 갯수이고
		//endNum은 페이지 번호로 페이지당 보여줄 갯수 (10)을 나눠준 값이기 때문임
		//실제 데이터 값이 더 작으면 실제 값을 10으로 나눠 페이지 번호로 만듬
	      if(endNum * 10 >= replyCnt){
	          endNum = Math.ceil(replyCnt/10.0);
	        }
		
		
	      if(endNum * 10 < replyCnt){
	          next = true;
	        }
		
		
		//html 작성
		var str = "<ul class='pagination pull-right'>";
		
        if(prev){
            str+= "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
          }
		
		//페이지 번호 html 처리
		 for(var i = startNum ; i <= endNum; i++){
			
			 var active = pageNum == i ? "active" : "";
			
	         str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
         }
		
		//next 조건 처리
	        if(next){
	            str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	          }
		
		str +="</ul></div>";

		console.log ("댓글 페이지 처리 확인 : " + str);
		
		replyPageFooter.html(str);	
	}
	
	
	// 댓글 페이지 번호 클릭 시 새로운 댓글을 가져오는 이벤트
	
	//replyPageFooter = $(".panel-footer")
	replyPageFooter.on("click","li a",function(e){
		
		e.preventDefault();
		console.log("page click");
		
		// this = li a
		var targetPageNum = $(this).attr("href");
		
		console.log("targetPageNum : " + targetPageNum);
		
		//pageNum을 클릭한 값으로 변경
		pageNum = targetPageNum;
		
		showList(pageNum);
	})
		
		
		
		
	//댓글작성버튼 이벤트 처리
	
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
	
	  
	  var replyer = null;
	  
	  <sec:authorize access ="isAuthenticated()">
	  
	  replyer = "<sec:authentication property='principal.username'/>";
	 
	  </sec:authorize> 
	
	    var csrfHeaderName ="${_csrf.headerName}"; 
	    var csrfTokenValue="${_csrf.token}";
	 
	 //댓글등록 버튼을 누르면
	$("#addReplyBtn").on("click", function(e){
		
		//modal의 input 값을 전부 비움
		modal.find("input").val("");
		//현재 로그인한 사용자의 이름으로 이름을 표시
		modal.find("input[name='replyer']").val(replyer);
		//ReplyDate의 상위요소중 가장 가까운"div" 요소를 숨김처리 즉, 날짜란을 지움
		modalInputReplyDate.closest("div").hide();
		//모달창 닫기버튼을 제외한 버튼 전부 숨김처리
		modal.find("button[id !='modalCloseBtn']").hide();
		//댓글 등록버튼 보이기처리
		modalRegisterBtn.show();
		//모달창 호출
        $(".modal").modal("show");      
    });
	
	
	 //ajaxSend() 모든 ajax 전송시 같이 전송 되도록 처리 여기서는 csrf 토큰값을 전송한다.
	 // beforeSend 를 일일이 적을 필요가 없어짐
	 $(document).ajaxSend(function(e,xhr,options){
		 xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
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
			
			//showList(1);
			//사용자가 새로운 댓글을 추가하면 showList(-1)을 호출하여 전체 댓글의 수를 파악하도록 한다. 
			// 그 후 다시 if 조건식에 의해 마지막 페이지를 호출해서 이동한다.
			showList(-1);
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
		
		var originalReplyer = modalInputReplyer.val();
		
		var reply = {
				rno:modal.data("rno"), 
				reply: modalInputReply.val(),
				replyer : originalReplyer};
		
		if(!replyer) {
			alert("로그인 후 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		console.log("OriginalReplyer : " + originalReplyer);
		
		if(replyer != originalReplyer) {
			
			alert("자신이 작성한 댓글만 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		
		replyService.update(reply,function(result){
			
			alert(result);
			modal.modal("hide");
		//수정 삭제 후 다시 보고 있는 페이지로 이동하도록 처리
			showList(pageNum);
		});
	});
		
	
	 //댓글 삭제
	 
	 modalRemoveBtn.on("click",function(e){
		
		 var rno = modal.data("rno"); 
		
		 console.log("RNO : " + rno);
		 console.log("REPLYER : " + replyer);
		 
		 
		 if(!replyer) {
			 alert("로그인 후 삭제가 가능합니다.");
			 modal.modal("hide");
			 return;
		 }
		 
		 var originalReplyer = modalInputReplyer.val();
		 
		 console.log("Original Replyer : " + originalReplyer);  // 댓글의 원래 작성자
		 
		 if(replyer != originalReplyer) {
			 
			 alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			 modal.modal("hide");
			 return;
		 }
		 
		 replyService.remove(rno, originalReplyer, function(result) {
			
			 alert(result);
			 modal.modal("hide");
			 showList(pageNum);
			 
		 });
		 
	 });
	 
	 
	 
	 
	 
	 //게시물의 첨부파일을 가져오는 부분이 자동으로 동작하게 즉시실행 함수로 만듬
	 (function(){
		 
	var bno = '<c:out value="${board.bno}"/>';
		 
	$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
		 
		 
		
		 console.log(arr);
		 
		 var str = "";
		 
		 $(arr).each(function(i,attach){
			
			 console.log("파일 타입 확인 : " + attach.fileType);
			 console.log("uploadPath 확인 : " + attach.uploadPath);
			 console.log("uuid 확인 : " + attach.uuid);
			 console.log("file name 확인 : " + attach.fileName);
			 //image
	         if(attach.fileType){
	        	 var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
	             console.log("FilePath확인 : " + fileCallPath);
		             str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
		             str += "<img src='/uploadSample/display?fileName="+fileCallPath+"'>";
		             str += "</div>";
		             str +"</li>";
	             
	           }else{  
	               str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
	               str += "<span> "+ attach.fileName+"</span><br/>";
	               str += "<img src='/resources/img/attach.png'></a>";
	               str += "</div>";
	               str +"</li>";
	           }
	         });
	         
	         $(".uploadResult ul").html(str);
	 });
	})();
	 
	 
	 
	 //첨부파일 클릭 시 이벤트 처리
	 
  $(".uploadResult").on("click","li", function(e){
      
	    console.log("view image");
	    
	    var liObj = $(this);
	    
	    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
	    
	    if(liObj.data("type")){
	      showImage(path.replace(new RegExp(/\\/g),"/"));
	    }else {
	      //download 
	      self.location ="/uploadSample/download?fileName="+path
	    }
  });
	 
	 
	 //원본 이미지 보여주기
	  function showImage(fileCallPath){
		    
	    alert(fileCallPath);
	    
	    $(".bigPictureWrapper").css("display","flex").show();
	    
	    $(".bigPicture")
	    .html("<img src='/uploadSample/display?fileName="+fileCallPath+"' >")
	    .animate({width:'100%', height: '100%'}, 1000);
		    
	  }
	 
	 
	 //원본 이미지 창 닫기
	  $(".bigPictureWrapper").on("click", function(e){
		    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		    setTimeout(function(){
		      $('.bigPictureWrapper').hide();
		    }, 1000);
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

