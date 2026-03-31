<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>stu-add</title>
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
            <label>학번 : <input v-model="stuNo" maxlength="4" @input="fnStuNoInput"></label>
            <span v-if="stuFlg" style="color: blue;">{{message}}</span>
            <span v-else style="color: red;">{{message}}</span>
        </div> 
        <div>
            <label>이름 : <input v-model="stuName"></label>
        </div> 
        <div>
            <label>학년 : 
                <select v-model="grade">
                    <option value="1">1학년</option>
                    <option value="2">2학년</option>
                    <option value="3">3학년</option>
                    <option value="4">4학년</option>
                </select>
            </label>
        </div>
        <div>
            <label>
                학과 : 
                <select v-model="deptNo">
                    <option v-for="item in deptList" :value="item.deptNo">{{item.dName}}</option>
                </select>
            </label>
        </div>
        <div>
            <label>
                담당교수 : 
                <select v-model="profNo">
                    <option value="">담당교수없음</option>
                    <template v-for="item in profList">
                        <option v-if="deptNo == item.deptNo" :value="item.profNo">{{item.name}}({{item.dName3}})</option>
                    </template>
                    </select>
            </label>
        </div>
        <div>
            <button @click="fnStuAdd">학생 추가</button>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                deptList : [],
                profList : [],
                stuNo : "",
                stuName : "",
                grade : "1",
                deptNo : "",
                profNo : "",
                message : "",
                stuFlg : false
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnDeptList : function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "http://localhost:8080/dept/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.deptList = data.list;
                        self.deptNo = data.list[0].deptNo
                    }
                });
            },
            fnProfList : function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "http://localhost:8080/prof/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.profList = data.list;
                    }
                });
            },
            fnStuAdd : function () {
                let self = this;
                let param = {
                    stuNo : self.stuNo,
                    stuName : self.stuName,
                    grade : self.grade,
                    deptNo : self.deptNo,
                    profNo : self.profNo
                };
                $.ajax({
                    url: "http://localhost:8080/stu/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.message);
                        if(data.result == 'success'){
                            location.href= "/stu/list.do";
                        }
                    }
                });
            },
            fnStuNoInput : function() {
                let self = this;
                self.stuNo = self.stuNo.replace(/[^0-9]/g, ''); //0~9사이가 아닌 값은 빈값으로 대체
                if(self.stuNo.length != 4){
                    self.stuFlg = false;
                    self.message = "학번은 4글자 입니다.";
                    return;
                }
                let param = {
                    stuNo : self.stuNo
                };
                $.ajax({
                    url: "http://localhost:8080/stu/check.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        // console.log(data.message);
                        self.message = data.message;
                        self.stuFlg = data.stuFlg;
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnDeptList();
            self.fnProfList();
        }
    });

    app.mount('#app');
</script>