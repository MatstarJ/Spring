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
										<td><a href="/board/get?bno=${board.bno}">${board.title}</a></td>
										<td>${board.writer}</td>
										<td><fmt:formatDate pattern ="yyyy-MM-dd" value ="${board.regdate}" /></td>
										<td><fmt:formatDate pattern ="yyyy-MM-dd" value ="${board.updateDate}" /></td>
									</tr>			
							
								
								</c:forEach>
								
                            </table>
                            <!-- /.table-responsive -->


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
		
		
		
		
		
		
	});


</script>



</html>