<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>user-list</title>
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
         <table>
            <tr>
                <th>선택</th>
                <th>아이디</th>
                <th>이름</th>
                <th>성별</th>
                <th>삭제</th>
            </tr>
            <tr v-for="item in list">
                <td><input type="radio" name="user" v-model="selectUserId" :value="item.userId"></td>
                <td>{{item.userId}}</td>
                <td>{{item.userName}}</td>
                <td>
                    <span v-if="item.gender == 'M'">남자</span>
                    <span v-else-if="item.gender == 'F'">여자</span>
                    <span v-else>정보없음</span>
                </td>
                <td>
                    <button @click="fnRemove(item.userId)">삭제</button>
                </td>
            </tr>
         </table>
         <button @click="fnDelete(selectUserId)">삭제</button>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list : [],
                selectUserId : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnGetList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "http://localhost:8080/user/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                    }
                });
            },
            fnRemove: function (userId) { //user삭제
                let self = this;
                if(!confirm("삭제하시겠습닉꽈?")){
                    return; //취소때실행
                }
                let param = {
                    userId : userId //xml에서 
                };
                $.ajax({
                    url: "http://localhost:8080/user/remove.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data); // 콘솔창에 내가 삭제버튼누른 user 표시
                        alert(data.message); // service에서 성공or실패시 나오는 메세지출력
                        self.fnGetList(); // 삭제후 다시 리스트 조회해서 화면에 뿌려줌
                    }
                });
            },
            fnDelete: function () { //user삭제
                let self = this;
                if(!confirm("삭제하시겠습닉꽈?")){
                    return; //취소때실행
                }
                let param = {
                    userId : self.selectUserId //xml에서 userId라는 이름으로 받기로 했음, 바뀌면 클남
                };
                $.ajax({
                    url: "http://localhost:8080/user/remove.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data); // 콘솔창에 내가 삭제버튼누른 user 표시
                        alert(data.message); // service에서 성공or실패시 나오는 메세지출력
                        self.fnGetList(); // 삭제후 다시 리스트 조회해서 화면에 뿌려줌
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