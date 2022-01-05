<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../include/header.jsp" %>

	<style>
		.uploadResult {
			width: 100%;
			background-color: gray;
		}
		
		.uploadResult ul {
			display: flex;
			flex-flow: row;
			justify-content: center;
			align-items: center;
		}
		
		.uploadResult ul li {
			list-style: none;
			padding: 10px;
		}
		
		.uploadResult ul li img {
			width: 100px;
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
		}
		
		.bigPicture {
		  position: relative;
		  display:flex;
		  justify-content: center;
		  align-items: center;
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
                           <form role="form" action="/board/register" method="post">
                           	
                           	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                           	
                           	
                           	<div class="form-group">
                           		<label>Title</label>
                           		<input class="form-control" name="title">                           	
                           	</div>
                           	
                           	

                      		<div class="form-group">
                      			<label>Text area</label>
                      			<textarea class="form-control" rows="3" name="content"></textarea>
                      		</div>
                           		
                           		
                       		<div class="form-group">
                       			<label>Writer</label>
                       			<input class="form-control" name="writer" value="<sec:authentication property='principal.username'/>" readonly="readonly">
                       		</div>                           	
                           	
                           	
                           	<button type="submit" class="btn btn-default">Submit</button>
                           	<button type="reset" class="btn btn-default">Reset</button>
                           	 
                           </form>
                           
                           

                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->


	
		<!-- 파일 첨부  -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">File Attach</div>
					<div class="panel-body">
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
        <!-- /#page-wrapper -->
        
        
	




<script>
	$(document).ready(function(e){

		
		var formObj = $("form[role='form']");
		
	//첨부파일 처리, 첨부파일에 별도의 버튼을 두지 않고 submit button을 클릭했을 때 처리하도록 한다.		
		$("button[type='submit']").on("click",function(e){
			e.preventDefault();
			console.log("submit clicked");
			
			var str = "";
			
			$(".uploadResult ul li").each(function(i,obj){
				
				var jobj = $(obj);
				
				console.dir(jobj);
				
			      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
				
			});
			
			console.log("첨부파일 폼 확인" + str);
			formObj.append(str).submit();
			
		});
		
	
	//첨부파일 유효성 검사
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;
	
	function checkExtension(fileName, fileSize){
		
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
			beforeSend : function(xhr){ xhr.setRequestHeader(csrfHeaderName,csrfTokenValue); },
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
	
	//첨부파일 삭제
	$(".uploadResult").on("click","button",function(e){
		
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			
			url : "/uploadSample/deleteFile",
			data : {fileName: targetFile, type:type},
			beforeSend : function(xhr) { xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); },
			dataType : "text",
			type : "POST",
			success : function(result) {
				alert(result);
				targetLi.remove();
			}
			
		});
	});
	
	
	
	
		
	});
</script>

<%@ include file="../include/footer.jsp" %>
