
console.log("reply Module.......");

var replyService = (function() {

    //댓글 등록
        function add(reply, callback, error) {
        console.log("reply.......");

        $.ajax({

        type : "post",
        url : "/replies/new",
        data : JSON.stringify(reply),  //stringify 객체를 JSON포맷의 문자열로 변환(직렬화)
        contentType : "application/json; charset=UTF-8",
        success : function(result, status, xhr) {  //status서버에 대한 응답코드, xhr 헤더?
            if(callback) {
                callback(result);  //callback(결과) 내부의 처리결과를 외부로 내보냄 
          
                }},
        error : function(xhr, status, er) {
            if(error) {
                error(er);
                }
            }
        });
    }

    //댓글목록 
	function getList(param, callback, error) {

		var bno = param.bno;
		var page = param.page || 1;

		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
				function(data) {
					if (callback) {
						//callback(data);   댓글 목록만 가져오는 경우
                        callback(data.replyCnt, data.list);
					}
				}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}

    // 댓글 삭제
    function remove(rno, replyer, callback, error) {
    
   		 console.log("Stringify : " + JSON.stringify({rno:rno, replyer:replyer})); 
    
        $.ajax({
            type : "delete",
            url : "/replies/" + rno,
            data :  JSON.stringify({rno:rno, replyer:replyer}),
            contentType : "application/json; charset=utf-8",
            success : function(deleteResult, status, xhr) {
                if(callback) {
                    callback(deleteResult);
                }
            },
            error : function(xhr,status,er) {
                if(error){
                    error(er);
                }
            }
        });
    } 


    //댓글 수정
    function update(reply, callback, error) {

        console.log("RNO: " + reply.rno);

        $.ajax({
            type : "put",
            url : "/replies/" + reply.rno,
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            success : function(result, status, xhr) {
                if (callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, er) {
                if (error) {
                    error(er);
                }
            }
        });
    }


    // 댓글 조회
    function get(rno, callback, error) {

        $.get("/replies/" + rno + ".json",
        function(result) {
            if(callback) {
                callback(result);
            }
        }).fail(function(xhr, status, err){
            if(error) {
                error();
            }
        });
    }




    //댓글 시간처리

    function displayTime(timeValue) {
        
        var today = new Date();

        //현재 시간과 댓글 등록 시간과의 차이 
        var gap = today.getTime() - timeValue;

        var dateObj = new Date(timeValue);

        var str = "";

        //시간차가 24시간보다 작으면
        if(gap < (1000 * 60 * 60 * 24)) {
            // 댓글 등록한 시분초를 얻음
            var hh = dateObj.getHours();
            var mi = dateObj.getMinutes();
            var ss = dateObj.getSeconds();

            // 등록시간이 9시가 넘으면 그대로 출력하고 아니면 앞에 0을 붙임
            return [ (hh > 9 ? '' : '0' ) + hh, ':' , (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join('');
        } else {
            
            // 년 월 일 을 얻어옴
            var yy = dateObj.getFullYear();
            var mm = dateObj.getMonth()+1; 
            var dd = dateObj.getDate();

            return [ yy, '/', (mm > 9 ? '' : '0' ) + mm, '/', (dd > 9 ? '' : '0'+ dd)].join('');
        }
        

    };
    
    return {add : add,
            getList: getList,
            remove:remove,
            update:update,
            get:get,
            displayTime : displayTime
            };

})();