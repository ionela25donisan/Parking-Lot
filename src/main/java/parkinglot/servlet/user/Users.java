package parkinglot.servlet.user;

import parkinglot.ejb.InvoiceBean;
import parkinglot.ejb.UsersBean;
import jakarta.annotation.security.DeclareRoles;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.HttpMethodConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@WebServlet(name = "Users", value = "/Users")
@DeclareRoles({"READ_USERS", "WRITE_USERS"})
@ServletSecurity(
        value = @HttpConstraint(rolesAllowed = {"READ_USERS"}),
        httpMethodConstraints = {
                @HttpMethodConstraint(value = "POST", rolesAllowed = {"WRITE_USERS"})
        }
)
public class Users extends HttpServlet {

    @Inject
    private UsersBean usersBean;

    @Inject
    private InvoiceBean invoiceBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("users", usersBean.findAllUsers());
        request.setAttribute("activePage", "Users");

        // Obține username-urile utilizatorilor facturați
        request.setAttribute("invoices",
                usersBean.findUsernamesByUserIds(invoiceBean.getUserIds()));

        request.getRequestDispatcher("/WEB-INF/pages/user/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Preia ID-urile utilizatorilor selectați din formular
        String[] userIdsAsString = request.getParameterValues("user_ids");

        if (userIdsAsString != null) {
            // Convertește String[] în Set<Long>
            Set<Long> userIds = Arrays.stream(userIdsAsString)
                    .map(Long::parseLong)
                    .collect(Collectors.toSet());

            // Salvează în InvoiceBean (stare păstrată în sesiune)
            invoiceBean.setUserIds(userIds);
        } else {
            // Dacă nu e nimic selectat, golește lista
            invoiceBean.setUserIds(new HashSet<>());
        }

        // Redirect la pagina Users
        response.sendRedirect(request.getContextPath() + "/Users");
    }
}