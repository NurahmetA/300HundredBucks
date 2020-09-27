<%@ page import="java.io.File" %><%--
  Created by IntelliJ IDEA.
  User: alemh
  Date: 24.09.2020
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@include file="component/header.jsp"%>
<h1>Welcome to File Manager</h1>
<h3>Currently you are located here: <%=(String)request.getAttribute("currentLoc")%></h3>
<h3>Files:</h3>

<%! File myDir = new File("C:\\File Manager"); %>
<%
    if(myDir.isDirectory())
    {
        // получаем все вложенные объекты в каталоге
        for(File item : myDir.listFiles()){
%>
<h5 style="color: lightseagreen"> - <%
            if(item.isDirectory()){
                out.println(item.getName() + "  \t Folder");
            }
            else{

                out.println(item.getName() + "\t File");
            }
        }
%> </h5> <%
    }
%>
</body>
</html>
