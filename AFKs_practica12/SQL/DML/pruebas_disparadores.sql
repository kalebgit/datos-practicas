
-- ver todos los triggers activos en la base de datos
SELECT trigger_name, event_object_table, action_timing, event_manipulation
FROM information_schema.triggers
WHERE trigger_schema = 'public'
ORDER BY event_object_table, action_timing;

-- ver creditos de un cliente especifico
SELECT * FROM creditos WHERE cliente_id = 1 ORDER BY fecha_emision DESC;

-- ver notificaciones pendientes que no se han enviado
SELECT * FROM notificaciones_pendientes WHERE enviada = FALSE;

-- ver historial de precios de un boleto
SELECT * FROM historial_precios_boleto WHERE boleto_id = 1 ORDER BY fecha_cambio DESC;

-- ver ingresos proyectados de todos los vuelos ordenados de mayor a menor
SELECT * FROM reporte_ingresos_vuelo ORDER BY ingreso_proyectado DESC;

-- ========================================
-- CASOS DE PRUEBA
-- ========================================

-- PRUEBA cancelar un vuelo y ver que se generen creditos y notificaciones
UPDATE vuelo SET estado = 'cancelado' WHERE numero_vuelo = 'AM101';
-- luego verificar:
SELECT * FROM creditos WHERE origen = 'cancelacion_vuelo';
SELECT * FROM notificaciones_pendientes WHERE tipo = 'cancelacion';

-- PRUEBA actualizar precio de boleto en ultima hora (deberia aplicar recargo 30%)
UPDATE boleto SET precio = 5000 WHERE boleto_id = 1;
-- verificar que se aplico recargo y se guardo en historial:
SELECT * FROM historial_precios_boleto WHERE boleto_id = 1;

-- PRUEBA comprar boletos hasta superar 80% ocupacion
INSERT INTO comprar (cliente_id, boleto_id, fecha_compra) VALUES (1, 10, CURRENT_TIMESTAMP);
-- verificar que se incrementaron precios de boletos restantes:
SELECT precio FROM boleto WHERE numero_vuelo = 'XX' AND boleto_id NOT IN (SELECT boleto_id FROM comprar);
