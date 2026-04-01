<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>stu-view 상세보기</title>
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
            이름 : {{info.name}}
         </div>
         <div>
            학번 : {{info.stuNo}}
         </div>
         <div>
            학과 : {{info.dName3}}
         </div>
         <div>
            담당교수 : {{info.profName}}
         </div>
         <button @click="fnEdit">수정</button>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                stuNo : "${map.stuNo}",
                info : {}
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnGetInfo: function () {
                let self = this;
                let param = {
                    stuNo : self.stuNo
                };
                $.ajax({
                    url: "http://localhost:8080/stu/info.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.info = data.info;
                    }
                });
            },
            fnEdit : function() {
                pageChange("/stu/edit.do", {stuNo : this.stuNo});
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnGetInfo();
        }
    });

    app.mount('#app');
</script>