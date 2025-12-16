<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:pageTemplate pageTitle="Users - Parking Lot">
  <div class="container py-4">
    <h1 class="mb-4">Users Management</h1>

    <div class="card shadow">
      <div class="card-header bg-primary text-white">
        <h5 class="mb-0">
          <i class="bi bi-people"></i> All Users
        </h5>
      </div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-striped table-hover mb-0">
            <thead class="table-light">
            <tr>
              <th scope="col">Username</th>
              <th scope="col">Email</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${users}">
              <tr>
                <td><strong>${user.username}</strong></td>
                <td>${user.email}</td>
              </tr>
            </c:forEach>
            <c:if test="${empty users}">
              <tr>
                <td colspan="2" class="text-center text-muted py-4">
                  <i class="bi bi-inbox"></i> No users found
                </td>
              </tr>
            </c:if>
            </tbody>
          </table>
        </div>
      </div>
      <div class="card-footer text-muted">
        Total users: <strong>${users.size()}</strong>
      </div>
    </div>
  </div>
</t:pageTemplate>