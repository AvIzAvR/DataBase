package com.example.database_backend.service;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import jakarta.annotation.PostConstruct;

@Service
public class TableService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static final String SUPERUSER_PASSWORD = "123";
    private static final String REF_TABLE_NAME = "ref_table";

    // Инициализация при старте приложения
    @PostConstruct
    public void init() {
        createRefTableIfNotExists();
    }

    // Создание таблицы ref_table если она не существует
    private void createRefTableIfNotExists() {
        String checkTableSql = "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = ?)";
        Boolean tableExists = jdbcTemplate.queryForObject(checkTableSql, Boolean.class, REF_TABLE_NAME);

        if (tableExists == null || !tableExists) {
            String createTableSql = "CREATE TABLE " + REF_TABLE_NAME + " (" +
                    "id SERIAL PRIMARY KEY, " +
                    "table_name VARCHAR(255) NOT NULL UNIQUE, " +
                    "is_reference BOOLEAN DEFAULT FALSE)";
            jdbcTemplate.execute(createTableSql);

            // Добавляем пример строки
            String insertExampleSql = "INSERT INTO " + REF_TABLE_NAME + " (table_name, is_reference) VALUES (?, ?)";
            jdbcTemplate.update(insertExampleSql, "ref_table", true);
        }
    }

    // Проверка пароля суперпользователя
    public boolean validateSuperuserPassword(String password) {
        return SUPERUSER_PASSWORD.equals(password);
    }

    // Проверка, является ли таблица справочной
    private boolean isReferenceTable(String tableName) {
        String sql = "SELECT is_reference FROM " + REF_TABLE_NAME + " WHERE table_name = ?";
        try {
            Boolean isReference = jdbcTemplate.queryForObject(sql, Boolean.class, tableName);
            return isReference != null && isReference;
        } catch (Exception e) {
            return false;
        }
    }

    // Проверка прав пользователя для операции
    private void checkUserPermissions(String tableName, String operation, boolean isSuperuser) {
        if (isReferenceTable(tableName) && !isSuperuser) {
            throw new SecurityException("У вас нет прав для " + operation + " справочной таблицы: " + tableName);
        }
    }

    // Метод для создания новой таблицы
    public void createTable(String tableName, String columns, boolean isSuperuser) {
        checkUserPermissions(tableName, "создания", isSuperuser);
        String sql = "CREATE TABLE " + tableName + " (" + columns + ")";
        jdbcTemplate.execute(sql);
    }

    // Метод для удаления таблицы
