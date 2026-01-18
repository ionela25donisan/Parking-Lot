
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:pageTemplate pageTitle="Users">

  <!-- Buton Add User - doar pentru WRITE_USERS -->
  <div class="container text-center mb-3">
    <c:if test="${pageContext.request.isUserInRole('WRITE_USERS')}">
      <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/AddUser" role="button">Add User</a>
    </c:if>
  </div>

  <!-- Formular cu tabel și checkboxes -->
  <form method="POST" action="${pageContext.request.contextPath}/Users">

    <!-- Buton Invoice -->
    <button type="submit" class="btn btn-success mb-3">Invoice Selected Users</button>

    <c:if test="${not empty users}">
      <div class="table-responsive">
        <table class="table table-striped">
          <thead>
          <tr>
            <th scope="col">
              <input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)">
            </th>
            <th scope="col">Username</th>
            <th scope="col">Email</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="user" items="${users}">
            <tr>
              <td>
                <input type="checkbox" name="user_ids" value="${user.id}">
              </td>
              <td>${user.username}</td>
              <td>${user.email}</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </c:if>
  </form>

  <!-- Afișare utilizatori facturați -->
  <c:if test="${not empty invoices}">
    <hr class="my-4">
    <h5>Users to be invoiced:</h5>
    <div class="alert alert-info">
      <c:forEach var="username" items="${invoices}" varStatus="status">
        ${status.index + 1}. ${username}<br/>
      </c:forEach>
    </div>
  </c:if>

  <!-- Script pentru Select All -->
  <script>
    function toggleSelectAll(checkbox) {
      const checkboxes = document.querySelectorAll('input[name="user_ids"]');
      checkboxes.forEach(cb => cb.checked = checkbox.checked);
    }
  </script>

</t:pageTemplate>
