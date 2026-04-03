<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>board view</title>
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
            제목 : {{info.title}}
         </div>
         <div>
            조회수 : {{info.cnt}}
         </div>
         <div v-for="item in fileList">
            <img :src="item.filePath">
         </div>
         <!-- <div>내용(태그적용안되는거) : {{info.contents}}</div> -->
         <div>
            내용(태그적용된 내용) : <div v-html="info.contents"></div>
         </div>
         <div v-if="info.userId == sessionId || sessionRole == 'A'">
            <button @click="fnEdit">수정</button>
            <button>삭제</button>
         </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                boardNo : "${boardNo}",
                sessionId : "${sessionId}",
                sessionRole : "${sessionRole}",
                info : {},
                fileList : []
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnGetBoard: function () {
                let self = this;
                let param = {
                    boardNo : self.boardNo,
                    kind : "view"
                };
                $.ajax({
                    url: "http://localhost:8080/Board/info.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.info = data.info;
                        self.fileList = data.fileList;
                    }
                });
            }, 
            fnEdit: function () {
                let self = this;
                pageChange("/Board/edit.do", {boardNo : self.boardNo});
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnGetBoard();
        }
    });

    app.mount('#app');
</script>