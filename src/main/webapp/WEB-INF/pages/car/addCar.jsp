<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:pageTemplate pageTitle="Add Car">

    <!-- Mesaj de eroare din backend -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>Error!</strong> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form class="needs-validation" novalidate method="POST"
          action="${pageContext.request.contextPath}/AddCar">

        <div class="row g-3">

            <!-- License Plate -->
            <div class="col-md-12">
                <label for="license_plate" class="form-label">License Plate</label>
                <input type="text"
                       class="form-control"
                       id="license_plate"
                       name="license_plate"
                       placeholder="e.g., PR01ABC or pr01abc"
                       required
                       minlength="2"
                       maxlength="20"
                       value="${param.license_plate}">
                <div class="invalid-feedback">
                    License plate is required (2-20 characters, letters and numbers only).
                </div>
            </div>
        </div>

        <!-- Parking Spot -->
        <div class="col-md-12">
            <label for="parking_spot" class="form-label">Parking Spot</label>
            <input type="text"
                   class="form-control"
                   id="parking_spot"
                   name="parking_spot"
                   placeholder="e.g., A1, B5, C12"
                   required
                   maxlength="10"
                   value="${param.parking_spot}">
            <div class="invalid-feedback">
                Parking spot is required (max 10 characters).
            </div>
        </div>

        <!-- Owner -->
        <div class="col-md-12">
            <label for="owner_id" class="form-label">Owner</label>
            <select class="form-select" id="owner_id" name="owner_id" required>
                <option value="">Choose...</option>
                <c:forEach var="user" items="${users}">
                    <option value="${user.id}"
                        ${param.owner_id == user.id ? 'selected' : ''}>
                            ${user.username}
                    </option>
                </c:forEach>
            </select>
            <div class="invalid-feedback">
                Please select an owner.
            </div>
        </div>

        </div>

        <hr class="my-4">

        <div class="d-grid gap-2 d-md-flex justify-content-md-start">
            <button class="btn btn-primary btn-lg" type="submit">
                Save Car
            </button>
            <a href="${pageContext.request.contextPath}/Cars" class="btn btn-secondary btn-lg">
                Cancel
            </a>
        </div>

    </form>

    <script>
        // Convertește automat la uppercase când utilizatorul tastează
        document.getElementById('license_plate').addEventListener('input', function(e) {
            e.target.value = e.target.value.toUpperCase();
        });
    </script>

</t:pageTemplate>