<%-- 
    Document   : grafica
    Created on : 4/05/2016, 03:20:54 PM
    Author     : Saul
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
    HttpSession nSesion = request.getSession();
    String valido = nSesion.getAttribute("Valido") == null ? "" : nSesion.getAttribute("Valido").toString();
    if (valido.equals("")) {
        response.sendRedirect("../login.html");
    }
    String color = nSesion.getAttribute("Color").toString();
    Clases.cConsultaProblema consult = new Clases.cConsultaProblema();
    int largoArr = consult.totalRegistros();
    //ResultSet datos[]= consult.obtenerDatosGrafic(largoArr);

    String dat[][] = new String[largoArr][3];
    String datB[][] = new String[1][3];
    String masVisit[][] = new String[1][2];
    String menosVisit[][] = new String[1][2];
    //out.print(datos[1].getString("Nombre"));

    for (int j = 0; j < largoArr; j++) {
        datB = consult.traerConsultas(j + 1);
        dat[j][0] = datB[0][0];
        dat[j][1] = datB[0][1];
        dat[j][2] = datB[0][2];
    }
    masVisit = consult.mayorConsulta(dat, largoArr);
    menosVisit = consult.menorConsulta(dat, largoArr);
    /* dat[0][0]="NLADOS";
        dat[0][1]="1";
        dat[1][0]="Elipse";
        dat[1][1]="2";
        dat[2][0]="Circ";
        dat[2][1]="4";
        dat[3][0]="Enlaces";
        dat[3][1]="10";
        dat[4][0]="MMM";
        dat[4][1]="2";*/


