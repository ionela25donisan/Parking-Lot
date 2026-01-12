<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:pageTemplate pageTitle="Add Car Photo">

    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Upload Photo for Car: ${car.licensePlate}</h5>

                    <form method="POST"
                          enctype="multipart/form-data"
                          action="${pageContext.request.contextPath}/AddCarPhoto">

                        <input type="hidden" name="car_id" value="${car.id}">

                        <div class="mb-3">
                            <label for="file" class="form-label">Select Photo</label>
                            <input type="file"
                                   class="form-control"
                                   id="file"
                                   name="file"
                                   accept="image/*"
                                   required>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Upload Photo</button>
                            <a href="${pageContext.request.contextPath}/Cars" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</t:pageTemplate>