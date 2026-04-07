<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>emp list</title>
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
        /* table { 
            display: flex;
            justify-content: center;
            border: none;
        } */
        th{
            background-color: lightblue;
        }
        tr:nth-child(even){
            background-color: #f0ffffbe;
        }
        #index, a {
            text-decoration: none;
            color: #000;
            padding: 3px;
            margin: 3px;
        }
        #index active {
            font-weight: bold;
            color: blue;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>
            <div>
                <select v-model="pageSize" @change="currentPage = 1; fnGetList();">
                    <option value="5">5</option>
                    <option value="10">10</option>
                    <option value="20">20</option>
                </select>
            </div>
         <table>
            <tr>
                <th>사번</th>
                <th>이름</th>
                <th>직급</th>
                <th>사수이름</th>
                <th>급여등급</th>
                <th>부서이름</th>
            </tr>
            <tr v-for="item in list">
                <td>{{item.empNo}}</td>
                <td><a href="javascript:;" @click="fnView(item.empNo)">{{item.eName}}</a></td>
                <td>{{item.job}}</td>
                <td>{{item.mgr}}</td>
                <td>{{item.salGrade}}</td>
                <td>{{item.dName}}</td>
            </tr>
         </table>
         <div> 
            <a href="javascript:;" @click="currentPage-=1; fnGetList();" v-if="currentPage != 1">◀</a>
            <a @click="fnPage(num)" id="index" href="javascript:;" v-for="num in index">
                <span :class="{active : currentPage == num}">{{num}}</span>
            </a>
            <a href="javascript:;" @click="currentPage+=1; fnGetList();" v-if="currentPage != index">▶</a>
         </div>
            <a href="/emp/add.do"><button>추가</button></a>
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
                pageSize: 5, // 한페이지에 출력할 개수
                index : 1, // 최대 페이지 수 디폴트 1
                currentPage : 1 // 현재페이지(위치)
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnGetList: function () {
                let self = this;
                let param = {
                    pageSize : self.pageSize,
                    offSet : self.pageSize * (self.currentPage -1) // db에서 건너뛸 게시물 개수
                };
                $.ajax({
                    url: "http://localhost:8080/emp/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.list = data.list;
                        console.log(data);

                        // 최대 페이지 수 구하는 식 !!! 
                        self.index = Math.ceil(data.totalCount/self.pageSize); // 올림
                        console.log(self.index);
                    }
                });
            },
            fnView: function (empNo) { // 상세보기
                pageChange("/emp/view.do", {empNo : empNo});
            },
            fnPage : function(page) {
                let self = this;
                self.currentPage = page;
                self.fnGetList();
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