%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/png" href="imgs/icono.ico"/>
        <link href="../css/sweetalert-master/dist/sweetalert.css" rel="stylesheet" type="text/css"/>
        <script src="../css/sweetalert-master/dist/sweetalert.min.js" type="text/javascript"></script>
        <title>GeometryDrawtechBlog</title>
        <style>
            body
            {
                padding-top: 7%;
                background-color:white;
                font-family: "Roboto",arial;
                overflow-y: hidden;
                -webkit-box-shadow: inset 20px 20px 55px -20px rgba(0,0,0,0.65);
                -moz-box-shadow: inset 20px 20px 55px -20px rgba(0,0,0,0.65);
                box-shadow: inset 20px 20px 55px -20px rgba(0,0,0,0.65);
            }
            ::-webkit-scrollbar{
                width: 10px;
                background-color: transparent;
            }

            ::-webkit-scrollbar-track{
                background-color:rgba(0,0,0,0.9);
                color: #999999
            }

            ::-webkit-scrollbar-thumb{
                background: rgba(99,99,99,0.8);
            }

            ::-webkit-scrollbar-thumb:hover{
                background: rgba(20,113,143,0.8);
            }

            ::-webkit-scrollbar-thumb:window-inactive {
                background: transparent;
            }
        </style>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

        <script type="text/javascript">
            google.charts.load('current', {'packages': ['corechart']});
            /*google.charts.setOnLoadCallback(drawChart1);
             function drawChart1() {
          
             var data = google.visualization.arrayToDataTable([
             ['Problema', 'Consultas'],
             ['<%=dat[0][0]%>',<%=dat[0][1]%>],
             ['<%=dat[1][0]%>',<%=dat[1][1]%>],
             ['<%=dat[2][0]%>',<%=dat[2][1]%>],
             ['<%=dat[3][0]%>',<%=dat[3][1]%>],
             ['<%=dat[4][0]%>',<%=dat[4][1]%>]
             ]);
          
             var options = {
             title: 'Consultas',
             is3D:true,
             };
          
             var chart = new google.visualization.PieChart(document.getElementById('piechart'));
          
             chart.draw(data, options);
             }*/



            // Set a callback to run when the Google Visualization API is loaded.
            google.charts.setOnLoadCallback(drawChart);

            // Callback that creates and populates a data table,
            // instantiates the pie chart, passes in the data and
            // draws it.
            function drawChart() {

                // Create the data table.
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Problema');
                data.addColumn('number', 'Visitas');
                data.addColumn('string', 'Descrip');
                data.addRows([
                    ['<%=dat[0][0]%>',<%=dat[0][1]%>, '<%=dat[0][2]%>'],
                    ['<%=dat[1][0]%>',<%=dat[1][1]%>, '<%=dat[1][2]%>'],
                    ['<%=dat[2][0]%>',<%=dat[2][1]%>, '<%=dat[2][2]%>'],
                    ['<%=dat[3][0]%>',<%=dat[3][1]%>, '<%=dat[3][2]%>'],
                    ['<%=dat[4][0]%>',<%=dat[4][1]%>, '<%=dat[4][2]%>'],
                    ['<%=dat[5][0]%>',<%=dat[5][1]%>, '<%=dat[5][2]%>']
                ]);

                // Set chart options
                var options = {'title': 'Porcentajes de consultas a los problemas de la aplicacion local \n El más visitado es:' + '    ' + '<%=masVisit[0][0]%>' + '\n  Visitas: ' +<%=masVisit[0][1]%> + '\n' + 'El menos visitado es:' + '          ' + '<%=menosVisit[0][0]%>' + '\n ' + 'Visitas: ' +<%=menosVisit[0][1]%>,
                    'width': 1050,
                    'height': 500,
                    //colors: ['#e0440e', '#e6693e', '#ec8f6e', '#f3b49f', '#f6c7b6'],
                    'is3D': true};

                // Instantiate and draw our chart, passing in some options.
                var chart = new google.visualization.PieChart(document.getElementById('grafica'));

                function selectHandler() {
                    var selectedItem = chart.getSelection()[0];
                    if (selectedItem) {
                        var topping = data.getValue(selectedItem.row, 2);

                        swal({title: 'Descrípcion', text: topping, imageUrl: "../img/MS.jpg", showConfirmButton: true, showLoaderOnConfirm: true, html: false});
                    }
                }

                google.visualization.events.addListener(chart, 'select', selectHandler);
                chart.draw(data, options);
            }


            /* google.charts.setOnLoadCallback(drawChart);
             function drawChart() {
          
             var data = google.visualization.arrayToDataTable([
             ['Problema', 'Consultas'],
             ['<%=dat[0][0]%>',<%=dat[0][1]%>],
             ['<%=dat[1][0]%>',<%=dat[1][1]%>],
             ['<%=dat[2][0]%>',<%=dat[2][1]%>],
             ['<%=dat[3][0]%>',<%=dat[3][1]%>],
             ['<%=dat[4][0]%>',<%=dat[4][1]%>]
             ]);
          
             var options = {
             title: 'Consultas',
             is3D:true,
             colors: ['#e0440e', '#e6693e', '#ec8f6e', '#f3b49f', '#f6c7b6']
             };
          
             var chart = new google.visualization.PieChart(document.getElementById('columnchart_material'));
          
             chart.draw(data, options);
             }*/
        </script>
        <!--<script type="text/javascript">
          google.charts.load('current', {'packages':['Bar']});
          google.charts.setOnLoadCallback(drawChart);
          function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ['Problemas', '<%=dat[0][0]%>','<%=dat[1][0]%>','<%=dat[2][0]%>','<%=dat[3][0]%>','<%=dat[4][0]%>'],
              ['Veces visto',<%=dat[0][1]%>,<%=dat[1][1]%>,<%=dat[2][1]%>,<%=dat[3][1]%>,<%=dat[4][1]%>]
            ]);
    
            var options = {
              chart: {
                title: 'Geometry Drawtech',
                subtitle: 'Consultas de cada problema disponible',
              }
            };
    
            var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
    
            chart.draw(data, options);
          }
        </script>-->

        <style>
            #n
            {
                color:#00088F;
            }
        </style>
    </head>
    <body topmargin="0">
        <div id="grafica" name="grafica">
        </div>
        <br />
    </body>
</html>
