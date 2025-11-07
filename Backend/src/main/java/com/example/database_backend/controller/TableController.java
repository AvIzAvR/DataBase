package com.example.database_backend.controller;

import com.example.database_backend.service.TableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/tables")
@CrossOrigin(origins = "http://localhost:3000")
public class TableController {

    @Autowired
    private TableService tableService;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // Вспомогательный метод для проверки прав суперпользователя
    private boolean checkSuperuserPassword(String password) {
        return tableService.validateSuperuserPassword(password);
    }

    @PostMapping("/create")
    public ResponseEntity<String> createTable(
            @RequestParam String tableName,
            @RequestParam String columns,
            @RequestParam(required = false) String superuserPassword) {

        boolean isSuperuser = superuserPassword != null && checkSuperuserPassword(superuserPassword);

        try {
            tableService.createTable(tableName, columns, isSuperuser);
            return ResponseEntity.ok("Table created successfully!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateTable(
            @RequestParam String tableName,
            @RequestParam String columnName,
            @RequestParam String newValue,
            @RequestParam String condition,
            @RequestParam(required = false) String superuserPassword) {

        boolean isSuperuser = superuserPassword != null && checkSuperuserPassword(superuserPassword);

        try {
            tableService.updateTable(tableName, columnName, newValue, condition, isSuperuser);
            return ResponseEntity.ok("Update successful!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @PostMapping("/insert")
    public ResponseEntity<String> insertRow(
            @RequestParam String tableName,
            @RequestBody Map<String, Object> columnValues,
            @RequestParam(required = false) String superuserPassword) {

        boolean isSuperuser = superuserPassword != null && checkSuperuserPassword(superuserPassword);

        try {
            tableService.insertRow(tableName, columnValues, isSuperuser);
            return ResponseEntity.ok("Insert successful!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    // Удаление таблицы
    @DeleteMapping("/drop")
    public ResponseEntity<String> dropTable(
            @RequestParam String tableName,
            @RequestParam(required = false) String superuserPassword) {

        boolean isSuperuser = superuserPassword != null && checkSuperuserPassword(superuserPassword);

        try {
            tableService.dropTable(tableName, isSuperuser);
            return ResponseEntity.ok("Table dropped successfully!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    // Добавление нового поля в таблицу
    @PostMapping("/addColumn")
    public ResponseEntity<String> addColumn(
            @RequestParam String tableName,
            @RequestParam String columnName,
            @RequestParam String columnType,
            @RequestParam(required = false) String superuserPassword) {

        boolean isSuperuser = superuserPassword != null && checkSuperuserPassword(superuserPassword);

        try {
            tableService.addColumn(tableName, columnName, columnType, isSuperuser);
            return ResponseEntity.ok("Column added successfully!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    // Удаление поля из таблицы
    @DeleteMapping("/dropColumn")
    public ResponseEntity<String> dropColumn(
            @RequestParam String tableName,
            @RequestParam String columnName,
            @RequestParam(required = false) String superuserPassword) {

        boolean isSuperuser = superuserPassword != null && checkSuperuserPassword(superuserPassword);

        try {
            tableService.dropColumn(tableName, columnName, isSuperuser);
            return ResponseEntity.ok("Column dropped successfully!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    // Экспорт данных в Excel (доступно всем)
    @GetMapping("/export")
    public ResponseEntity<String> exportToExcel(
            @RequestParam String tableName,
            @RequestParam String filename) {

        try {
            tableService.exportToExcel(tableName, filename);
            return ResponseEntity.ok("Export successful!");
        } catch (IOException e) {
            return ResponseEntity.badRequest().body("Error during export: " + e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/backup")
    public ResponseEntity<String> backupTableToSql(
            @RequestParam String tableName,
            @RequestParam String filename,
            @RequestParam(required = false) String superuserPassword) {

        boolean isSuperuser = superuserPassword != null && checkSuperuserPassword(superuserPassword);

        try {
            tableService.backupTableToSql(tableName, filename, isSuperuser);
            return ResponseEntity.ok("Backup successful!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (IOException e) {
            return ResponseEntity.badRequest().body("Error during backup: " + e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/fullBackup")
    public ResponseEntity<String> fullBackupDatabase(
            @RequestParam String filename,
            @RequestParam String superuserPassword) {

        boolean isSuperuser = checkSuperuserPassword(superuserPassword);

        if (!isSuperuser) {
            return ResponseEntity.status(403).body("Требуются права суперпользователя");
        }

        try {
            tableService.fullBackupDatabase(filename, true);
            return ResponseEntity.ok("Full backup successful!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (IOException e) {
            return ResponseEntity.badRequest().body("Error during full backup: " + e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @PostMapping("/loadBackup")
    public ResponseEntity<String> loadBackup(
            @RequestParam("file") MultipartFile file,
            @RequestParam String superuserPassword) {

        boolean isSuperuser = checkSuperuserPassword(superuserPassword);

        if (!isSuperuser) {
            return ResponseEntity.status(403).body("Требуются права суперпользователя");
        }

        try {
            // Сохраняем файл во временное место
            File tempFile = File.createTempFile("backup", ".sql");
            file.transferTo(tempFile);

            // Выполняем SQL-файл
            tableService.loadBackup(tempFile.getAbsolutePath(), true);

            // Удаляем временный файл
            tempFile.delete();

            return ResponseEntity.ok("Backup loaded successfully!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (IOException e) {
            return ResponseEntity.badRequest().body("Error during backup load: " + e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/getAllTables")
    public ResponseEntity<List<String>> getAllTables() {
        try {
            List<String> tables = tableService.getAllTables();
            return ResponseEntity.ok(tables);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    @DeleteMapping("/deleteRow")
    public ResponseEntity<String> deleteRow(
            @RequestParam String tableName,
            @RequestParam int id,
            @RequestParam(required = false) String superuserPassword) {

        boolean isSuperuser = superuserPassword != null && checkSuperuserPassword(superuserPassword);

        try {
            tableService.deleteRowAndShiftIds(tableName, id, isSuperuser);
            return ResponseEntity.ok("Row deleted and IDs shifted successfully!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @PatchMapping("/updateRow")
    public ResponseEntity<String> updateRow(
            @RequestParam String tableName,
            @RequestParam int id,
            @RequestBody Map<String, Object> updates,
            @RequestParam(required = false) String superuserPassword) {

        boolean isSuperuser = superuserPassword != null && checkSuperuserPassword(superuserPassword);

        try {
            tableService.updateRow(tableName, id, updates, isSuperuser);
            return ResponseEntity.ok("Row updated successfully!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/{tableName}")
    public ResponseEntity<List<Map<String, Object>>> getTableData(@PathVariable String tableName) {
        try {
            List<Map<String, Object>> data = tableService.getTableData(tableName);
            return ResponseEntity.ok(data);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    @GetMapping("/{tableName}/{id}")
    public ResponseEntity<Map<String, Object>> getRow(
            @PathVariable String tableName,
            @PathVariable int id) {

        try {
            Map<String, Object> row = tableService.getRow(tableName, id);
            return ResponseEntity.ok(row);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    // Методы для работы со справочными таблицами (только для суперпользователя)
    @PostMapping("/ref/add")
    public ResponseEntity<String> addTableToRef(
            @RequestParam String tableName,
            @RequestParam boolean isReference,
            @RequestParam String superuserPassword) {

        boolean isSuperuser = checkSuperuserPassword(superuserPassword);

        if (!isSuperuser) {
            return ResponseEntity.status(403).body("Требуются права суперпользователя");
        }

        try {
            tableService.addTableToRef(tableName, isReference, true);
            return ResponseEntity.ok("Table added to reference list successfully!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @DeleteMapping("/ref/remove")
    public ResponseEntity<String> removeTableFromRef(
            @RequestParam String tableName,
            @RequestParam String superuserPassword) {

        boolean isSuperuser = checkSuperuserPassword(superuserPassword);

        if (!isSuperuser) {
            return ResponseEntity.status(403).body("Требуются права суперпользователя");
        }

        try {
            tableService.removeTableFromRef(tableName, true);
            return ResponseEntity.ok("Table removed from reference list successfully!");
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/ref/list")
    public ResponseEntity<List<Map<String, Object>>> getRefTables(
            @RequestParam(required = false) String superuserPassword) {

        // Для просмотра списка справочных таблиц требуются права суперпользователя
        boolean isSuperuser = superuserPassword != null && checkSuperuserPassword(superuserPassword);

        if (!isSuperuser) {
            return ResponseEntity.status(403).body(null);
        }

        try {
            List<Map<String, Object>> refTables = tableService.getRefTables();
            return ResponseEntity.ok(refTables);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    @GetMapping("/ref/check")
    public ResponseEntity<Boolean> isTableReference(
            @RequestParam String tableName)
            {

        try {
            boolean isReference = tableService.isTableReference(tableName);
            return ResponseEntity.ok(isReference);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    // Метод для проверки пароля суперпользователя
    @PostMapping("/auth/superuser")
    public ResponseEntity<Boolean> validateSuperuserPassword(@RequestParam String password) {
        try {
            boolean isValid = tableService.validateSuperuserPassword(password);
            return ResponseEntity.ok(isValid);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(false);
        }
    }
}