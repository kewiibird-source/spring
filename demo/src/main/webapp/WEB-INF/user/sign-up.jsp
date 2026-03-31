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
            핸드폰인증 :
            <template v-if="!phoneFlg">
                <input v-model="phoneNumber" placeholder="핸드폰번호 입력하셈"> 
                <button @click="fnAuth">인증번호 발송</button>
            </template>
            <template v-else>
                <template v-if="!ranFlg">
                    <input v-model="phoneAuth" :placeholder="timer">
                    <button @click="fnAuthCheck">인증번호확인</button>
                </template>
            </template>
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
                addr : "",

                phoneNumber : "",
                ranStr : "",
                phoneAuth : "", // 문자로 받은 랜덤 숫자
                phoneFlg : false, // 내가 입력한 숫자
                ranFlg : false, //인증번호 정상 입력시 true

                count : 180,
                timer : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnJoin : function () {
                let self = this;
                if(!self.ranFlg){
                    alert("문자 인증 후 진행해주세요.");
                    retuen;
                }
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
            },
            fnAuth : function() {
                let self = this;
                let param = {
                    phoneNumber : self.phoneNumber
                };
                $.ajax({
                    url: "http://localhost:8080/send-one",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.res.groupInfo.status == "SENDING"){
                            alert("문자가 전송되었습니다.");
                            self.phoneFlg = true;
                            self.ranStr = data.ranStr;
                            setInterval(self.fnTimer, 1000)
                        } else {
                            alert("에러가 발생했습니다.");
                        }
                    }
                });
            },
            fnTimer : function(){
                let self = this;
                let min = "";
                let sec = "";
                min = parseInt(self.count / 60);
                sec = parseInt(self.count % 60);

                // 10이하일때 0붙이기 02 : 09
                min = min < 10 ? "0" + min : min;
                sec = sec < 10 ? "0" + sec : sec;

                self.timer = min + ":" + sec
                self.count--;
            },
            fnAuthCheck : function(){
                let self = this;
                if(self.ranStr == self.phoneAuth){
                    alert("인증되었습니다!");
                    self.ranFlg = true;
                } else {
                    alert("인증번호 다시 확인해주셈");
                }
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