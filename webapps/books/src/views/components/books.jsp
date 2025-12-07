<%@ include file="/src/repository/book/book.jsp" %>

<div>
    <button onclick="testando()">Criar</button>
</div>

<%
    try {
        while (read.next()) {
%>
            <p>ID: <%= read.getInt("id") %>, Nome: <%= read.getString("name") %></p>
<%
        }
    } catch (Exception e) {
        out.println("Erro: " + e.getMessage());
    } 
    finally {
        if (read != null) read.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>


<script>

  function testando() {
    alert("<%= createUser(connCreate, stmtCreate, url, "teste2", "teste", "teste", "teste") %>")
  }
</script>