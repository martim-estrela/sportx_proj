# sportx_proj
Projeto Universitário

TODO_LIST:
# ✅ TO-DO LIST – Projeto SportX (MVC com JSP + DAO + MySQL)

Este ficheiro contém a lista de tarefas pendentes para o desenvolvimento completo da aplicação **SportX**, utilizando a arquitetura MVC, JSP no front-end, DAO para acesso a dados e servlets como controladores.

---

##  1. Model – Completar as Classes
- [ ] Verificar se todas as classes do domínio estão criadas:
    - [ ] User.java
    - [ ] Product.java
    - [ ] ProductCategoryChild.java
    - [ ] ProductCategoryParent.java
    - [ ] ProductItem.java
    - [ ] OrderStatus.java
    - [ ] Order.java
    - [ ] PaymentInfo.java
    - [ ] PaymentType.java
    - [ ] Promotion.java
    - [ ] ShippingMethod.java
    - [ ] Variation.java
    - [ ] VariationOption.java
    - [ ] Ticket.java
  
- [ ] Implementar os métodos essenciais:
    - [ ] Getters e Setters
    - [ ] Construtores
    - [ ] Métodos auxiliares, se necessário

---

##  2. DAO – Criar Classes de Acesso a Dados
Para cada classe de domínio:
- [ ] Criar os DAOs:
    - [ ] UserDAO.java
    - [ ] ProductDAO.java
    - [ ] PaymentDAO.java
    - [ ] Address.java
    - [ ] OrderDAO.java
    - [ ] TicketDAO.java
  
- [ ] Implementar métodos:
    - [ ] inserir(...)
    - [ ] atualizar(...)
    - [ ] eliminar(...)
    - [ ] buscarPorId(...)
    - [ ] listarTodos(...)

---

##  3. Controller – Criar Servlets
Para cada entidade principal:
- [ ] Criar os Servlets:
    - [ ] UserServlet.java
    - [ ] ProductServlet.java
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
- [ ] Criar páginas JSP para cada função:
    - [ ] Loginpage.jsp
    - [ ] AdminPage_StockManagement.jsp
    - [ ] AdminPage_UserManagement
    - [ ] Chat_Page.jsp
    - [ ] CheckoutPage.jsp
    - [ ] ContactUs.jsp
    - [ ] FAQ.jsp
    - [ ] index.jsp
    - [ ] index_userpage.jsp
    - [ ] Orderhistory.jsp
    - [ ] ProductPage.jsp
    - [ ] ProfilePage.jsp
    - [ ] SearchBrowse.jsp
    - [ ] ShoppingCart_Page.jsp
    - [ ] Sign_up_Page.jsp
   
- [ ] Integrar JSP com servlets usando JSTL/EL:
  ```jsp
  <c:forEach var="produto" items="${listaProdutos}">
      <tr>
          <td>${produto.nome}</td>
          <td>${produto.preco}</td>
      </tr>
  </c:forEach>

