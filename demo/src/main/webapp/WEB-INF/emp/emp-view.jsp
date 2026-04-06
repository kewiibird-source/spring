<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>emp view</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-change.js"></script>
    <style>
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        tr:nth-child(even){
            background-color: azure;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            사번 : {{info.empNo}}
         </div>
         <div>
            이름 : {{info.eName}}
         </div>
         <div>
            직급 : {{info.job}}
         </div>
         <div>
            사수 : {{info.mgr}}
         </div>
         <div>
            급여등급 : {{info.salGrade}}
         </div>
         <div>
            부서명 : {{info.dName}}
         </div>
         <div>
            <button @click="fnRemove(info.empNo)">삭제</button>
         </div>
    </div>
    
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                empNo : "${map.empNo}",
                info : {}
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnView: function () {
                let self = this;
                let param = {
                    empNo : self.empNo
                };
                $.ajax({
                    url: "http://localhost:8080/emp/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.info = data.info;
                        console.log(data);
                    }
                });
            },
            fnRemove: function (empNo) { //user삭제
                let self = this;
                console.log("전달받은 사번:", empNo);
                if(!confirm("삭제할거?")){
                    return; //취소때실행
                }
                let param = {
                    empNo : empNo //xml에서 
                };
                $.ajax({
                    url: "http://localhost:8080/emp/remove.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data); // 콘솔창에 내가 삭제버튼누른 user 표시
                        alert(data.message); // service에서 성공or실패시 나오는 메세지출력
                        location.href = "/emp/list.do";
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnView();
        }
    });

    app.mount('#app');
</script>