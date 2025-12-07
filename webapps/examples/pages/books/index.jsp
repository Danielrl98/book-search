<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/src/config/connect.jsp" %>
<%@ include file="/src/repository/book/book.jsp" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Livros - CRUD</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/books.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 Sistema de Gestão de Livros</h1>
            <button class="btn btn-primary btn-lg" onclick="openCreateModal()">
                ➕ Novo Livro
            </button>
        </div>

        <!-- Mensagens de Feedback -->
        <div id="successMessage" class="alert alert-success" style="display: none;"></div>
        <div id="errorMessage" class="alert alert-danger" style="display: none;"></div>

        <!-- Tabela de Livros -->
        <div class="books-container">
            <table class="books-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Imagem</th>
                        <th>Nome</th>
                        <th>Descrição</th>
                        <th>Conteúdo</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody id="booksTableBody">
                    <%
                        try {
                            if (read != null) {
                                while (read.next()) {
                    %>
                    <tr>
                        <td><%= read.getInt("id") %></td>
                        <td>
                            <% String image = read.getString("image"); %>
                            <% if (image != null && !image.isEmpty()) { %>
                                <img src="<%= image %>" alt="<%= read.getString("name") %>" class="book-thumbnail">
                            <% } else { %>
                                <span class="no-image">Sem imagem</span>
                            <% } %>
                        </td>
                        <td><strong><%= read.getString("name") %></strong></td>
                        <td><%= read.getString("description") %></td>
                        <td><%= read.getString("content") %></td>
                        <td>
                            <button class="btn btn-info btn-sm" 
                                    onclick="openUpdateModal(
                                        <%= read.getInt("id") %>, 
                                        '<%= read.getString("image") %>', 
                                        '<%= read.getString("name").replace("'", "\\'") %>', 
                                        '<%= read.getString("description").replace("'", "\\'") %>', 
                                        '<%= read.getString("content").replace("'", "\\'") %>'
                                    )">
                                ✏️ Editar
                            </button>
                            <button class="btn btn-danger btn-sm" 
                                    onclick="deleteBook(<%= read.getInt("id") %>)">
                                🗑️ Deletar
                            </button>
                        </td>
                    </tr>
                    <%
                                }
                            }
                        } catch (Exception e) {
                    %>
                    <tr>
                        <td colspan="6" class="error-message">
                            Erro ao carregar livros: <%= e.getMessage() %>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal para Criar Livro -->
    <div id="createModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeCreateModal()">&times;</span>
            <h2>Adicionar Novo Livro</h2>
            <div id="createBookForm">
                <div class="form-group">
                    <label for="createImage">URL da Imagem:</label>
                    <input type="url" id="createImage" name="image" placeholder="https://exemplo.com/imagem.jpg" required>
                </div>

                <div class="form-group">
                    <label for="createName">Nome do Livro:</label>
                    <input type="text" id="createName" name="name" placeholder="Digite o nome do livro" required>
                </div>

                <div class="form-group">
                    <label for="createDescription">Descrição:</label>
                    <textarea id="createDescription" name="description" placeholder="Descrição breve do livro" rows="3" required></textarea>
                </div>

                <div class="form-group">
                    <label for="createContent">Conteúdo:</label>
                    <textarea id="createContent" name="content" placeholder="Conteúdo completo do livro" rows="5" required></textarea>
                </div>

                <div class="form-actions">
                    <button onclick="submitCreateForm()" class="btn btn-success">💾 Salvar Livro</button>
                    <button type="button" class="btn btn-secondary" onclick="closeCreateModal()">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para Atualizar Livro -->
    <div id="updateModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeUpdateModal()">&times;</span>
            <h2>Editar Livro</h2>
            <form id="updateBookForm" onsubmit="submitUpdateForm(event)">
                <input type="hidden" id="updateId" name="id">

                <div class="form-group">
                    <label for="updateImage">URL da Imagem:</label>
                    <input type="url" id="updateImage" name="image" placeholder="https://exemplo.com/imagem.jpg" required>
                </div>

                <div class="form-group">
                    <label for="updateName">Nome do Livro:</label>
                    <input type="text" id="updateName" name="name" placeholder="Digite o nome do livro" required>
                </div>

                <div class="form-group">
                    <label for="updateDescription">Descrição:</label>
                    <textarea id="updateDescription" name="description" placeholder="Descrição breve do livro" rows="3" required></textarea>
                </div>

                <div class="form-group">
                    <label for="updateContent">Conteúdo:</label>
                    <textarea id="updateContent" name="content" placeholder="Conteúdo completo do livro" rows="5" required></textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-success">💾 Atualizar Livro</button>
                    <button type="button" class="btn btn-secondary" onclick="closeUpdateModal()">Cancelar</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal de Confirmação de Exclusão -->
    <div id="deleteModal" class="modal">
        <div class="modal-content modal-confirmation">
            <h2>Confirmar Exclusão</h2>
            <p>Tem certeza de que deseja deletar este livro?</p>
            <p class="warning">Esta ação não pode ser desfeita.</p>
            <div class="form-actions">
                <button class="btn btn-danger" onclick="confirmDelete()">🗑️ Sim, Deletar</button>
                <button class="btn btn-secondary" onclick="cancelDelete()">Cancelar</button>
            </div>
        </div>
    </div>

    <script>
        // API Handler URL
        const API_HANDLER = "${pageContext.request.contextPath}/api/bookHandler.jsp";
    </script>
    <script>
    // ==================== Modal Management ====================

function openCreateModal() {
    const modal = document.getElementById("createModal");
    modal.style.display = "block";
    document.getElementById("createBookForm").reset();
}

function closeCreateModal() {
    const modal = document.getElementById("createModal");
    modal.style.display = "none";
}

function openUpdateModal(id, image, name, description, content) {
    const modal = document.getElementById("updateModal");
    modal.style.display = "block";

    document.getElementById("updateId").value = id;
    document.getElementById("updateImage").value = decodeURIComponent(image);
    document.getElementById("updateName").value = decodeURIComponent(name);
    document.getElementById("updateDescription").value = decodeURIComponent(description);
    document.getElementById("updateContent").value = decodeURIComponent(content);
}

function closeUpdateModal() {
    const modal = document.getElementById("updateModal");
    modal.style.display = "none";
}

// ==================== Delete Modal ====================
let deleteBookId = null;

function deleteBook(id) {
    deleteBookId = id;
    const modal = document.getElementById("deleteModal");
    modal.style.display = "block";
}

function confirmDelete() {
    if (deleteBookId === null) return;

    const formData = new FormData();
    formData.append("action", "delete");
    formData.append("id", deleteBookId);

    fetch(API_HANDLER, {
        method: "POST",
        body: formData
    })
        .then((response) => response.json())
        .then((data) => {
            if (data.success) {
                showSuccessMessage("Livro deletado com sucesso!");
                setTimeout(() => {
                    location.reload();
                }, 1500);
            } else {
                showErrorMessage(data.message);
            }
        })
        .catch((error) => {
            showErrorMessage("Erro ao deletar livro: " + error);
            console.error("Erro:", error);
        })
        .finally(() => {
            cancelDelete();
        });
}

function cancelDelete() {
    deleteBookId = null;
    const modal = document.getElementById("deleteModal");
    modal.style.display = "none";
}

// ==================== Form Submission ====================

function submitCreateForm(event) {
  /*  event.preventDefault();

    const form = document.getElementById("createBookForm");
    const formData = new FormData(form);
    formData.append("action", "create");

    fetch(API_HANDLER, {
        method: "POST",
        body: formData
    })
        .then((response) => response.json())
        .then((data) => {
            if (data.success) {
                showSuccessMessage("Livro criado com sucesso!");
                closeCreateModal();
                setTimeout(() => {
                    location.reload();
                }, 1500);
            } else {
                showErrorMessage(data.message);
            }
        })
        .catch((error) => {
            showErrorMessage("Erro ao criar livro: " + error);
            console.error("Erro:", error);
        }); */

alert("<%=  createUser(connCreate, stmtCreate, "agora vai", "agora vai", "agora vai", "agora vai") %>")
   


}

function submitUpdateForm(event) {
    event.preventDefault();

    const form = document.getElementById("updateBookForm");
    const formData = new FormData(form);
    formData.append("action", "update");

    fetch(API_HANDLER, {
        method: "POST",
        body: formData
    })
        .then((response) => response.json())
        .then((data) => {
            if (data.success) {
                showSuccessMessage("Livro atualizado com sucesso!");
                closeUpdateModal();
                setTimeout(() => {
                    location.reload();
                }, 1500);
            } else {
                showErrorMessage(data.message);
            }
        })
        .catch((error) => {
            showErrorMessage("Erro ao atualizar livro: " + error);
            console.error("Erro:", error);
        });
}

// ==================== Message Handling ====================

function showSuccessMessage(message) {
    const messageDiv = document.getElementById("successMessage");
    messageDiv.textContent = message;
    messageDiv.style.display = "block";
    setTimeout(() => {
        messageDiv.style.display = "none";
    }, 4000);
}

function showErrorMessage(message) {
    const messageDiv = document.getElementById("errorMessage");
    messageDiv.textContent = message;
    messageDiv.style.display = "block";
    setTimeout(() => {
        messageDiv.style.display = "none";
    }, 4000);
}

// ==================== Modal Close on Outside Click ====================

window.onclick = function (event) {
    const createModal = document.getElementById("createModal");
    const updateModal = document.getElementById("updateModal");
    const deleteModal = document.getElementById("deleteModal");

    if (event.target === createModal) {
        closeCreateModal();
    }
    if (event.target === updateModal) {
        closeUpdateModal();
    }
    if (event.target === deleteModal) {
        cancelDelete();
    }
};

// ==================== Keyboard Navigation ====================

document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
        closeCreateModal();
        closeUpdateModal();
        cancelDelete();
    }
});
</script>
</body>
</html>
