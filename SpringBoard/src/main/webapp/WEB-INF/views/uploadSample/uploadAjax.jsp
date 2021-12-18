<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>upload with Ajax</h1>

<div class="uploadDiv">
	<input type="file" name="uploadFile" multiple>
</div>

<button id="uploadBtn">Upload</button>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("#uploadBtn").on("click",function(e){
			
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			console.log(files);
			
			//add File Data to formData
			for(var i =0; i< files.length; i++) {
				
				if(!checkExtension(files[i].name, files[i].size){
					return false;
				}
				
				//formData 타입의 객체에 각 파일 데이터를 추가
				formData.append("uploadFile",files[i]);
			}
			
			
			$.ajax({
				
				url : "/uploadSample/uploadAjaxAction",
				processData : false,
				contentType : false,
				data : formData,
				type : "POST",
				success : function(result) {
					alert("Uploaded");
				}
			});
		
		});
		
		
		
		//파일 확장자 제한
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;  //5mb
		
		function checkExtension(fileName,fileSize) {
			
			if(fileSize >= maxSize) {
				
				alert("파일 사이즈 초과");
				return false;
			}
			
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true
		}
		
		
		

		
		
		
		
		
		
		
		
		
		

	});
	
</script>
</body>
</html>