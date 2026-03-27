<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
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
            <label>학번 : <input v-model="info.stuNo"></label>
            <button @click="fnCheck">중복체크</button>
         </div>
         <div>
            <label>이름 : <input v-model="info.stuName"></label>
         </div>
         <div>
            <label>학과 : <input v-model="info.stuDept"></label>
         </div>
         <div>
            학년 : 
            <select v-model="info.stuGrade">
                <option value="1">1학년</option>
                <option value="2">2학년</option>
                <option value="3">3학년</option>
            </select>
         </div>
         <div>
            성별 : 
            <label><input type="radio" name="gender" value="M" v-model="info.stuGender">남자</label>
            <label><input type="radio" name="gender" value="F" v-model="info.stuGender">여자</label>
         </div>
         <div>
            <button @click="fnAdd">추가</button>
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
                    stuNo : "",
                    stuName : "",
                    stuDept : "",
                    stuGrade : "1",
                    stuGender : "F"
                }
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnCheck: function () {
                let self = this;
                let param = {
                    stuNo : self.info.stuNo
                };
                $.ajax({
                    url: "http://localhost:8080/stu-check.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.message);
                        if(data.result == 'success'){}
                    }
                });
            },
            fnAdd: function () {
                let self = this;
                if(self.info.stuNo.length != 8){
                    alert("학번은 8글자!");
                    return;
                }
                let param = self.info;
                // console.log(param);
                $.ajax({
                    url: "http://localhost:8080/stu-add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.message);
                        if(data.result == 'success'){}
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