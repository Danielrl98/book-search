<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="application/json;charset=UTF-8" %>
<%@ include file="/src/config/connect.jsp" %>
<%@ include file="/src/repository/book/book.jsp" %>

<%
response.setCharacterEncoding("UTF-8");

if (!"POST".equalsIgnoreCase(request.getMethod())) {
    response.setStatus(405);
    out.print("Only the POST method is allowed");
    return;
}

request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");

if (id == null) {
    response.setStatus(400);
    out.print("id is required");
    return;
}

String res = deleteBook(conn, Integer.parseInt(id));

conn.close();

out.print(res);

%>
