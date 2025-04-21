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
    - [] OrderStatus.java
    - [] Order.java
    - [] PaymentInfo.java
    - [] PaymentType.java
    - [] Promotion.java
    - [ ] ShippingMethod.java
    - [x] Variation.java
    - [x] VariationOption.java
    - [x] Ticket.java
  
- [ ] Implementar os métodos essenciais:
    - [ ] Getters e Setters
    - [ ] Construtores
    - [ ] Métodos auxiliares, se necessário

---

##  2. DAO – Criar Classes de Acesso a Dados
Para cada classe de domínio:
- [ ] Criar os DAOs:
    - [x] UserDAO.java
    - [x] ProductDAO.java
    - [ ] PaymentDAO.java
    - [ ] Address.java
    - [ ] OrderDAO.java
    - [ ] TicketDAO.java
  
- [x] Implementar métodos:
    - [ ] inserir(...)
    - [ ] atualizar(...)
    - [ ] eliminar(...)
    - [ ] buscarPorId(...)
    - [ ] listarTodos(...)

---

##  3. Controller – Criar Servlets
Para cada entidade principal:
- [ ] Criar os Servlets:
    - [x] UserServlet.java
    - [x] ProductServlet.java
    - [ ] PaymentServlet.java
    - [ ] AddressServlet.java
    - [ ] OrderServlet.java
    - [ ] TicketServlet.java
- [ ] Implementar ações com `doGet` / `doPost`:
    - [ ] Ação `listar`
    - [ ] Ação `criar` / `inserir`
    - [ ] Ação `editar` / `atualizar`
    - [ ] Ação `eliminar`
- [ ] Enviar dados para a view com `request.setAttribute(...)` e `RequestDispatcher`

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
    - [x] index_userpage.jsp
    - [x] Orderhistory.jsp
    - [x] ProductPage.jsp
    - [x] ProfilePage.jsp
    - [x] SearchBrowse.jsp
    - [x] ShoppingCart_Page.jsp
    - [x] Sign_up_Page.jsp
   
- [ ] Integrar JSP com servlets usando JSTL/EL:
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

