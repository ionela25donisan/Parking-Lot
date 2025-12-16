<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:pageTemplate pageTitle="Edit Car - Parking Lot">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h1 class="mb-4">Edit Car</h1>

                <div class="card shadow">
                    <div class="card-body">
                        <form method="POST" action="${pageContext.request.contextPath}/EditCar" class="needs-validation" novalidate>

                            <!-- Hidden input pentru ID-ul mașinii -->
                            <input type="hidden" name="car_id" value="${car.id}">

                            <div class="mb-3">
                                <label for="license_plate" class="form-label">License Plate</label>
                                <input type="text" class="form-control" id="license_plate" name="license_plate" value="${car.licensePlate}" required>
                                <div class="invalid-feedback">Please provide a license plate.</div>
                            </div>

                            <div class="mb-3">
                                <label for="parking_spot" class="form-label">Parking Spot</label>
                                <input type="text" class="form-control" id="parking_spot" name="parking_spot" value="${car.parkingSpot}" required>
                                <div class="invalid-feedback">Please provide a parking spot.</div>
                            </div>

                            <div class="mb-3">
                                <label for="owner_id" class="form-label">Owner</label>
                                <select class="form-select" id="owner_id" name="owner_id" required>
                                    <option value="">Choose...</option>
                                    <c:forEach var="user" items="${users}">
                                        <option value="${user.id}" ${user.id == car.ownerId ? 'selected' : ''}>
                                                ${user.username}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">Please select an owner.</div>
                            </div>

                            <hr class="my-4">

                            <button type="submit" class="btn btn-primary btn-lg w-100">Update</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</t:pageTemplate>