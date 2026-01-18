
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header data-bs-theme="blue">
    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}">Parking Lot</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
                    aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav me-auto mb-2 mb-md-0">

                    <!-- CARS - doar dacă ai READ_CARS -->
                    <c:if test="${pageContext.request.isUserInRole('READ_CARS')}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/Cars">parkinglot.servlet.car.Cars</a>
                        </li>
                    </c:if>

                    <!-- USERS - doar dacă ai READ_USERS -->
                    <c:if test="${pageContext.request.isUserInRole('READ_USERS')}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/Users">Users</a>
                        </li>
                    </c:if>

                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <c:choose>
                            <c:when test="${pageContext.request.getRemoteUser() == null}">
                                <a class="nav-link" href="${pageContext.request.contextPath}/Login">Login</a>
                            </c:when>
                            <c:otherwise>
                                <a class="nav-link" href="${pageContext.request.contextPath}/Logout">
                                    Logout (${pageContext.request.remoteUser})
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>
