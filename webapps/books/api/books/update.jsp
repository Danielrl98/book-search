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

String image = request.getParameter("name");
String name = request.getParameter("name");
String description = request.getParameter("description");
String content = request.getParameter("content");

if (name == null || name.trim().isEmpty()) {
    response.setStatus(400);
    out.print("name is required");
    return;
}

String res = createBook(conn, image, name, description, content);

conn.close();

out.print(res);

%>
