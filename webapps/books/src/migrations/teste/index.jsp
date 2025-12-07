<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/src/config/connect.jsp" %>

<%! 
    String createUser(Connection conn) throws Exception {
        String result = "Erro ao criar";
        
        String sql = "CREATE TABLE IF NOT EXISTS Customers (" +
                     "CustomerID INTEGER PRIMARY KEY, " +
                     "FirstName VARCHAR(50) NOT NULL, " +
                     "LastName VARCHAR(50) NOT NULL, " +
                     "Age INTEGER CHECK (Age >= 0)" +
                     ")";

        //String sql  = "DROP TABLE Customers";
        
        try (Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
            result = "Tabela criada com sucesso!";
        } catch(SQLException e) {

            throw new Exception("Erro ao criar tabela: " + e.getMessage());
        }
        
        return result;
    }
%>

<%
    try {
        String resultado = createUser(conn);
        out.println("<h1>" + resultado + "</h1>");
    } catch(Exception e) {
        out.println("<h1>Erro: " + e.getMessage() + "</h1>");
    }
%>

<html>
<body>
    <h1>Status da Criação da Tabela</h1>
    <%
        try {
            String resultado = createUser(conn);
            out.println("<p>" + resultado + "</p>");
        } catch(Exception e) {
            out.println("<p style='color: red;'>Erro: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>