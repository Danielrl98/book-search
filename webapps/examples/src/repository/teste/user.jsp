<%@ include file="/src/config/connect.jsp" %>

<%! 
    ResultSet readUser(Connection conn, Statement stmt) throws Exception {
        String query = "SELECT * FROM user";
        return stmt.executeQuery(query); 
    }
%>

<%! 
    String createUser(Connection conn, Statement stmt) throws Exception {

        String result = "Erro ao criar";

        try {
            stmt.executeQuery("INSERT INTO user (name)
                VALUES (wendel);
            "); 

            result = "Successo ao criar";
        } catch(Exception e) {
            System.out.println("Erro: " + e.getMessage());
        }

        return result;
    }
%>

<%
    ResultSet read = readUser(conn, stmt);
%>

