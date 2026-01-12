<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:pageTemplate pageTitle="parkinglot.servlet.car.Cars">

    <!-- Buton Add Car - doar pentru WRITE_CARS -->
    <c:if test="${pageContext.request.isUserInRole('WRITE_CARS')}">
        <a href="${pageContext.request.contextPath}/AddCar" class="btn btn-primary btn-lg mb-3">Add Car</a>
    </c:if>

    <c:if test="${not empty cars}">
        <form method="POST" action="${pageContext.request.contextPath}/Cars">

            <!-- Buton Delete - doar pentru WRITE_CARS -->
            <c:if test="${pageContext.request.isUserInRole('WRITE_CARS')}">
                <button type="submit" class="btn btn-danger mb-3">Delete Selected parkinglot.servlet.car.Cars</button>
            </c:if>

            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <!-- Checkbox select all - doar pentru WRITE_CARS -->
                        <c:if test="${pageContext.request.isUserInRole('WRITE_CARS')}">
                            <th scope="col">
                                <input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)">
                            </th>
                        </c:if>
                        <th scope="col">License Plate</th>
                        <th scope="col">Parking Spot</th>
                        <th scope="col">Owner</th>
                        <th scope="col">Photo</th>
                        <c:if test="${pageContext.request.isUserInRole('WRITE_CARS')}">
                            <th scope="col">Actions</th>
                        </c:if>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="car" items="${cars}">
                        <tr>
                            <!-- Checkbox - doar pentru WRITE_CARS -->
                            <c:if test="${pageContext.request.isUserInRole('WRITE_CARS')}">
                                <td>
                                    <input type="checkbox" name="car_ids" value="${car.id}">
                                </td>
                            </c:if>

                            <!-- Datele mașinii -->
                            <td>${car.licensePlate}</td>
                            <td>${car.parkingSpot}</td>
                            <td>${car.ownerName}</td>

                            <!-- Coloană Photo -->
                            <td>
                                <img src="${pageContext.request.contextPath}/CarPhotos?id=${car.id}"
                                     width="48"
                                     alt="Car Photo"
                                     class="img-thumbnail">
                            </td>

                            <!-- Butoane Actions - doar pentru WRITE_CARS -->
                            <c:if test="${pageContext.request.isUserInRole('WRITE_CARS')}">
                                <td>
                                    <a class="btn btn-secondary btn-sm"
                                       href="${pageContext.request.contextPath}/EditCar?id=${car.id}">
                                        Edit
                                    </a>
                                    <a class="btn btn-primary btn-sm"
                                       href="${pageContext.request.contextPath}/AddCarPhoto?id=${car.id}">
                                        Add Photo
                                    </a>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </form>
    </c:if>

    <h5>Free parking spots: ${numberOfFreeParkingSpots}</h5>

    <script>
        function toggleSelectAll(checkbox) {
            const checkboxes = document.querySelectorAll('input[name="car_ids"]');
            checkboxes.forEach(cb => cb.checked = checkbox.checked);
        }
    </script>
</t:pageTemplate>