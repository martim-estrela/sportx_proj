# sportx_proj
Projeto Universitário

TODO_LIST:
# ✅ TO-DO LIST – Projeto SportX (MVC com JSP + DAO + MySQL)

Este ficheiro contém a lista de tarefas pendentes para o desenvolvimento completo da aplicação **SportX**, utilizando a arquitetura MVC, JSP no front-end, DAO para acesso a dados e servlets como controladores.

---

##  1. Model – Completar as Classes
- [x] Verificar se todas as classes do domínio estão criadas:
    - [x] User.java
    - [x] Product.java
    - [x] ProductCategoryChild.java
    - [x] ProductCategoryParent.java
    - [x] ProductItem.java
    - [X] OrderStatus.java
    - [X] Order.java
    - [X] PaymentInfo.java
    - [X] PaymentType.java
    - [X] Promotion.java
    - [X] ShippingMethod.java
    - [x] Variation.java
    - [x] VariationOption.java
    - [x] Ticket.java
  
- [X] Implementar os métodos essenciais:
    - [X] Getters e Setters
    - [X] Construtores
    - [X] (alguns) Métodos auxiliares, se necessário

---

##  2. DAO – Criar Classes de Acesso a Dados
Para cada classe de domínio:
- [x] Criar os DAOs:
    - [x] DBConnection
    - [x] UserDAO.java
    - [X] TicketDAO.java
    - [X] StockManagementDAO.java
    - [ ] ProductDAO.java
    - [ ] PaymentDAO.java
    - [ ] OrderDAO.java
  
- [x] Implementar métodos:
    - [X] (alguns) inserir(...)
    - [X] (alguns) atualizar(...)
    - [X] (alguns) eliminar(...)
    - [X] (alguns) buscarPorId(...)
    - [X] (alguns) listarTodos(...)

---

##  3. Controller – Criar Servlets
Para cada entidade principal:
- [ ] Criar os Servlets:
    - [x] UserServlet.java
    - [ ] ProductServlet.java
    - [ ] PaymentServlet.java
    - [X] AddressServlet.java
    - [X] filterServlet.java
    - [X] LoginServlet.java
    - [X] SignUpServlet.java
    - [X] StockManagementeServlet.java
    - [X] UserPaginationServlet.java
    - [X] UpdateProfileServlet.java
    - [ ] OrderServlet.java
    - [X] TicketServlet.java
- [X] Implementar ações com `doGet` / `doPost`:
    - [X] Ação `listar`
    - [X] Ação `criar` / `inserir`
    - [X] Ação `editar` / `atualizar`
    - [X] Ação `eliminar`
- [X] Enviar dados para a view com `request.setAttribute(...)` e `RequestDispatcher`

---

##  4. View – Integração com JSP
- [X] Criar páginas JSP para cada função:
    - [x] Loginpage.jsp
    - [x] AdminPage_StockManagement.jsp
    - [x] AdminPage_UserManagement
    - [x] Chat_Page.jsp
    - [x] CheckoutPage.jsp
    - [x] ContactUs.jsp
    - [x] FAQ.jsp
    - [x] index.jsp
    - [x] Orderhistory.jsp
    - [x] ProductPage.jsp
    - [x] ProfilePage.jsp
    - [x] SearchBrowse.jsp
    - [x] ShoppingCart_Page.jsp
    - [x] Sign_up_Page.jsp
   



## 5. Nao por no power point (prototipo)

  
- [] Integrar JSP com servlets usando JSTL/EL:
  - [ ] Admin_StockManagement.jsp
    - [ ] Listar Produtos
    - [ ] Filtrar Produtos
    - [ ] Gerar pdf com relatório de stock
    - [ ] Desenvolver funcionaliadade para adição de produtos
  - [ ] Admin_UserManagement.jsp
    - [ ] Listar Users
    - [ ] Filtar Users
    - [ ] Gerar pdf com relatorio de users
    - [ ] Desenvolver funcionaliadade para adição de users
      ```jsp
      <c:forEach var="produto" items="${listaProdutos}">
          <tr>
              <td>${produto.nome}</td>
              <td>${produto.preco}</td>
          </tr>
      </c:forEach>

