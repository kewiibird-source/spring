<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>order chart - line</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script> <!-- apexcharts -->
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
         <div id="chart"></div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                priceList : [], //productPriceList
                nameList : [], //productNameList
                chart : null
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnGetList: function () {
                let self = this;
                let param = [];
                $.ajax({
                    url: "http://localhost:8080/product/order.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        for(let i=0; i<data.list.length; i++){
                            self.priceList.push(data.list[i].sumPrice);
                            self.nameList.push(data.list[i].productName);
                        }
                        self.fnChart();
                    }
                });
            },
            fnChart: function () {
                    let self = this;
                    var options = {
                        series: [{
                            name: "매출액",
                            data: self.priceList
                        }],
                        chart: {
                            height: 350,
                            type: 'line',
                            zoom: {
                                enabled: false
                            }
                        },
                        dataLabels: {
                            enabled: false
                        },
                        stroke: {
                            curve: 'straight'
                        },
                        title: {
                            text: 'Product Trends by Month',
                            align: 'left'
                        },
                        grid: {
                            row: {
                                colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
                                opacity: 0.5
                            },
                        },
                        xaxis: {
                            categories: self.nameList,
                        }
                    };

                    self.chart = new ApexCharts(document.querySelector("#chart"), options);
                    self.chart.render();
                }
            
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnGetList();
            // self.fnChart();
        }
    });

    app.mount('#app');
</script>