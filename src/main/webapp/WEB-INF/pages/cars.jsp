<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cars - Parking Lot</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@include file="menu.jsp"%>

<!-- Main content cu padding pentru că navbar e fixed -->
<main style="padding-top: 80px; min-height: calc(100vh - 200px);">
    <div class="container py-4">
        <h1 class="mb-4">Cars Management</h1>

        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">
                    <i class="bi bi-car-front"></i> All Cars
                </h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-striped table-hover mb-0">
                        <thead class="table-light">
                        <tr>
                            <th scope="col">License Plate</th>
                            <th scope="col">Parking Spot</th>
                            <th scope="col">Owner</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="car" items="${cars}">
                            <tr>
                                <td><strong>${car.licensePlate}</strong></td>
                                <td><span class="badge bg-info text-dark">${car.parkingSpot}</span></td>
                                <td>${car.ownerName}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty cars}">
                            <tr>
                                <td colspan="3" class="text-center text-muted py-4">
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
    </div>
</main>

<%@include file="footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>