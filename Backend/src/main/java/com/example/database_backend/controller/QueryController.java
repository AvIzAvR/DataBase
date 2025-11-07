package com.example.database_backend.controller;

import com.example.database_backend.service.QueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/queries")
@CrossOrigin(origins = "http://localhost:3000")
public class QueryController {

    @Autowired
    private QueryService queryService;

    // Выполнение запроса: клиенты с фамилией, начинающейся на "Ива"
    @GetMapping("/clients_with_last_name_Iva")
    public List<Map<String, Object>> getClientsWithLastNameIva() {
        return queryService.getClientsWithLastNameIva();
    }

    // Выполнение запроса: машины марки "Audi" от 2015 года
    @GetMapping("/cars_audi_after_2015")
    public List<Map<String, Object>> getCarsAudiAfter2015() {
        return queryService.getCarsAudiAfter2015();
    }

    // Выполнение запроса: автосервисы с определенными условиями
    @GetMapping("/stos_working_hours_and_address")
    public List<Map<String, Object>> getStosWorkingHoursAndAddress() {
        return queryService.getStosWorkingHoursAndAddress();
    }

    // Выполнение запроса: сотрудники с высокой зарплатой на улицах "Л"
    @GetMapping("/employees_high_salary_street_L")
    public List<Map<String, Object>> getEmployeesHighSalaryStreetL() {
        return queryService.getEmployeesHighSalaryStreetL();
    }

    // Выполнение запроса: заказы, оплаченные и выполненные, с адресами "ул."
    @GetMapping("/completed_orders_with_street_address")
    public List<Map<String, Object>> getCompletedOrdersWithStreetAddress() {
        return queryService.getCompletedOrdersWithStreetAddress();
    }

    // Выполнение запроса: запчасти в дорогих заказах
    @GetMapping("/spare_parts_in_expensive_orders")
    public List<Map<String, Object>> getSparePartsInExpensiveOrders() {
        return queryService.getSparePartsInExpensiveOrders();
    }

    // Выполнение запроса: сотрудники с низкой зарплатой в дорогих заказах
    @GetMapping("/employees_low_salary_high_order_amount")
    public List<Map<String, Object>> getEmployeesLowSalaryHighOrderAmount() {
        return queryService.getEmployeesLowSalaryHighOrderAmount();
    }

    // Выполнение запроса: заказы с запчастями "Bosch"
    @GetMapping("/orders_with_bosch_parts")
    public List<Map<String, Object>> getOrdersWithBoschParts() {
        return queryService.getOrdersWithBoschParts();
    }

    // Выполнение запроса: автосервисы с высокооплачиваемыми сотрудниками
    @GetMapping("/stos_high_salary_employees_high_order_amount")
    public List<Map<String, Object>> getStosHighSalaryEmployeesHighOrderAmount() {
        return queryService.getStosHighSalaryEmployeesHighOrderAmount();
    }

    // Выполнение запроса: сотрудники в автосервисах с дорогими заказами
    @GetMapping("/employees_in_stos_with_high_order_amount")
    public List<Map<String, Object>> getEmployeesInStosWithHighOrderAmount() {
        return queryService.getEmployeesInStosWithHighOrderAmount();
    }

    // Выполнение запроса: автосервисы с высокооплачиваемыми сотрудниками и дорогими заказами
    @GetMapping("/stos_with_high_salary_employees_and_high_order_amount")
    public List<Map<String, Object>> getStosWithHighSalaryEmployeesAndHighOrderAmount() {
        return queryService.getStosWithHighSalaryEmployeesAndHighOrderAmount();
    }

    // Выполнение запроса: автосервисы с сотрудниками с зарплатой выше 10,000 и дорогими заказами
    @GetMapping("/stos_with_employees_high_salary_and_high_order_amount")
    public List<Map<String, Object>> getStosWithEmployeesHighSalaryAndHighOrderAmount() {
        return queryService.getStosWithEmployeesHighSalaryAndHighOrderAmount();
    }

    // Выполнение запроса: общая сумма выполненных заказов
    @GetMapping("/total_completed_orders_sum")
    public Double getTotalCompletedOrdersSum() {
        return queryService.getTotalCompletedOrdersSum();
    }

    // Выполнение запроса: средняя стоимость услуг по категориям
    @GetMapping("/average_service_cost_by_category")
    public List<Map<String, Object>> getAverageServiceCostByCategory() {
        return queryService.getAverageServiceCostByCategory();
    }

    // Выполнение запроса: количество клиентов, родившихся после 1990 года
    @GetMapping("/young_clients_count")
    public Integer getYoungClientsCount() {
        return queryService.getYoungClientsCount();
    }

    // Выполнение запроса: информация о самом дорогом заказе
    @GetMapping("/most_expensive_order")
    public Map<String, Object> getMostExpensiveOrder() {
        return queryService.getMostExpensiveOrder();
    }

    // Выполнение запроса: количество автомобилей каждой марки
    @GetMapping("/car_count_by_brand")
    public List<Map<String, Object>> getCarCountByBrand() {
        return queryService.getCarCountByBrand();
    }

    // Выполнение запроса: заказы с услугами стоимостью более 5000 рублей
    @GetMapping("/orders_with_expensive_services")
    public List<Map<String, Object>> getOrdersWithExpensiveServices() {
        return queryService.getOrdersWithExpensiveServices();
    }

    // Выполнение запроса: сотрудники с зарплатой выше средней
    @GetMapping("/employees_with_above_average_salary")
    public List<Map<String, Object>> getEmployeesWithAboveAverageSalary() {
        return queryService.getEmployeesWithAboveAverageSalary();
    }

    // Выполнение запроса: запчасти с остатком менее 20 единиц
    @GetMapping("/spare_parts_with_low_stock")
    public List<Map<String, Object>> getSparePartsWithLowStock() {
        return queryService.getSparePartsWithLowStock();
    }

    // Выполнение запроса: ТОП-3 СТО по количеству сотрудников
    @GetMapping("/top3_stos_by_employee_count")
    public List<Map<String, Object>> getTop3StosByEmployeeCount() {
        return queryService.getTop3StosByEmployeeCount();
    }

    // Выполнение запроса: незавершенные заказы
    @GetMapping("/incomplete_orders")
    public List<Map<String, Object>> getIncompleteOrders() {
        return queryService.getIncompleteOrders();
    }

    // Выполнение запроса: ТОП-5 самых востребованных услуг
    @GetMapping("/top5_services")
    public List<Map<String, Object>> getTop5Services() {
        return queryService.getTop5Services();
    }

    // Выполнение запроса: список клиентов с информацией об их автомобилях
    @GetMapping("/clients_with_cars")
    public List<Map<String, Object>> getClientsWithCars() {
        return queryService.getClientsWithCars();
    }

    // Выполнение запроса: общая стоимость всех запчастей на складе
    @GetMapping("/total_inventory_value")
    public Double getTotalInventoryValue() {
        return queryService.getTotalInventoryValue();
    }
    @PostMapping("/executeCustom")
    public List<Map<String, Object>> executeCustomQuery(@RequestParam String query) {
        return queryService.executeCustomQuery(query);
    }

    // Сохранение пользовательского запроса
    @PostMapping("/saveCustom")
    public String saveCustomQuery(@RequestParam String queryName, @RequestParam String query) {
        queryService.saveCustomQuery(queryName, query);
        return "Custom query saved successfully!";
    }

    // Получение сохраненного пользовательского запроса
    @GetMapping("/getCustom")
    public String getSavedCustomQuery(@RequestParam String queryName) {
        return queryService.getSavedCustomQuery(queryName);
    }

}
