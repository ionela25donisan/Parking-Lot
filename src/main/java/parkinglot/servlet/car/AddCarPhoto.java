package parkinglot.servlet.car;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import parkinglot.common.CarDto;
import parkinglot.ejb.CarsBean;

import java.io.IOException;
import java.io.InputStream;

@WebServlet(name = "AddCarPhoto", value = "/AddCarPhoto")
@MultipartConfig
public class AddCarPhoto extends HttpServlet {

    @Inject
    private CarsBean carsBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long carId = Long.parseLong(request.getParameter("id"));
        CarDto car = carsBean.findById(carId);

        request.setAttribute("car", car);
        request.getRequestDispatcher("/WEB-INF/pages/car/addCarPhoto.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long carId = Long.parseLong(request.getParameter("car_id"));

        Part filePart = request.getPart("file");
        String filename = filePart.getSubmittedFileName();
        String fileType = filePart.getContentType();

        // Citește conținutul fișierului (compatibil cu Java 8+)
        InputStream inputStream = filePart.getInputStream();
        byte[] fileContent = new byte[(int) filePart.getSize()];
        inputStream.read(fileContent);
        inputStream.close();

        carsBean.addPhotoToCar(carId, filename, fileType, fileContent);

        response.sendRedirect(request.getContextPath() + "/Cars");
    }
}