<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 첨부파일 아이콘 처리 -->

<style>

.uploadResult {
	width : 100%;
	background-color : gray;
}

.uploadResult ul {
	display : flex;
	flex-flow : row;
	justify-content : center;
	align-items : center;
}


.uploadResult ul li {
	list-style : none;
	padding : 10px;	
}

.uploadResult ul li img {
	width : 20px;
}

</style>

</head>
<body>

<h1>upload with Ajax</h1>

<div class="uploadDiv">
	<input type="file" name="uploadFile" multiple>
</div>


<div class="uploadResult">
	<ul>
	
	</ul>
</div>





<button id="uploadBtn">Upload</button>

<script type="text/javascript">
	$(document).ready(function(){
		
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
		
		
		
	//업로드 실행 후에 초기화를 위해 실행 전에 아무 것도 없는 input 객체를 복사해놓는다. 	
	//input type = file은 readonly라 안쪽의 내용을 수정할 수 없어 해당 방법을 사용해야 한다.
	
	var cloneObj = $(".uploadDiv").clone();
	
	
	//업로드 실행 Ajax
		$("#uploadBtn").on("click",function(e){
			
			//파일 객체 생성
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			console.log("files : " + files);

			
			//add File Data to formData
			for(var i =0; i< files.length; i++) {
				
				if(!checkExtension(files[i].name, files[i].size) ){
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
				dataType : "json",
				success : function(result) {
					//alert("Uploaded");
					console.log(result);
					
					//파일 이름을 보여주는 함수를 실행시킨다.
					showUploadFile(result);
					
					//업로드 실행 후 초기화시킨다.
					$(".uploadDiv").html(cloneObj.html());
					
					
				}
			});	
		});
	
	
	
	
	
		
		//업로드한 파일의 이름을 출력하고 이미지를 표시하는 함수
		
		var uploadResult= $(".uploadResult ul");
		
		
		function showUploadFile(uploadResultArr){
			
			var str = "";
			
		$(uploadResultArr).each(function(i,obj) {
			
			if(!obj.image) {
				
				//첨부파일이 이미지가 아니라면 첨부파일 아이콘을 표시한다.
				str += "<li><img src='/resources/img/attach.png'>" + obj.fileName + "</li>";
				
			} else {
				
				//	str += "<li>" + obj.fileName + "</li>";
				
				//encodeURIComponent() : URI호출에 적합한 문자열로 인코딩 처리를 한다.
				console.log("obj.uploadPath : " + obj.uploadPath);
				console.log("fileName : " + obj.fileName);
				console.log("fileCallPath : " + obj.uuid);
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);

				
				str += "<li><img src='/uploadSample/display?fileName="+fileCallPath+"'></li>";
			}
			
		});
		
		uploadResult.append(str);
	}

		
		
	
		
	
	
	

		
		
		
		
		
		
		
		
		
		

	});
	
</script>
</body>
</html>