// Метод для удаления таблицы
    public void dropTable(String tableName, boolean isSuperuser) {
        checkUserPermissions(tableName, "удаления", isSuperuser);
        String sql = "DROP TABLE IF EXISTS " + tableName + " CASCADE";
        jdbcTemplate.execute(sql);

        // Удаляем запись о таблице из ref_table если она там есть
        // Эта операция не должна проверять права, так как это внутреннее обслуживание
        try {
            String deleteRefSql = "DELETE FROM " + REF_TABLE_NAME + " WHERE table_name = ?";
            jdbcTemplate.update(deleteRefSql, tableName);
        } catch (Exception e) {
            // Игнорируем ошибки при удалении из ref_table, так как это не критично
            System.err.println("Warning: Could not remove table from ref_table: " + e.getMessage());
        }
    }

    // Метод для добавления нового поля в таблицу
    public void addColumn(String tableName, String columnName, String columnType, boolean isSuperuser) {
        checkUserPermissions(tableName, "изменения", isSuperuser);
        String sql = "ALTER TABLE " + tableName + " ADD COLUMN " + columnName + " " + columnType;
        jdbcTemplate.execute(sql);
    }

    // Метод для удаления поля из таблицы
    public void dropColumn(String tableName, String columnName, boolean isSuperuser) {
        checkUserPermissions(tableName, "изменения", isSuperuser);
        String sql = "ALTER TABLE " + tableName + " DROP COLUMN " + columnName;
        jdbcTemplate.execute(sql);
    }

    // Метод для экспорта данных в Excel
    public void exportToExcel(String tableName, String filename) throws IOException {
        // Просмотр разрешен всем пользователям
        String sql = "SELECT * FROM " + tableName;
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet(tableName);

        // Создание заголовков
        if (!rows.isEmpty()) {
            Row headerRow = sheet.createRow(0);
            int cellNum = 0;
            for (String columnName : rows.get(0).keySet()) {
                headerRow.createCell(cellNum++).setCellValue(columnName);
            }

            // Заполнение данных
            int rowNum = 1;
            for (Map<String, Object> rowData : rows) {
                Row row = sheet.createRow(rowNum++);
                cellNum = 0;
                for (Object value : rowData.values()) {
                    row.createCell(cellNum++).setCellValue(value.toString());
                }
            }
        }

        try (FileOutputStream fileOut = new FileOutputStream(filename)) {
            workbook.write(fileOut);
        }
    }

    // Метод для создания резервной копии таблицы
    public void backupTable(String tableName, String backupTableName, boolean isSuperuser) {
        checkUserPermissions(tableName, "резервного копирования", isSuperuser);
        String sql = "CREATE TABLE " + backupTableName + " AS SELECT * FROM " + tableName;
        jdbcTemplate.execute(sql);
    }

    // Метод для создания резервной копии всей базы данных
    public void backupDatabase(String filename, boolean isSuperuser) throws IOException {
        if (!isSuperuser) {
            throw new SecurityException("Только суперпользователь может создавать резервные копии всей базы данных");
        }

        List<String> tableNames = jdbcTemplate.queryForList("SHOW TABLES", String.class);

        Workbook workbook = new XSSFWorkbook();

        for (String tableName : tableNames) {
            String sql = "SELECT * FROM " + tableName;
            List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);

            Sheet sheet = workbook.createSheet(tableName);

            // Создание заголовков
            if (!rows.isEmpty()) {
                Row headerRow = sheet.createRow(0);
                int cellNum = 0;
                for (String columnName : rows.get(0).keySet()) {
                    headerRow.createCell(cellNum++).setCellValue(columnName);
                }

                // Заполнение данных
                int rowNum = 1;
                for (Map<String, Object> rowData : rows) {
                    Row row = sheet.createRow(rowNum++);
                    cellNum = 0;
                    for (Object value : rowData.values()) {
                        row.createCell(cellNum++).setCellValue(value.toString());
                    }
                }
            }
        }

        try (FileOutputStream fileOut = new FileOutputStream(filename)) {
            workbook.write(fileOut);
        }
    }

    public void backupTableToSql(String tableName, String filename, boolean isSuperuser) throws IOException {
        checkUserPermissions(tableName, "резервного копирования", isSuperuser);
        String sql = "SELECT * FROM " + tableName;
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);

        try (FileWriter fileWriter = new FileWriter(filename)) {
            // Записываем SQL-скрипт для создания таблицы
            fileWriter.write("DROP TABLE IF EXISTS `" + tableName + "` CASCADE;\n");
            fileWriter.write("CREATE TABLE `" + tableName + "` (\n");

            // Получаем метаданные таблицы
            List<Map<String, Object>> columns = jdbcTemplate.queryForList(
                    "SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ?",
                    tableName);

            for (Map<String, Object> column : columns) {
                String columnName = (String) column.get("COLUMN_NAME");
                String columnType = (String) column.get("DATA_TYPE");
                fileWriter.write("    `" + columnName + "` " + columnType + ",\n");
            }
            fileWriter.write("    PRIMARY KEY (`id`)\n");
            fileWriter.write(");\n\n");

            // Записываем SQL-скрипт для вставки данных
            for (Map<String, Object> row : rows) {
                fileWriter.write("INSERT INTO `" + tableName + "` VALUES (");
                for (Object value : row.values()) {
                    if (value instanceof String) {
                        fileWriter.write("'" + value + "', ");
                    } else {
                        fileWriter.write(value + ", ");
                    }
                }
                fileWriter.write(");\n");
            }
        }
    }

    public void updateTable(String tableName, String columnName, String newValue, String condition, boolean isSuperuser) {
        checkUserPermissions(tableName, "редактирования", isSuperuser);

        // Узнаём тип столбца из БД
        String columnType = jdbcTemplate.queryForObject(
                "SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS " +
                        "WHERE TABLE_NAME = ? AND COLUMN_NAME = ?",
                String.class,
                tableName,
                columnName
        );

        Object value;
        if (columnType.equalsIgnoreCase("int") || columnType.equalsIgnoreCase("integer")) {
            try {
                value = Integer.parseInt(newValue);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Column '" + columnName + "' requires a number!");
            }
        } else {
            value = newValue; // Для строковых типов
        }

        String sql = String.format("UPDATE %s SET %s = ? WHERE %s", tableName, columnName, condition);
        jdbcTemplate.update(sql, value);
    }

    public void insertRow(String tableName, Map<String, Object> columnValues, boolean isSuperuser) {
        checkUserPermissions(tableName, "добавления данных", isSuperuser);

        if (!columnValues.containsKey("id")) {
            Integer maxId = jdbcTemplate.queryForObject("SELECT MAX(id) FROM " + tableName, Integer.class);
            int newId = (maxId != null) ? maxId + 1 : 1;
            columnValues.put("id", newId);
        }

        StringBuilder sql = new StringBuilder("INSERT INTO ").append(tableName).append(" (");
        StringBuilder values = new StringBuilder(" VALUES (");

        columnValues.forEach((column, value) -> {
            sql.append(column).append(", ");
            values.append("?, ");
        });

        sql.setLength(sql.length() - 2);
        values.setLength(values.length() - 2);
        values.append(")");

        sql.append(") ").append(values.toString());

        jdbcTemplate.update(sql.toString(), columnValues.values().toArray());
    }

    public void fullBackupDatabase(String filename, boolean isSuperuser) throws IOException {
        if (!isSuperuser) {
            throw new SecurityException("Только суперпользователь может создавать полные резервные копии базы данных");
        }

        try (FileWriter writer = new FileWriter(filename)) {
            // 1. Получаем все таблицы в правильном порядке (с учетом зависимостей)
            List<String> tables = getTablesInDependencyOrder();

            // 2. Начало транзакции
            writer.write("BEGIN;\n\n");

            // 3. Удаление всех таблиц (в обратном порядке)
            writer.write("-- Удаление существующих таблиц\n");
            for (int i = tables.size() - 1; i >= 0; i--) {
                writer.write(String.format("DROP TABLE IF EXISTS \"%s\" CASCADE;\n", tables.get(i)));
            }
            writer.write("\n");

            // 4. Создание структуры таблиц
            writer.write("-- Создание структуры таблиц\n");
            for (String table : tables) {
                writer.write(getTableCreationDDL(table) + "\n\n");
            }

            // 5. Вставка данных
            writer.write("-- Вставка данных\n");
            for (String table : tables) {
                List<Map<String, Object>> rows = jdbcTemplate.queryForList("SELECT * FROM \"" + table + "\"");
                if (!rows.isEmpty()) {
                    List<String> columns = new ArrayList<>(rows.get(0).keySet());

                    writer.write("-- Данные таблицы: " + table + "\n");
                    for (Map<String, Object> row : rows) {
                        writer.write(buildInsertStatement(table, columns, row) + "\n");
                    }
                    writer.write("\n");
                }
            }

            // 6. Восстановление внешних ключей
            writer.write("-- Восстановление внешних ключей\n");
            for (String table : tables) {
                String fkScript = getForeignKeysDDL(table);
                if (!fkScript.isEmpty()) {
                    writer.write(fkScript);
                }
            }

            // 7. Фиксация транзакции
            writer.write("\nCOMMIT;\n");
            writer.write("-- Бэкап успешно завершен\n");

        } catch (Exception e) {
            throw new IOException("Ошибка при создании бэкапа: " + e.getMessage(), e);
        }
    }

    private List<String> getTablesInDependencyOrder() {
        // Получаем все таблицы
        List<String> allTables = jdbcTemplate.queryForList(
                "SELECT table_name FROM information_schema.tables " +
                        "WHERE table_schema = 'public' AND table_type = 'BASE TABLE'",
                String.class);

        // Получаем зависимости между таблицами
        Map<String, List<String>> dependencies = jdbcTemplate.queryForList(
                        "SELECT tc.table_name, ccu.table_name AS referenced_table " +
                                "FROM information_schema.table_constraints tc " +
                                "JOIN information_schema.constraint_column_usage ccu " +
                                "ON tc.constraint_name = ccu.constraint_name " +
                                "WHERE tc.constraint_type = 'FOREIGN KEY' AND tc.table_schema = 'public'")
                .stream()
                .collect(Collectors.groupingBy(
                        row -> (String) row.get("table_name"),
                        Collectors.mapping(
                                row -> (String) row.get("referenced_table"),
                                Collectors.toList()
                        )
                ));

        // Топологическая сортировка
        List<String> sortedTables = new ArrayList<>();
        List<String> remainingTables = new ArrayList<>(allTables);

        while (!remainingTables.isEmpty()) {
            boolean changed = false;
            for (int i = 0; i < remainingTables.size(); i++) {
                String table = remainingTables.get(i);
                List<String> deps = dependencies.getOrDefault(table, Collections.emptyList());

                if (sortedTables.containsAll(deps)) {
                    sortedTables.add(table);
                    remainingTables.remove(i);
                    changed = true;
                    break;
                }
            }

            if (!changed) {
                // Если есть циклические зависимости, добавляем оставшиеся таблицы
                sortedTables.addAll(remainingTables);
                remainingTables.clear();
            }
        }

        return sortedTables;
    }

    private String getTableCreationDDL(String tableName) {
        // Получаем структуру таблицы
        List<Map<String, Object>> columns = jdbcTemplate.queryForList(
                "SELECT column_name, data_type, is_nullable, column_default " +
                        "FROM information_schema.columns " +
                        "WHERE table_schema = 'public' AND table_name = ? " +
                        "ORDER BY ordinal_position",
                tableName);

        // Получаем первичные ключи
        List<String> primaryKeys = jdbcTemplate.queryForList(
                "SELECT column_name FROM information_schema.key_column_usage " +
                        "WHERE table_schema = 'public' AND table_name = ? AND constraint_name = ?",
                String.class,
                tableName,
                tableName + "_pkey");

        StringBuilder ddl = new StringBuilder("CREATE TABLE \"" + tableName + "\" (\n");

        // Собираем информацию о serial полях
        List<String> serialColumns = new ArrayList<>();

        // Колонки
        for (Map<String, Object> column : columns) {
            String columnName = (String) column.get("column_name");
            String dataType = (String) column.get("data_type");
            String isNullable = (String) column.get("is_nullable");
            String columnDefault = (String) column.get("column_default");
            boolean isSerial = columnDefault != null && columnDefault.startsWith("nextval(");

            if (isSerial) {
                // Для serial полей используем специальный тип
                if (dataType.equals("integer")) {
                    ddl.append("  \"").append(columnName).append("\" SERIAL");
                    serialColumns.add(columnName);
                } else if (dataType.equals("bigint")) {
                    ddl.append("  \"").append(columnName).append("\" BIGSERIAL");
                    serialColumns.add(columnName);
                } else {
                    // Для других типов оставляем как есть
                    ddl.append("  \"").append(columnName).append("\" ").append(dataType)
                            .append(" DEFAULT ").append(columnDefault);
                }
            } else {
                // Обычные поля
                ddl.append("  \"").append(columnName).append("\" ").append(dataType);

                if ("NO".equals(isNullable)) {
                    ddl.append(" NOT NULL");
                }

                if (columnDefault != null && !columnDefault.isEmpty()) {
                    ddl.append(" DEFAULT ").append(columnDefault);
                }
            }

            ddl.append(",\n");
        }

        // Первичный ключ
        if (!primaryKeys.isEmpty()) {
            ddl.append("  PRIMARY KEY (");
            ddl.append(primaryKeys.stream()
                    .map(key -> "\"" + key + "\"")
                    .collect(Collectors.joining(", ")));
            ddl.append("),\n");
        }

        // Удаляем последнюю запятую
        if (ddl.charAt(ddl.length()-2) == ',') {
            ddl.delete(ddl.length()-2, ddl.length());
        }
        ddl.append("\n);");

        return ddl.toString();
    }

    private String getForeignKeysDDL(String tableName) {
        StringBuilder fkDdl = new StringBuilder();

        // Получаем информацию о внешних ключах
        List<Map<String, Object>> foreignKeys = jdbcTemplate.queryForList(
                "SELECT tc.constraint_name, kcu.column_name, " +
                        "ccu.table_name AS foreign_table_name, " +
                        "ccu.column_name AS foreign_column_name, " +
                        "rc.update_rule, rc.delete_rule " +
                        "FROM information_schema.table_constraints tc " +
                        "JOIN information_schema.key_column_usage kcu " +
                        "ON tc.constraint_name = kcu.constraint_name " +
                        "JOIN information_schema.constraint_column_usage ccu " +
                        "ON ccu.constraint_name = tc.constraint_name " +
                        "JOIN information_schema.referential_constraints rc " +
                        "ON rc.constraint_name = tc.constraint_name " +
                        "WHERE tc.constraint_type = 'FOREIGN KEY' " +
                        "AND tc.table_schema = 'public' " +
                        "AND tc.table_name = ?",
                tableName);

        for (Map<String, Object> fk : foreignKeys) {
            String constraintName = (String) fk.get("constraint_name");
            String columnName = (String) fk.get("column_name");
            String foreignTable = (String) fk.get("foreign_table_name");
            String foreignColumn = (String) fk.get("foreign_column_name");
            String updateRule = (String) fk.get("update_rule");
            String deleteRule = (String) fk.get("delete_rule");

            fkDdl.append("ALTER TABLE \"").append(tableName).append("\" ")
                    .append("ADD CONSTRAINT \"").append(constraintName).append("\" ")
                    .append("FOREIGN KEY (\"").append(columnName).append("\") ")
                    .append("REFERENCES \"").append(foreignTable).append("\" (\"").append(foreignColumn).append("\") ")
                    .append("ON UPDATE ").append(updateRule).append(" ")
                    .append("ON DELETE ").append(deleteRule).append(";\n");
        }

        return fkDdl.toString();
    }

    private String buildInsertStatement(String tableName, List<String> columns, Map<String, Object> row) {
        StringBuilder sb = new StringBuilder("INSERT INTO \"" + tableName + "\" (");

        // Список колонок
        sb.append(columns.stream()
                .map(col -> "\"" + col + "\"")
                .collect(Collectors.joining(", ")));
        sb.append(") VALUES (");

        // Значения
        List<String> values = new ArrayList<>();
        for (String column : columns) {
            Object value = row.get(column);
            values.add(formatValueForSql(column, value));
        }
        sb.append(String.join(", ", values));
        sb.append(");");

        return sb.toString();
    }

    private String formatValueForSql(String column, Object value) {
        if (value == null) {
            return "NULL";
        }

        if (value instanceof String) {
            return "'" + value.toString().replace("'", "''") + "'";
        }

        if (value instanceof java.util.Date) {
            return "'" + new java.sql.Timestamp(((java.util.Date)value).getTime()) + "'";
        }

        if (value instanceof Boolean) {
            return (Boolean)value ? "TRUE" : "FALSE";
        }

        if ("duration".equals(column) || "warranty_period".equals(column)) {
            return formatInterval(value.toString());
        }

        return value.toString();
    }

    private String formatInterval(String intervalStr) {
        String[] parts = intervalStr.split(" ");
        StringBuilder result = new StringBuilder("'");

        try {
            int years = Integer.parseInt(parts[0]);
            int months = Integer.parseInt(parts[2]);
            int days = Integer.parseInt(parts[4]);
            int hours = Integer.parseInt(parts[6]);
            int minutes = Integer.parseInt(parts[8]);
            double seconds = Double.parseDouble(parts[10]);

            if (years > 0) result.append(years).append(" years ");
            if (months > 0) result.append(months).append(" months ");
            if (days > 0) result.append(days).append(" days ");
            if (hours > 0) result.append(hours).append(" hours ");
            if (minutes > 0) result.append(minutes).append(" minutes ");
            if (seconds > 0) result.append(seconds).append(" seconds ");

            if (result.charAt(result.length()-1) == ' ') {
                result.deleteCharAt(result.length()-1);
            }
        } catch (Exception e) {
            return "'" + intervalStr + "'::interval";
        }

        result.append("'::interval");
        return result.toString();
    }

    public void loadBackup(String filename, boolean isSuperuser) throws IOException {
        if (!isSuperuser) {
            throw new SecurityException("Только суперпользователь может загружать резервные копии");
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;
            StringBuilder sql = new StringBuilder();

            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty() || line.trim().startsWith("--")) {
                    continue;
                }

                sql.append(line);

                if (line.trim().endsWith(";")) {
                    try {
                        jdbcTemplate.execute(sql.toString());
                    } catch (Exception e) {
                        System.err.println("Error executing SQL: " + sql.toString());
                        throw e;
                    }
                    sql.setLength(0);
                }
            }
        }
    }

    public List<String> getAllTables() {
        return jdbcTemplate.queryForList(
                "SELECT table_name FROM information_schema.tables " +
                        "WHERE table_schema = 'public' AND table_type = 'BASE TABLE'",
                String.class);
    }

    public void deleteRowAndShiftIds(String tableName, int idToDelete, boolean isSuperuser) {
        checkUserPermissions(tableName, "удаления данных", isSuperuser);

        // 1. Проверяем существование таблицы и первичного ключа
        if (!isTableExists(tableName)) {
            throw new IllegalArgumentException("Table '" + tableName + "' doesn't exist!");
        }

        if (!isColumnExists(tableName, "id")) {
            throw new IllegalArgumentException("Table '" + tableName + "' has no 'id' column!");
        }

        // 2. Удаляем строку
        String deleteSql = "DELETE FROM " + tableName + " WHERE id = ?";
        jdbcTemplate.update(deleteSql, idToDelete);

        // 3. Обновляем ID у последующих строк
        String updateSql = "UPDATE " + tableName + " SET id = id - 1 WHERE id > ?";
        jdbcTemplate.update(updateSql, idToDelete);

        // 4. Обновляем последовательность (если используется SERIAL)
        resetSequence(tableName);
    }

    private boolean isTableExists(String tableName) {
        String sql = "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = ?)";
        return jdbcTemplate.queryForObject(sql, Boolean.class, tableName);
    }

    private boolean isColumnExists(String tableName, String columnName) {
        String sql = "SELECT EXISTS (SELECT FROM information_schema.columns " +
                "WHERE table_name = ? AND column_name = ?)";
        return jdbcTemplate.queryForObject(sql, Boolean.class, tableName, columnName);
    }

    private void resetSequence(String tableName) {
        try {
            String sequenceName = tableName + "_id_seq";
            String sql = "SELECT setval('" + sequenceName + "', (SELECT MAX(id) FROM " + tableName + "))";
            jdbcTemplate.execute(sql);
        } catch (Exception e) {
            // Последовательность может не существовать - это нормально
        }
    }

    public void updateRow(String tableName, int id, Map<String, Object> updates, boolean isSuperuser) {
        checkUserPermissions(tableName, "редактирования", isSuperuser);

        if (updates == null || updates.isEmpty()) {
            throw new IllegalArgumentException("No fields to update!");
        }

        // Проверяем существование таблицы
        if (!isTableExists(tableName)) {
            throw new IllegalArgumentException("Table '" + tableName + "' doesn't exist!");
        }

        // Проверяем существование записи
        if (!isRowExists(tableName, id)) {
            throw new IllegalArgumentException("Row with id " + id + " doesn't exist in table '" + tableName + "'!");
        }

        // Проверяем существование колонок
        for (String column : updates.keySet()) {
            if (!isColumnExists(tableName, column)) {
                throw new IllegalArgumentException("Column '" + column + "' doesn't exist in table '" + tableName + "'!");
            }
        }

        // Строим SQL запрос
        StringBuilder sql = new StringBuilder("UPDATE " + tableName + " SET ");
        List<Object> values = new ArrayList<>();

        for (Map.Entry<String, Object> entry : updates.entrySet()) {
            sql.append(entry.getKey()).append(" = ?, ");
            values.add(entry.getValue());
        }

        // Удаляем последнюю запятую
        sql.setLength(sql.length() - 2);
        sql.append(" WHERE id = ?");
        values.add(id);

        // Выполняем обновление
        jdbcTemplate.update(sql.toString(), values.toArray());
    }

    private boolean isRowExists(String tableName, int id) {
        String sql = "SELECT EXISTS (SELECT 1 FROM " + tableName + " WHERE id = ?)";
        return jdbcTemplate.queryForObject(sql, Boolean.class, id);
    }

    // Получение всех строк таблицы
    public List<Map<String, Object>> getTableData(String tableName) {
        // Просмотр разрешен всем пользователям
        // Проверяем, существует ли таблица
        if (!isTableExists(tableName)) {
            throw new IllegalArgumentException("Table '" + tableName + "' doesn't exist!");
        }

        String sql = "SELECT * FROM " + tableName + " ORDER BY id";
        return jdbcTemplate.queryForList(sql);
    }

    // Получение конкретной строки по id
    public Map<String, Object> getRow(String tableName, int id) {
        // Просмотр разрешен всем пользователям
        if (!isTableExists(tableName)) {
            throw new IllegalArgumentException("Table '" + tableName + "' doesn't exist!");
        }

        if (!isColumnExists(tableName, "id")) {
            throw new IllegalArgumentException("Table '" + tableName + "' has no 'id' column!");
        }

        String sql = "SELECT * FROM " + tableName + " WHERE id = ?";
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql, id);

        if (rows.isEmpty()) {
            throw new IllegalArgumentException("Row with id " + id + " doesn't exist in table '" + tableName + "'!");
        }

        return rows.get(0);
    }

    // Методы для работы с ref_table (только для суперпользователя)
    public void addTableToRef(String tableName, boolean isReference, boolean isSuperuser) {
        if (!isSuperuser) {
            throw new SecurityException("Только суперпользователь может управлять справочными таблицами");
        }

        String sql = "INSERT INTO " + REF_TABLE_NAME + " (table_name, is_reference) VALUES (?, ?) " +
                "ON CONFLICT (table_name) DO UPDATE SET is_reference = ?";
        jdbcTemplate.update(sql, tableName, isReference, isReference);
    }

    public void removeTableFromRef(String tableName, boolean isSuperuser) {
        if (!isSuperuser) {
            throw new SecurityException("Только суперпользователь может управлять справочными таблицами");
        }

        String sql = "DELETE FROM " + REF_TABLE_NAME + " WHERE table_name = ?";
        jdbcTemplate.update(sql, tableName);
    }

    public List<Map<String, Object>> getRefTables() {
        String sql = "SELECT * FROM " + REF_TABLE_NAME + " ORDER BY table_name";
        return jdbcTemplate.queryForList(sql);
    }

    public boolean isTableReference(String tableName) {
        return isReferenceTable(tableName);
    }
}