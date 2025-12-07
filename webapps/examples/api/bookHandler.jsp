<%@ page import="java.sql.*" %>
<%@ page contentType="application/json; charset=UTF-8" %>
<%@ include file="/src/config/connect.jsp" %>
<%@ include file="/src/repository/book/bookOperations.jsp" %>

<%
    // Set response type to JSON
    response.setContentType("application/json; charset=UTF-8");

    String action = request.getParameter("action");
    String result = "";

    try {
        if ("create".equals(action)) {
            String image = request.getParameter("image");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String content = request.getParameter("content");

            result = createBook(connCreate, image, name, description, content);
            
            // Close connections
            if (stmtCreate != null) stmtCreate.close();
            if (connCreate != null) connCreate.close();

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String image = request.getParameter("image");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String content = request.getParameter("content");

            result = updateBook(connCreate, id, image, name, description, content);
            
            // Close connections
            if (stmtCreate != null) stmtCreate.close();
            if (connCreate != null) connCreate.close();

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));

            result = deleteBook(connCreate, id);
            
            // Close connections
            if (stmtCreate != null) stmtCreate.close();
            if (connCreate != null) connCreate.close();

        } else {
            result = "Ação inválida";
        }

        // Return JSON response
        out.println("{\"message\": \"" + result.replace("\"", "\\\"") + "\", \"success\": true}");

    } catch (Exception e) {
        // Return error response
        out.println("{\"message\": \"Erro: " + e.getMessage().replace("\"", "\\\"") + "\", \"success\": false}");

        // Close connections in case of error
        try {
            if (stmtCreate != null) stmtCreate.close();
            if (connCreate != null) connCreate.close();
        } catch (SQLException se) {
            // Ignore close errors
        }
    }
%>
