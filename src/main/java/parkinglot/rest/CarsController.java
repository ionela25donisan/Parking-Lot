
package parkinglot.rest;

import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import parkinglot.common.CarDto;
import parkinglot.ejb.CarsBean;

import java.util.List;

@Path("/cars")
@RolesAllowed("READ_CARS")
public class CarsController {

    @Inject
    private CarsBean carsBean;

    /**
     * GET all cars
     * URL: /resources/cars
     * Returns: JSON array of all cars
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<CarDto> findAllCars() {
        return carsBean.findAllCars();
    }

    /**
     * GET single car by ID
     * URL: /resources/cars/{id}
     * Example: /resources/cars/1
     * Returns: JSON object of the car
     */
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public CarDto findCar(@PathParam("id") Long id) {
        return carsBean.findById(id);
    }
}
