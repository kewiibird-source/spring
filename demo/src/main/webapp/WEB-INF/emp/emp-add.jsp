<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>emp add</title>
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
            <label>사번 : <input v-model="info.empNo"></label>
            <!-- <button @click="fnCheck">중복체크</button> -->
         </div>
         <div>
            <label>이름 : <input v-model="info.eName"></label>
         </div>
         <div>
            <label>직급 : <input v-model="info.job"></label>
         </div>
         <div>
            <button @click="fnAdd">추가하기</button>
         </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                info : {
                    empNo : "",
                    eName : "",
                    job : ""
                }
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnCheck: function () {
                let self = this;
                let param = {
                    empNo : self.info.empNo
                };
                $.ajax({
                    url: "http://localhost:8080/",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == 'success'){
                            alert("이미 사용중인 사번입니다.");
                        }
                    }
                });
            },
            fnAdd: function () {
                let self = this;
                let param = self.info;
                $.ajax({
                    url: "http://localhost:8080/emp/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.message);
                        location.href= "/emp/list.do";
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>