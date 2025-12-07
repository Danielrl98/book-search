<%-- <%@ include file="/src/repository/user/user.jsp" %>

<%
    try {

        while (read.next()) {
%>
            <p>ID: <%= read.getInt("id") %>, Nome: <%= read.getString("name") %></p>
<%
        }
    } catch (Exception e) {
        out.println("Erro: " + e.getMessage());
    } finally {
        if (read != null) read.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%> --%>