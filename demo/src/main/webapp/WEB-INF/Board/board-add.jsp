<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>board add</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
    <style>
        body{
            box-sizing: border-box;
        }
        #container{
            width: 800px;
            margin: 50px auto;
        }
        .content{
            width: 750px;
        }

        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        table{
            width: 100%;
        }
        th {
            width: 20%;
        }
        td {
           text-align: left;  
        }
        select{
            height: 30px;
            width: 100px;
        }
        .title{
            height: 30px;
            width: 98%;
        }
        .btn-area {
            text-align: center;
            margin-top: 20px;
        }
        button{
            height: 30px;
            width: 100px;
            margin: 5px;
            border: none;
            border-radius: 10px;
            background-color: antiquewhite;
        }
        .ql-container {
            height: 80%;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div id="container">
            <div class="content"> 
                <table>
                    <tr>
                        <th>게시판</th>
                        <td>
                            <select v-model="info.kind">
                                <option value="1">공지사항</option>
                                <option value="2">자유게시판</option>
                                <option value="3">문의게시판</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td>
                            <input v-model="info.title" class="title">
                        </td>
                    </tr>
                    <tr>
                        <th>첨부파일</th>
                        <td>
                            <input type="file" id="file1" name="file1">
                        </td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td style="height: 300px;">
                             <div id="editor"></div>
                            <!-- <textarea v-model="info.contents"  class="contents" cols="79" rows="10"></textarea> -->
                        </td>
                    </tr>
                    <table>
                        <div class="btn-area">
                            <button @click="fnAdd">글쓰기</button>
                            <button>되돌아가기</button>
                        </div>
                    </table>
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
                info : {
                kind : "1",
                title : "",
                contents : ""
                }
                
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAdd: function () {
                let self = this;
                let param = self.info;
                $.ajax({
                    url: "http://localhost:8080/Board/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.message);
                        if(data.result == 'success'){
                            location.href="/Board/list.do"
                        }
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            // Quill 에디터 초기화
            var quill = new Quill('#editor', {
                theme: 'snow',
                modules: {
                    toolbar: [
                        [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                        ['bold', 'italic', 'underline'],
                        [{ 'color': [] }, { 'background': [] }],
                        [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                        ['link', 'image'],
                        ['clean']
                    ]
                }
            });

            // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
            quill.on('text-change', function() {
                self.info.contents = quill.root.innerHTML;
            });
        }
    });

    app.mount('#app');
</script>