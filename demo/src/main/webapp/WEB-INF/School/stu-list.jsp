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
         <div id="container">
            <div class="search-area">
                <label>학년 :
                    <select v-model="grade" @change="fnGetList">
                        <option value="">:: 전체 ::</option>
                        <option value="1">1학년</option>
                        <option value="2">2학년</option>
                        <option value="3">3학년</option>
                        <option value="4">4학년</option>
                    </select>
                </label>
            </div>
            <div class="table-area">
                <table>
                    <tr>
                        <th>학번</th>
                        <th>이름</th>
                        <th>학부</th>
                        <th>학과</th>
                        <th>학년</th>
                        <th>담당교수</th>
                    </tr>
                    <tr v-for="item in list">
                        <td>{{item.stuNo}}</td>
                        <td>{{item.name}}</td>
                        <td>{{item.dName2}}</td>
                        <td>{{item.dName3}}</td>
                        <td>{{item.grade}}</td>
                        <td>{{item.profName}}</td>
                    </tr>
                </table>
            </div>
         </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list : [],
                grade : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnGetList: function () {
                let self = this;
                let param = {
                    grade : self.grade
                };
                $.ajax({
                    url: "http://localhost:8080/stu/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnGetList();
        }
    });

    app.mount('#app');
</script>