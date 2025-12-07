# Sistema de Gestão de Livros - CRUD Completo

Um sistema CRUD (Create, Read, Update, Delete) completo para gerenciar uma coleção de livros com interface web moderna e intuitiva.

## 📋 Funcionalidades

- ✅ **Listar Livros** - Exibe todos os livros em formato de tabela
- ✅ **Criar Livro** - Adicionar novos livros com modal interativo
- ✅ **Editar Livro** - Atualizar informações dos livros existentes
- ✅ **Deletar Livro** - Remover livros com confirmação
- ✅ **Thumbnails de Imagens** - Exibição de capas dos livros
- ✅ **Validação de Formulários** - Validação no lado do cliente
- ✅ **Mensagens de Feedback** - Alertas de sucesso e erro
- ✅ **Design Responsivo** - Funciona em desktop, tablet e mobile

## 📁 Estrutura de Arquivos

```
webapps/examples/
├── pages/
│   └── books.jsp                 # Página principal do CRUD
├── css/
│   └── books.css                 # Estilos da aplicação
├── js/
│   └── books.js                  # Lógica JavaScript do frontend
├── api/
│   └── bookHandler.jsp           # Handler backend para operações CRUD
├── src/
│   ├── config/
│   │   └── connect.jsp           # Conexão com o banco de dados
│   └── repository/
│       └── book/
│           ├── book.jsp          # Leitura de livros
│           └── bookOperations.jsp # Operações CRUD de livros
└── WEB-INF/
    └── web.xml                   # Configuração da aplicação
```

## 🚀 Como Usar

### 1. Acessar a Página Principal

```
http://localhost:8080/examples/pages/books.jsp
```

### 2. Listar Livros
A página carrega automaticamente todos os livros do banco de dados em uma tabela com paginação visual.

### 3. Criar um Novo Livro
1. Clique no botão **"➕ Novo Livro"**
2. Preencha os campos:
   - **URL da Imagem**: URL completa da imagem (ex: https://...)
   - **Nome do Livro**: Título do livro
   - **Descrição**: Resumo breve (máximo 1-2 linhas)
   - **Conteúdo**: Texto completo do livro
3. Clique em **"💾 Salvar Livro"**

### 4. Editar um Livro
1. Na tabela, clique no botão **"✏️ Editar"** da linha do livro
2. Modifique os campos desejados
3. Clique em **"💾 Atualizar Livro"**

### 5. Deletar um Livro
1. Na tabela, clique no botão **"🗑️ Deletar"** da linha do livro
2. Confirme a exclusão na janela modal
3. O livro será removido do banco de dados

## 🎨 Estilo e Design

### Cores Utilizadas
- **Primária**: Azul (#3498db)
- **Sucesso**: Verde (#27ae60)
- **Perigo**: Vermelho (#e74c3c)
- **Informação**: Azul Marinho (#2980b9)
- **Secundária**: Cinza (#95a5a6)

### Componentes
- **Tabelas**: Layout responsivo com scroll em mobile
- **Modais**: Animação suave com fundo semitransparente
- **Botões**: Hover com sombra e elevação
- **Formulários**: Campos com foco e validação visual
- **Alertas**: Mensagens temporárias de feedback

## 🔄 Fluxo de Dados

```
Frontend (books.jsp)
    ↓
JavaScript (books.js) - Captura ações do usuário
    ↓
API Handler (bookHandler.jsp) - Processa requisições
    ↓
Repository (bookOperations.jsp) - Operações de banco de dados
    ↓
Banco de Dados SQLite (banco3.db)
    ↓
Resposta JSON → Frontend → Atualiza interface
```

## 📝 Operações CRUD Detalhadas

### CREATE (Criar)
```javascript
- Endpoint: /api/bookHandler.jsp
- Método: POST
- Parâmetros: action=create, image, name, description, content
- Resposta: JSON com mensagem de sucesso/erro
```

### READ (Ler)
```jsp
- Implementado em bookOperations.jsp
- Função: readBook()
- Retorna: ResultSet com todos os livros
- Exibido em: Tabela HTML na página principal
```

### UPDATE (Atualizar)
```javascript
- Endpoint: /api/bookHandler.jsp
- Método: POST
- Parâmetros: action=update, id, image, name, description, content
- Resposta: JSON com mensagem de sucesso/erro
```

### DELETE (Deletar)
```javascript
- Endpoint: /api/bookHandler.jsp
- Método: POST
- Parâmetros: action=delete, id
- Resposta: JSON com mensagem de sucesso/erro
- Confirmação: Modal antes de deletar
```

## 🛡️ Segurança

- **SQL Injection Prevention**: Uso de PreparedStatement em todas as operações
- **CSRF Protection**: Formulários validados no servidor
- **Input Validation**: Validação de campos no cliente e servidor
- **Error Handling**: Erros capturados e tratados adequadamente

## 📱 Responsividade

A aplicação é totalmente responsiva:
- **Desktop** (≥1024px): Layout completo com tabela
- **Tablet** (768px - 1023px): Tabela com scroll horizontal
- **Mobile** (<768px): Botões em coluna, tabela compactada

## 🔧 Configurações

### Banco de Dados
- **Tipo**: SQLite
- **Caminho**: `C:/Users/daniel.resende_judit/Downloads/apache-tomcat-9.0.112-windows-x64/apache-tomcat-9.0.112/webapps/examples/banco3.db`
- **Driver**: `org.sqlite.JDBC`

### Tabela de Livros (Esperada)
```sql
CREATE TABLE book (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    image TEXT,
    name TEXT NOT NULL,
    description TEXT,
    content TEXT
);
```

## 🐛 Troubleshooting

### "Erro ao carregar livros"
- Verifique se o banco de dados existe
- Confirme que a tabela `book` está criada
- Verifique o caminho do banco em `src/config/connect.jsp`

### "Livro não foi inserido"
- Verifique se todos os campos estão preenchidos
- Confirme que a conexão com o banco está ativa
- Verifique os logs do Tomcat

### Modal não fecha
- Clique fora do modal (no fundo)
- Pressione a tecla ESC
- Clique no X do modal

## 📚 Estrutura do Banco de Dados

### Tabela: book

| Campo       | Tipo      | Descrição                    |
|-------------|-----------|------------------------------|
| id          | INTEGER   | ID único do livro (PK)       |
| image       | TEXT      | URL da imagem da capa        |
| name        | TEXT      | Nome/Título do livro         |
| description | TEXT      | Descrição breve              |
| content     | TEXT      | Conteúdo completo do livro   |

## 🎯 Próximos Passos

Melhorias futuras podem incluir:
- [ ] Busca e filtro de livros
- [ ] Paginação de resultados
- [ ] Categorias/Gêneros para livros
- [ ] Rating e comentários
- [ ] Upload de imagens (ao invés de URL)
- [ ] Exportação de dados (PDF/Excel)
- [ ] Autenticação de usuários
- [ ] Dashboard com estatísticas

## 📄 Licença

Sistema desenvolvido para fins educacionais.

## 👨‍💻 Autor

Desenvolvido com ❤️ para gestão de biblioteca pessoal.

---

**Última Atualização**: Dezembro 2025
