CREATE TABLE auditoria_juan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mensaje VARCHAR(200),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER //

CREATE PROCEDURE Sp_Insertar_pago()
BEGIN
    INSERT INTO auditoria_juan (mensaje)
    VALUES ('Ejecutado desde Juan');
END //

DELIMITER ;

DELIMITER //

CREATE EVENT Auditoria_Juan
ON SCHEDULE EVERY 1 MINUTE
STARTS NOW()
DO
BEGIN
    INSERT INTO auditoria_juan (mensaje)
    VALUES ('Ejecutado desde Evento');

    CALL Sp_Insertar_pago();
END //

DELIMITER ;


SET GLOBAL event_scheduler = ON;

SHOW EVENTS;


SHOW VARIABLES LIKE 'event_scheduler';

SELECT * FROM auditoria_juan ORDER BY fecha DESC;

ALTER EVENT Auditoria_Juan DISABLE; -- Pausar
ALTER EVENT Auditoria_Juan ENABLE; -- Reanudar
DROP EVENT Auditoria_Juan; -- Eliminar