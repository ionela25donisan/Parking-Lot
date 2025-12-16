<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:pageTemplate pageTitle="Cars - Parking Lot">
    <div class="container py-4">
        <h1 class="mb-4">Cars Management</h1>

        <!-- Butonul Add Car -->
        <div class="mb-3">
            <a href="${pageContext.request.contextPath}/AddCar" class="btn btn-primary btn-lg">
                <i class="bi bi-plus-circle"></i> Add Car
            </a>
        </div>

        <!-- Form pentru delete (înconjoară tabelul) -->
        <form method="POST" action="${pageContext.request.contextPath}/Cars">
            <div class="card shadow">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">
                        <i class="bi bi-car-front"></i> All Cars
                    </h5>
                    <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete the selected cars?');">
                        <i class="bi bi-trash"></i> Delete Selected
                    </button>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover mb-0">
                            <thead class="table-light">
                            <tr>
                                <th scope="col" style="width: 50px;">
                                    <input type="checkbox" class="form-check-input" id="selectAll">
                                </th>
                                <th scope="col">License Plate</th>
                                <th scope="col">Parking Spot</th>
                                <th scope="col">Owner</th>
                                <th scope="col" style="width: 120px;">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="car" items="${cars}">
                                <tr>
                                    <td>
                                        <input type="checkbox" class="form-check-input car-checkbox" name="car_ids" value="${car.id}">
                                    </td>
                                    <td><strong>${car.licensePlate}</strong></td>
                                    <td><span class="badge bg-info text-dark">${car.parkingSpot}</span></td>
                                    <td>${car.ownerName}</td>
                                    <td>
                                        <a class="btn btn-secondary btn-sm" href="${pageContext.request.contextPath}/EditCar?id=${car.id}">
                                            <i class="bi bi-pencil"></i> Edit
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty cars}">
                                <tr>
                                    <td colspan="5" class="text-center text-muted py-4">
                                        <i class="bi bi-inbox"></i> No cars found
                                    </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer text-muted">
                    Total cars: <strong>${cars.size()}</strong>
                </div>
            </div>
        </form>
    </div>

    <script>
        // Script pentru "Select All" checkbox
        document.getElementById('selectAll').addEventListener('change', function() {
            const checkboxes = document.querySelectorAll('.car-checkbox');
            checkboxes.forEach(checkbox => checkbox.checked = this.checked);
        });
    </script>
</t:pageTemplate>