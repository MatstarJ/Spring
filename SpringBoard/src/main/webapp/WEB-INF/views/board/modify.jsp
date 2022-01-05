<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri ="http://www.springframework.org/security/tags" prefix="sec" %>
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
                    <h1 class="page-header">Board Modify Page</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Board Modify
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
                           	<button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
                           	<button type="submit" data-oper="list" class="btn btn-info">List</button>
                           	 
								
							<!-- get(조회)페이지로부터 넘겨 받은 값 -->	
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

		<!--  첨부파일 영역 -->
		
		<div class="bigPictureWrapper">
			<div class="bigPicture">
			</div>
		</div>
		
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">Files</div>
					<div class="panel-body">
						<div class="form-group uploadDiv">
							<input type="file" name="uploadFile" multiple>
						</div>
						<div class="uploadResult">
							<ul>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

        </div>
        <!-- /#page-wrapper -->



		


		

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
				
			//리스트로 이동시 페이지 값만 복사해서 넣고 나머지 삭제 (안그러면 모달창 뜸)	
				formObj.attr("action","/board/list").attr("method","get");
			
				var pageNumTag = $("input[name='pageNum']").clone();	
				var amountTag = $("input[name='pageNum']").clone();	
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name'type']").clone();
			
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
				
			} else if(operation == "modify") {
					
				console.log("submit clicked");
				
				var str = "";
				
				$(".uploadResult ul li").each(function(i,obj){
				
				var jobj = $(obj);
				
				console.dir(jobj);
				
				str += "<input type ='hidden' name = 'attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type ='hidden' name = 'attachList["+i+"].uuid' value = '"+jobj.data("uuid")+"'>";
				str += "<input type ='hidden' name = 'attachList["+i+"].uploadPath' value = '"+jobj.data("path")+"'>";
				str += "<input type ='hidden' name = 'attachList["+i+"].fileType' value ='"+jobj.data("type")+"'>";
				
				});
				formObj.append(str).submit();
			}
			formObj.submit();		
		});
		
		
		
		//첨부파일 불러오기
		(function(){
			
			var bno = '<c:out value="${board.bno}"/>';
			
			$.getJSON("/board/getAttachList",{bno:bno},function(arr){
				
				console.log("modify getJSON : "+ arr);
				
				var str ="";
				
				$(arr).each(function(i, attach){
					
					//image type
					if(attach.fileType) {
						
						var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
						
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
						str += "<div>";
						str += "<span>"+attach.fileName+"</span>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>";
						str += "<i class='fa fa-times'></i>"
						str += "</button><br>";
						str += "<img src='/uploadSample/display?fileName="+fileCallPath+"'>";
						str += "</div>";
						str += "</li>";
					} else {	
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
						str += "<div>";
						str += "<span>"+attach.fileName+"</span><br>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-crirle'>";
						str += "<i class='fa fa-times'></i>";
						str += "</button><br>";
						str += "<img src='/resources/img/attach.png'></a>";
						str += "</div>";
						str += "</li>";
					}
				});
					$(".uploadResult ul").html(str);		
			});
		})();
		
		
		//첨부파일의 x버튼 이벤트 처리
		$(".uploadResult").on("click","button",function(e){
			
			console.log("delete file");
			
			if(confirm("Remove this file? ")) {
				
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
		})
		
		
		///첨부파일 유효성 검사
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		
		var maxSize = 5242880;
		
		function checkExtension(fileName, fileSize) {
			
			if(fileSize >= maxSize) {
				
				alert("파일 사이즈 초과");
				return false;	
			}
			
			if(regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			
			return true;
		}
		
		//첨부파일 변화를 감지해서 자동으로 업로드 처리 시킨다.
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$("input[type='file']").change(function(e){
			
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			for(var i =0; i < files.length; i++) {
				
				if(!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile",files[i]);
			}
			
			$.ajax({
				url : "/uploadSample/uploadAjaxAction",
				//processData가 false로 되어 있으면 키와 값의 쌍으로 설정하지 않는다.
				processData : false,
				contentType : false,
				beforeSend : function(xhr) { xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);},
				data : formData,
				type : "POST",
				dataType : "json",
				success : function(result) {
					console.log(result);
					showUploadResult(result);
				}
			});	
		});
	
		
		
		//업로드 결과를 처리하는 함수
		function showUploadResult(uploadResultArr) {
			
			if(!uploadResultArr || uploadResultArr.length == 0){ return;}
			
			var uploadUL = $(".uploadResult ul");
			
			var str = "";
			
			$(uploadResultArr).each(function(i,obj){
				
				if(obj.image) {
					
					var fileCallPath = encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
					
					//str += "<li><div>"
					str += "<li data-path='"+obj.uploadPath+"'";
					str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>"
					str += "<div>";
					str += "<span> "+ obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' "
					str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/uploadSample/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str += "</li>";
					
				} else {
					
					var fileCallPath = encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
				    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					
					
					//str += "<li><div>";
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' >"
					str += "<div>";
					str += "<span> "+ obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str += "</li>";
					
				}
				
				uploadUL.append(str);
				
			});
		}

		
	});



</script>

<%@ include file="../include/footer.jsp" %>
