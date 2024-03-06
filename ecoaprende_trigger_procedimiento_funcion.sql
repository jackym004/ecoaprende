use db_ecoaprende;

DELIMITER //

CREATE TRIGGER tr_nuevo_pedido AFTER INSERT ON tb_pedido
FOR EACH ROW
BEGIN
    DECLARE mensaje VARCHAR(100);
    SET mensaje = CONCAT('Se ha insertado un nuevo pedido con el ID: ', NEW.id_pedido);
    SELECT mensaje INTO @mensaje;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @mensaje;
END;
//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_nuevo_pedido(IN nuevo_pedido_id VARCHAR(36))
BEGIN
    DECLARE mensaje VARCHAR(100);
    SET mensaje = CONCAT('Se ha insertado un nuevo pedido con el ID: ', nuevo_pedido_id);
    SELECT mensaje;
END;
//

DELIMITER ;

CALL sp_nuevo_pedido('B001');
CALL sp_nuevo_pedido('B002');
CALL sp_nuevo_pedido('B003');
CALL sp_nuevo_pedido('B004');
CALL sp_nuevo_pedido('B005');
CALL sp_nuevo_pedido('B006');
CALL sp_nuevo_pedido('B007');
CALL sp_nuevo_pedido('B008');
CALL sp_nuevo_pedido('B009');
CALL sp_nuevo_pedido('B0010');
CALL sp_nuevo_pedido('B0011');
CALL sp_nuevo_pedido('B0012');
CALL sp_nuevo_pedido('B0013');
CALL sp_nuevo_pedido('B0014');
CALL sp_nuevo_pedido('B0015');
CALL sp_nuevo_pedido('B0016');
CALL sp_nuevo_pedido('B0017');
CALL sp_nuevo_pedido('B0018');
CALL sp_nuevo_pedido('B0019');
CALL sp_nuevo_pedido('B0020');
CALL sp_nuevo_pedido('B0021');
CALL sp_nuevo_pedido('B0022');
CALL sp_nuevo_pedido('B0023');
CALL sp_nuevo_pedido('B0024');
CALL sp_nuevo_pedido('B0025');

DELIMITER //

CREATE FUNCTION fn_nuevo_pedido(nuevo_pedido_id VARCHAR(36)) RETURNS VARCHAR(100)
BEGIN
    DECLARE mensaje VARCHAR(100);
    SET mensaje = CONCAT('Se ha insertado un nuevo pedido con el ID: ', nuevo_pedido_id);
    RETURN mensaje;
END;
//

DELIMITER ;

SELECT fn_nuevo_pedido('A001');
SELECT fn_nuevo_pedido('A002');
SELECT fn_nuevo_pedido('A003');
SELECT fn_nuevo_pedido('A004');
SELECT fn_nuevo_pedido('A005');
SELECT fn_nuevo_pedido('A006');
SELECT fn_nuevo_pedido('A007');
SELECT fn_nuevo_pedido('A008');
SELECT fn_nuevo_pedido('A009');
SELECT fn_nuevo_pedido('A0010');
SELECT fn_nuevo_pedido('A0011');
SELECT fn_nuevo_pedido('A0012');
SELECT fn_nuevo_pedido('A0013');
SELECT fn_nuevo_pedido('A0014');
SELECT fn_nuevo_pedido('A0015');
SELECT fn_nuevo_pedido('A0016');
SELECT fn_nuevo_pedido('A0017');
SELECT fn_nuevo_pedido('A0018');
SELECT fn_nuevo_pedido('A0019');
SELECT fn_nuevo_pedido('A0020');
SELECT fn_nuevo_pedido('A0021');
SELECT fn_nuevo_pedido('A0022');
SELECT fn_nuevo_pedido('A0023');
SELECT fn_nuevo_pedido('A0024');
SELECT fn_nuevo_pedido('A0025');
