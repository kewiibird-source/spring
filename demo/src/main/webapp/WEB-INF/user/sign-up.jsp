<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>sign-up</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        input {
            outline: none;   
        }
        
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->

         <div>
            <label>아이디 : <input v-model="userId"></label>
            <button @click="fnCheck">중복체크</button>
         </div>
         <div>
            <label>비밀번호 : <input v-model="pwd" type="password"></label>
         </div>
         <div>
            <label>이름 : <input v-model="userName" ></label>
         </div>
         <div>
            <label>주소 : 
                <input v-model="addr">
                <button @click="fnAddr()">주소검색</button>
            </label>
        </div>
        <div>
            <button @click="fnJoin">가입</button>
        </div>
        </div>
        
</body>
</html>

<script>

    function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
        console.log(window.vueObj);
        window.vueObj.addr = roadFullAddr;
    }

    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                userId : "",
                pwd : "",
                userName : "",
                addr : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnJoin : function () {
                let self = this;
                let param = {
                    userId : self.userId,
                    pwd : self.pwd,
                    userName : self.userName
                };
                $.ajax({
                    url: "http://localhost:8080/join.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.message);
                    }
                });
            },
            fnCheck : function () {
                let self = this;
                let param = {
                    userId : self.userId,
                };
                $.ajax({
                    url: "http://localhost:8080/check.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.message);
                    }
                });
            },
            fnAddr : function() {
                window.open("/addr.do", "addr", "width=500, height=500");
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            window.vueObj = this;
        }
    });

    app.mount('#app');
</script>