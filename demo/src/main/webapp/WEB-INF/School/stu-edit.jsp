<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>stu-edit</title>
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
            <label>학번 : <input v-model="info.stuNo" maxlength="4" disabled></label>
        </div> 
        <div>
            <label>이름 : <input v-model="info.stuName"></label>
        </div> 
        <div>
            <label>학년 : 
                <select v-model="info.grade">
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
                <select v-model="info.deptNo1">
                    <option v-for="item in deptList" :value="item.deptNo">{{item.dName}}</option>
                </select>
            </label>
        </div>
        <div>
            <label>
                담당교수 : 
                <select v-model="info.profNo">
                    <option value="">담당교수없음</option>
                    <template v-for="item in profList">
                        <option v-if="info.deptNo1 == item.deptNo" :value="item.profNo">{{item.name}}({{item.dName3}})</option>
                    </template>
                    </select>
            </label>
        </div>
        <div>
            <button @click="fnStuEdit">수정</button>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                stuNo : "${map.stuNo}",
                deptList : [],
                profList : [],
                info : {
                    stuNo : "",
                    stuName : "",
                    grade : "",
                    deptNo1 : "",
                    profNo : ""
                }
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
                        self.info.stuName = data.info.name;
                    }
                });
            },
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
            fnStuEdit : function(){
                let self = this;
                let param = self.info;
                $.ajax({
                    url: "http://localhost:8080/stu/edit.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        alert(data.message);
                        if(data.result == 'success'){
                            location.href = "/stu/list.do";
                        }
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnDeptList();
            self.fnProfList();
            self.fnGetInfo();
        }
    });

    app.mount('#app');
</script>