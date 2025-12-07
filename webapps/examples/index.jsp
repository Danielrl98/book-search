<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/src/config/connect.jsp" %>
<%-- <%@ include file="/src/example.jsp" %> --%>

<html>
<body>

<div>
    <h1>Lista de livros</h1>
    <%@ include file="/src/views/components/books.jsp" %>
</div>


</body>
</html>
