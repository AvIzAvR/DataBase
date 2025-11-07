package com.example.database_backend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class QueryService {

    @Autowired
    private JdbcTemplate jdbcTemplate;


    public List<Map<String, Object>> executeQuery(String query) {
        return jdbcTemplate.queryForList(query);
    }


    public List<Map<String, Object>> getClientsWithLastNameIva() {
        String query = "SELECT last_name, birth_date FROM client WHERE last_name LIKE '%Ива%'";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getCarsAudiAfter2015() {
        String query = "SELECT brand, model, manufacture_year FROM car WHERE manufacture_year > 2015 AND brand = 'Audi'";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getStosWorkingHoursAndAddress() {
        String query = "SELECT name, address, phone, email, working_hours FROM sto WHERE working_hours LIKE '08:00-20:00' AND address LIKE 'ул. Л%' AND phone LIKE '+79161%'";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getEmployeesHighSalaryStreetL() {
        String query = "SELECT e.first_name, e.last_name, e.position, e.salary, a.name AS sto_name, a.address FROM employee e JOIN sto a ON e.sto_id = a.id WHERE a.address LIKE 'ул. Л%' AND e.salary > 50000 ORDER BY e.last_name";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getCompletedOrdersWithStreetAddress() {
        String query = "SELECT o.id, c.first_name, c.last_name, o.total_amount, o.order_datetime FROM ordertable o JOIN client c ON o.client_id = c.id JOIN car car ON o.car_id = car.id JOIN sto sto ON car.id = sto.id WHERE sto.address LIKE '%ул.%' AND o.status = 'Выполнено' ORDER BY o.order_datetime";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getSparePartsInExpensiveOrders() {
        String query = "SELECT DISTINCT sp.name, sp.manufacturer, sp.price FROM sparepart sp JOIN ordertable o ON sp.id = o.car_id WHERE o.total_amount > 10000 AND sp.stock_quantity < 10";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getEmployeesLowSalaryHighOrderAmount() {
        String query = "SELECT e.first_name, e.last_name, e.position, e.salary FROM employee e JOIN (SELECT DISTINCT car_id AS sto_id FROM ordertable WHERE total_amount > 5000) o ON e.sto_id = o.sto_id WHERE e.salary < (SELECT AVG(salary) FROM employee) ORDER BY e.salary DESC";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getOrdersWithBoschParts() {
        String query = "SELECT o.id, sp.name, o.total_amount FROM ordertable o JOIN sparepart sp ON o.car_id = sp.id WHERE sp.manufacturer = 'Bosch' AND o.status = 'Выполнено' ORDER BY o.total_amount DESC";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getStosHighSalaryEmployeesHighOrderAmount() {
        String query = "SELECT a.name, a.address, COUNT(e.id) AS high_salary_employees FROM sto a JOIN employee e ON a.id = e.sto_id JOIN ordertable o ON a.id = o.car_id WHERE e.salary > (SELECT AVG(salary) FROM employee) AND o.total_amount > 10000 GROUP BY a.id ORDER BY high_salary_employees DESC";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getEmployeesInStosWithHighOrderAmount() {
        String query = "SELECT e.first_name, e.last_name, e.position, e.salary, a.name AS sto_name FROM employee e JOIN sto a ON e.sto_id = a.id WHERE a.id IN (SELECT DISTINCT car_id FROM ordertable WHERE total_amount > 5000) ORDER BY e.salary DESC";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getStosWithHighSalaryEmployeesAndHighOrderAmount() {
        String query = "SELECT a.name, a.address, COUNT(e.id) AS high_salary_employees FROM sto a JOIN employee e ON a.id = e.sto_id JOIN ordertable o ON a.id = o.car_id WHERE e.salary > 55000 AND o.total_amount > 10000 GROUP BY a.id ORDER BY high_salary_employees DESC";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getStosWithEmployeesHighSalaryAndHighOrderAmount() {
        String query = "SELECT a.name, a.address, COUNT(e.id) AS high_salary_employees FROM sto a JOIN employee e ON a.id = e.sto_id JOIN ordertable o ON a.id = o.car_id WHERE e.salary > 10000 AND o.total_amount > 15000 GROUP BY a.id ORDER BY high_salary_employees DESC";
        return executeQuery(query);
    }


    public Double getTotalCompletedOrdersSum() {
        String query = "SELECT SUM(total_amount) AS total_completed_orders_sum FROM ordertable WHERE status = 'Выполнено'";
        return jdbcTemplate.queryForObject(query, Double.class);
    }


    public List<Map<String, Object>> getAverageServiceCostByCategory() {
        String query = "SELECT category, AVG(cost) AS avg_service_cost FROM service GROUP BY category ORDER BY avg_service_cost DESC";
        return executeQuery(query);
    }


    public Integer getYoungClientsCount() {
        String query = "SELECT COUNT(*) AS young_clients_count FROM client WHERE birth_date > '1990-12-31'";
        return jdbcTemplate.queryForObject(query, Integer.class);
    }


    public Map<String, Object> getMostExpensiveOrder() {
        String query = "SELECT o.id, o.total_amount, c.first_name, c.last_name FROM ordertable o JOIN client c ON o.client_id = c.id ORDER BY o.total_amount DESC LIMIT 1";
        return jdbcTemplate.queryForMap(query);
    }


    public List<Map<String, Object>> getCarCountByBrand() {
        String query = "SELECT brand, COUNT(*) AS cars_count FROM car GROUP BY brand ORDER BY cars_count DESC";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getOrdersWithExpensiveServices() {
        String query = "SELECT o.id, s.name, s.cost FROM ordertable o JOIN carservice cs ON o.car_id = cs.car_id JOIN service s ON cs.service_id = s.id WHERE s.cost > 5000";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getEmployeesWithAboveAverageSalary() {
        String query = "SELECT first_name, last_name, position, salary FROM employee WHERE salary > (SELECT AVG(salary) FROM employee) ORDER BY salary DESC";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getSparePartsWithLowStock() {
        String query = "SELECT name, manufacturer, stock_quantity FROM sparepart WHERE stock_quantity < 20 ORDER BY stock_quantity";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getTop3StosByEmployeeCount() {
        String query = "SELECT s.name, COUNT(e.id) AS employees_count FROM sto s JOIN employee e ON s.id = e.sto_id GROUP BY s.name ORDER BY employees_count DESC LIMIT 3";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getIncompleteOrders() {
        String query = "SELECT o.id, c.brand, c.model, o.total_amount, o.order_datetime FROM ordertable o JOIN car c ON o.car_id = c.id WHERE o.status = 'В процессе' ORDER BY o.order_datetime";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getTop5Services() {
        String query = "SELECT s.name, COUNT(cs.id) AS service_count FROM service s JOIN carservice cs ON s.id = cs.service_id GROUP BY s.name ORDER BY service_count DESC LIMIT 5";
        return executeQuery(query);
    }


    public List<Map<String, Object>> getClientsWithCars() {
        String query = "SELECT c.first_name, c.last_name, car.brand, car.model, car.license_plate FROM client c JOIN ordertable o ON c.id = o.client_id JOIN car ON o.car_id = car.id GROUP BY c.id, car.id";
        return executeQuery(query);
    }


    public Double getTotalInventoryValue() {
        String query = "SELECT SUM(price * stock_quantity) AS total_inventory_value FROM sparepart";
        return jdbcTemplate.queryForObject(query, Double.class);
    }

    public List<Map<String, Object>> executeCustomQuery(String query) {
        return jdbcTemplate.queryForList(query);
    }


    public void saveCustomQuery(String queryName, String query) {
        String sql = "INSERT INTO saved_queries (name, query) VALUES (?, ?)";
        jdbcTemplate.update(sql, queryName, query);
    }


    public String getSavedCustomQuery(String queryName) {
        String sql = "SELECT query FROM saved_queries WHERE name = ?";
        return jdbcTemplate.queryForObject(sql, String.class, queryName);
    }
}
