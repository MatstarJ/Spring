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
                    <h1 class="page-header">Board List</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Board List Page
                           <button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Board</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>#번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>	
								<c:forEach items="${list}" var ="board">									
									<tr>
										<td>${board.bno}</td>
										<td><a class="move" href="${board.bno}">${board.title}</a></td>
										<td>${board.writer}</td>
										<td><fmt:formatDate pattern ="yyyy-MM-dd" value ="${board.regdate}" /></td>
										<td><fmt:formatDate pattern ="yyyy-MM-dd" value ="${board.updateDate}" /></td>
									</tr>			
								</c:forEach>							
                            </table>
                            <!-- /.table-responsive -->

							<!-- 검색 처리 -->
							<div class ="row">
								<div class="col-lg-12">
									<form id="searchForm" action="/board/list" method="get">
									 <!--  검색어 유지 처리 -->
										<select name="type">
											<option value=""  ${pageMaker.cri.type == null ? 'selected' : ''}>---</option>
											<option value="T"  ${pageMaker.cri.type eq 'T' ? 'selected' : ''}>제목</option>
											<option value="C"  ${pageMaker.cri.type eq 'C' ? 'selected' : ''}>내용</option>
											<option value="W"  ${pageMaker.cri.type eq 'W' ? 'selected' : ''}>작성자</option>
											<option value="TC" ${pageMaker.cri.type eq 'TC' ? 'selected' : ''}>제목 or 내용</option>
											<option value="TW" ${pageMaker.cri.type eq 'TW' ? 'selected' : ''}>제목 or 작성자</option>
											<option value="TWC" ${pageMaker.cri.type eq 'TWC' ? 'selected' : ''}>전체검색</option>
										</select>
										
										<input type="text" name="keyword" value ="${pageMaker.cri.keyword}">
										<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
										<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
										<button class="btn btn-default">Search</button>
									</form>					
								</div>
							</div>



						   <!--  페이지번호 처리 -->
						   <div class="pull-right">
						   	<ul class="pagination">
						   	<!-- 이전페이지가 존재하면 이전 버튼을 보여줌 -->
						  		<c:if test="${pageMaker.prev}">
						  			<li class="paginate_button previous">
						  			<a href ="${pageMaker.startPage-1}">Previous</a>
						  			</li>
						  		</c:if>
						  		
						  		<!-- 페이지의 시작과 끝을 반복문으로 처리 -->
						  		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						  			<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active': '' }" >
						  			<a href="${num}">${num}</a>
						  			</li>
						  		</c:forEach>
						  		
						  		<!--  다음 버튼 처리 -->
						  		<c:if test="${pageMaker.next}">
						  			<li class="paginate_button next">
						  			<a href="${pageMaker.endPage+1}">Next</a>
						  			</li>
						  		</c:if>
						   	</ul>
						   </div>
						<!-- /페이지 번호 처리 -->
						
						
						<!-- 페이지 이동 이벤트를 위한 폼 -->
						<form id="actionForm" action="/board/list" method="get">
							<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
							<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
							<input type="hidden" name="type" value="${pageMaker.cri.type}">
							<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
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
        
        
        
  <!-- Modal -->
  <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
          <div class="modal-content">
              <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                  <h4 class="modal-title" id="myModalLabel">처리 결과</h4>
              </div>
              <div class="modal-body">처리가 완료되었습니다.</div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  <button type="button" class="btn btn-primary">Save changes</button>
              </div>
          </div>
          <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
  </div>
  <!-- /.modal -->        

        
        
        

<%@ include file="../include/footer.jsp" %>
</body>


<script type="text/javascript">

	$(document).ready(function(){
		
		//Controller에서 값을 가져옴, 여기서 result는 addFlashAttribute를 통해 저장된 글 번호 
		var result = "<c:out value ='${result}'/>";
		
		
		//글 등록 페이지의 결과값 출력을 위한 모달창 처리 + 뒤로가기시 모달창 안뜨게
		
		checkModal(result);
						//stateobj, title, url
		history.replaceState({},null,null);
		
		function checkModal(result) {
							// history객체 확인
			if(result == '' || history.state) {
				return;
			}
			if(parseInt(result)>0) {
				$(".modal-body").html("게시글" + parseInt(result) + " 번이 등록되었습니다.")
			}			
			$("#myModal").modal("show");
		}
		
		
		//페이지 우측 상단 글 등록 버튼 이벤트 처리
		
		$("#regBtn").on("click",function(){
			location.href ="/board/register";
		});
		
		
		
		//페이지 이동 이벤트 처리
		
		var actionForm = $("#actionForm");
		$(".paginate_button a").on("click",function(e){
			
			e.preventDefault();
			
			console.log("click");
			
			//액션폼의 pageNum의 값을 a링크를 누른 href의 값으로 바꿈
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		
		//게시물 버튼을 눌렀을 때 조회페이지 이동
		
		$(".move").on("click",function(e){
			
			e.preventDefault();
			// 폼에 input 속성을 추가하고 bno값을 넣는다
			actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
			// 폼의 액션 속성을 list에서 get으로 바꿔 조회페이지로 이동시킴
			actionForm.attr("action","/board/get")
			actionForm.submit();
			
		});
		
		
		//검색 버튼 이벤트 처리
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e){
			
			if(!searchForm.find("option:selected").val()){
				alert("검색 종류를 선택하세요");
				return false;	
			}
			
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요");
				return false;
			}
			
			//검색 버튼을 누르면 페이지값은 1페이지로
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchForm.submit();
			
		});
		
		
		
		
		
		
		
		
		
		
		
		
		
	});


</script>



</html>