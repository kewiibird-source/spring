<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>stu-list</title>
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
                <label>
                    학과 : 
                    <select v-model="deptNo" @change="fnGetList">
                        <option value="">:: 전체 ::</option>
                        <option v-for="item in deptList" :value="item.deptNo">{{item.dName}}</option>
                    </select>
                </label>
            </div>
            <div class="order-area">
                <label><input type="radio" name="order" value="name" v-model="orderItem"> 이름순</label>
                <label><input type="radio" name="order" value="dept" v-model="orderItem"> 학과순</label>
                <label><input type="radio" name="order" value="grade" v-model="orderItem"> 학년순</label>
                <button @click="fnGetList">조회</button>
            </div>
            <div class="table-area">
                <table>
                    <tr>
                        <th>선택</th>
                        <th>학번</th>
                        <th>이름</th>
                        <th>학부</th>
                        <th>학과</th>
                        <th>학년</th>
                        <th>담당교수</th>
                        <th>삭제</th>
                    </tr>
                    <tr v-for="item in list">
                        <td><input type="checkbox" v-model="selectList" :value="item.stuNo"></td>
                        <td>{{item.stuNo}}</td>
                        <td>
                            <a href="javascript:;" @click="fnView(item.stuNo)">{{item.name}}</a>
                        </td>
                        <td>{{item.dName2}}</td>
                        <td>{{item.dName3}}</td>
                        <td>{{item.grade}}</td>
                        <td>{{item.profName}}</td>
                        <td><button @click="fnRemove(item.stuNo)">삭제</button></td>
                    </tr>
                </table>
            </div>
            <div class="btn-area">
                <a href="/stu/add.do"><button>학생추가</button></a>
                <button @click="fnRemoveAll">삭제(체크박스)</button>
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
                deptList : [],
                grade : "",
                deptNo : "",
                selectList : [], // 체크박스로 선택한것들 담는 리스트
                orderItem : "grade"
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnGetList: function () {
                let self = this;
                let param = {
                    grade : self.grade,
                    deptNo : self.deptNo,
                    orderItem : self.orderItem
                };
                $.ajax({
                    url: "http://localhost:8080/stu/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        self.deptList = data.deptList;
                    }
                });
            },
            fnGetDeptList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "http://localhost:8080/dept/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.deptList = data.list;
                    }
                });
            },
            fnRemove: function (stuNo) {
                let self = this;
                let param = {
                    stuNo : stuNo
                };
                $.ajax({
                    url: "http://localhost:8080/stu/remove.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.message);
                        self.fnGetList();
                    }
                });
            },
            fnView : function(stuNo){
                pageChange("/stu/view.do", {stuNo : stuNo});
            },
            fnRemoveAll : function(){
                let self = this;
                var fList = JSON.stringify(self.selectList);
                let param = {
                    selectList : fList
                    // {selectList=["2222","9411","9412"]} 문자열형식
                };
                $.ajax({
                    url: "http://localhost:8080/stu/remove-all.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.message);
                        self.selectList = []; //삭제가끝나면한번비워주기
                        self.fnGetList();
                    }
                });
            },
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnGetList();
            // self.fnGetDeptList();
        }
    });

    app.mount('#app');
</script>