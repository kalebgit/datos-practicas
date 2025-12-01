# Cambios en el Modelo de Datos - Práctica 12

## Resumen
Este documento detalla los cambios realizados al esquema de base de datos para la Práctica 12 sobre Triggers Avanzados. Incluye nuevas tablas, modificaciones a tablas existentes y sus relaciones.

---

## Tablas Modificadas

### Tabla: `boleto`
**Cambio:** Se agregó la columna `estado_boleto`

| Columna | Tipo de Dato | Restricciones | Descripción |
|---------|-------------|---------------|-------------|
| estado_boleto | VARCHAR(20) | NOT NULL, DEFAULT 'activo' | Estado actual del boleto |

**Valores permitidos (CHECK):**
- `'activo'` - Boleto válido y disponible
- `'cancelado'` - Boleto cancelado
- `'reembolsado'` - Boleto reembolsado por cancelación de vuelo
- `'usado'` - Boleto ya utilizado (pasajero abordó)

---

## Tablas Nuevas

### 1. Tabla: `creditos`
**Propósito:** Almacenar créditos otorgados a clientes por reembolsos, compensaciones y promociones.

| Columna | Tipo de Dato | Restricciones | Descripción |
|---------|-------------|---------------|-------------|
| credito_id | SERIAL | PRIMARY KEY | Identificador único del crédito |
| cliente_id | INT | NOT NULL, FOREIGN KEY → cliente(cliente_id) | Identificador del cliente que recibe el crédito |
| monto | NUMERIC(10,2) | NOT NULL, CHECK (monto > 0) | Monto del crédito en la moneda del sistema |
| fecha_emision | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Fecha y hora en que se emitió el crédito |
| fecha_vencimiento | DATE | NULL permitido | Fecha de vencimiento del crédito (NULL si no vence) |
| usado | BOOLEAN | DEFAULT FALSE | Indica si el crédito ya fue utilizado |
| origen | VARCHAR(50) | CHECK (valores específicos) | Origen del crédito |

**Valores permitidos para `origen` (CHECK):**
- `'cancelacion_vuelo'` - Reembolso por cancelación de vuelo
- `'compensacion'` - Compensación adicional (10% del boleto)
- `'promocion'` - Crédito promocional
- `'devolucion'` - Devolución por otros motivos

**Llaves Foráneas:**
- `fk_creditos_cliente`: `cliente_id` → `cliente(cliente_id)` ON DELETE CASCADE

**Índices:**
- `idx_creditos_cliente` en `cliente_id`
- `idx_creditos_usado` en `usado`
- `idx_creditos_origen` en `origen`

---

### 2. Tabla: `notificaciones_pendientes`
**Propósito:** Almacenar notificaciones pendientes de envío a clientes.

| Columna | Tipo de Dato | Restricciones | Descripción |
|---------|-------------|---------------|-------------|
| notificacion_id | SERIAL | PRIMARY KEY | Identificador único de la notificación |
| cliente_id | INT | NOT NULL, FOREIGN KEY → cliente(cliente_id) | Identificador del cliente destinatario |
| tipo | VARCHAR(50) | CHECK (valores específicos) | Tipo de notificación |
| mensaje | TEXT | NULL permitido | Contenido del mensaje de la notificación |
| fecha_creacion | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Fecha y hora de creación |
| enviada | BOOLEAN | DEFAULT FALSE | Indica si fue enviada al cliente |

**Valores permitidos para `tipo` (CHECK):**
- `'cancelacion'` - Notificación de cancelación de vuelo
- `'reembolso'` - Notificación de reembolso procesado
- `'cambio_vuelo'` - Notificación de cambio de vuelo
- `'promocion'` - Notificación promocional
- `'recordatorio'` - Recordatorio de vuelo

**Llaves Foráneas:**
- `fk_notificaciones_cliente`: `cliente_id` → `cliente(cliente_id)` ON DELETE CASCADE

**Índices:**
- `idx_notificaciones_cliente` en `cliente_id`
- `idx_notificaciones_enviada` en `enviada`
- `idx_notificaciones_tipo` en `tipo`

---

### 3. Tabla: `historial_precios_boleto`
**Propósito:** Auditoría de cambios de precio en boletos (para cumplimiento normativo).

| Columna | Tipo de Dato | Restricciones | Descripción |
|---------|-------------|---------------|-------------|
| historial_id | SERIAL | PRIMARY KEY | Identificador único del registro |
| boleto_id | INT | NOT NULL, FOREIGN KEY → boleto(boleto_id) | Identificador del boleto que cambió |
| precio_anterior | NUMERIC(10,2) | NULL permitido | Precio del boleto antes del cambio |
| precio_nuevo | NUMERIC(10,2) | NULL permitido | Precio del boleto después del cambio |
| fecha_cambio | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Fecha y hora del cambio |
| motivo | VARCHAR(100) | NULL permitido | Motivo del cambio de precio |

**Valores comunes para `motivo`:**
- `'Recargo última hora'` - Vuelo sale en < 7 días
- `'Ajuste por demanda'` - Incremento por alta demanda
- `'Descuento aplicado'` - Reducción de precio

**Llaves Foráneas:**
- `fk_historial_boleto`: `boleto_id` → `boleto(boleto_id)` ON DELETE CASCADE

**Índices:**
- `idx_historial_precios_boleto` en `boleto_id`
- `idx_historial_precios_fecha` en `fecha_cambio`

---

### 4. Tabla: `reporte_ingresos_vuelo`
**Propósito:** Mantener cálculo actualizado de ingresos proyectados por vuelo.

| Columna | Tipo de Dato | Restricciones | Descripción |
|---------|-------------|---------------|-------------|
| numero_vuelo | VARCHAR(10) | PRIMARY KEY, FOREIGN KEY → vuelo(numero_vuelo) | Número del vuelo |
| ingreso_proyectado | NUMERIC(12,2) | DEFAULT 0, CHECK (>= 0) | Suma total de precios de boletos activos/usados |
| ultima_actualizacion | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Fecha y hora de última actualización |

**Llaves Foráneas:**
- `fk_reporte_vuelo`: `numero_vuelo` → `vuelo(numero_vuelo)` ON DELETE CASCADE

**Nota:** Esta tabla se actualiza automáticamente mediante triggers cada vez que cambia el precio de un boleto.

---

##  Diagrama de Relaciones (para ER)

```
cliente (1) ──────< (N) creditos
    │
    └──────< (N) notificaciones_pendientes

boleto (1) ──────< (N) historial_precios_boleto

vuelo (1) ──────── (1) reporte_ingresos_vuelo
```

### Cardinalidades:

1. **Cliente - Créditos:** 1:N
   - Un cliente puede tener múltiples créditos
   - Un crédito pertenece a un solo cliente

2. **Cliente - Notificaciones:** 1:N
   - Un cliente puede tener múltiples notificaciones
   - Una notificación pertenece a un solo cliente

3. **Boleto - Historial de Precios:** 1:N
   - Un boleto puede tener múltiples cambios de precio
   - Un registro de historial pertenece a un solo boleto

4. **Vuelo - Reporte de Ingresos:** 1:1
   - Un vuelo tiene un único reporte de ingresos
   - Un reporte corresponde a un solo vuelo

---

## Triggers Implementados

### Trigger 1: Validar Cancelación de Vuelo
- **Tabla:** `vuelo`
- **Momento:** BEFORE UPDATE
- **Función:** `fn_validar_cancelacion_vuelo()`
- **Propósito:** Evitar cancelar vuelos en estados inválidos

### Trigger 2: Procesar Cancelación de Vuelo
- **Tabla:** `vuelo`
- **Momento:** AFTER UPDATE
- **Función:** `fn_procesar_cancelacion_vuelo()`
- **Propósito:** Generar reembolsos, compensaciones y notificaciones
- **Tablas afectadas:** `creditos`, `notificaciones_pendientes`, `boleto`

### Trigger 3: Aplicar Recargo Última Hora
- **Tabla:** `boleto`
- **Momento:** BEFORE UPDATE
- **Función:** `fn_aplicar_recargo_ultima_hora()`
- **Propósito:** Incrementar precio 30% si vuelo sale en < 7 días

### Trigger 4: Registrar Cambio de Precio
- **Tabla:** `boleto`
- **Momento:** AFTER UPDATE
- **Función:** `fn_registrar_cambio_precio()`
- **Propósito:** Guardar historial y actualizar ingresos proyectados
- **Tablas afectadas:** `historial_precios_boleto`, `reporte_ingresos_vuelo`

### Trigger 5: Ajustar Precios por Ocupación
- **Tabla:** `comprar`
- **Momento:** AFTER INSERT
- **Función:** `fn_ajustar_precios_por_ocupacion()`
- **Propósito:** Incrementar precios 20% cuando ocupación > 80%
- **Tablas afectadas:** `boleto`

---

## 📐 Especificaciones para Diagramas

### Para el Diagrama ER:
1. Agregar 4 nuevas entidades:
   - `creditos`
   - `notificaciones_pendientes`
   - `historial_precios_boleto`
   - `reporte_ingresos_vuelo`

2. Modificar la entidad `boleto`:
   - Agregar atributo `estado_boleto`

3. Relaciones a dibujar:
   - Cliente → Créditos (1:N)
   - Cliente → Notificaciones (1:N)
   - Boleto → Historial Precios (1:N)
   - Vuelo → Reporte Ingresos (1:1)

### Para el Diagrama Relacional:
1. Agregar 4 nuevas tablas con todas sus columnas
2. Mostrar llaves primarias (PK)
3. Mostrar llaves foráneas (FK) con flechas
4. Indicar constraints CHECK importantes
5. Modificar tabla `boleto` con nueva columna

---

## 📊 Datos de Ejemplo

### Ejemplo de crédito:
```
credito_id: 1
cliente_id: 42
monto: 5000.00
fecha_emision: 2025-12-01 14:30:00
fecha_vencimiento: NULL
usado: FALSE
origen: 'cancelacion_vuelo'
```

### Ejemplo de notificación:
```
notificacion_id: 1
cliente_id: 42
tipo: 'cancelacion'
mensaje: 'Estimado/a Juan Pérez: Su vuelo AM101 ha sido cancelado...'
fecha_creacion: 2025-12-01 14:30:00
enviada: FALSE
```

### Ejemplo de historial de precio:
```
historial_id: 1
boleto_id: 123
precio_anterior: 3000.00
precio_nuevo: 3900.00
fecha_cambio: 2025-12-01 10:00:00
motivo: 'Recargo última hora'
```

### Ejemplo de reporte de ingresos:
```
numero_vuelo: 'AM101'
ingreso_proyectado: 450000.00
ultima_actualizacion: 2025-12-01 14:30:00
```

---

## 🔧 Notas Técnicas

1. **Todas las foreign keys tienen `ON DELETE CASCADE`** para mantener integridad referencial.

2. **Los timestamps usan `CURRENT_TIMESTAMP`** para registrar automáticamente fecha/hora.

3. **Se agregaron índices** en columnas frecuentemente consultadas para optimizar performance.

4. **Las tablas usan `SERIAL`** para IDs autoincrementales.

5. **Todos los montos son `NUMERIC(10,2)`** para precisión decimal en valores monetarios.

---

## ✅ Checklist para Actualizar Diagramas

- [ ] Agregar tabla `creditos` con todos sus atributos
- [ ] Agregar tabla `notificaciones_pendientes` con todos sus atributos
- [ ] Agregar tabla `historial_precios_boleto` con todos sus atributos
- [ ] Agregar tabla `reporte_ingresos_vuelo` con todos sus atributos
- [ ] Modificar tabla `boleto` agregando `estado_boleto`
- [ ] Dibujar relación Cliente → Créditos (1:N)
- [ ] Dibujar relación Cliente → Notificaciones (1:N)
- [ ] Dibujar relación Boleto → Historial (1:N)
- [ ] Dibujar relación Vuelo → Reporte (1:1)
- [ ] Marcar todas las PKs
- [ ] Marcar todas las FKs
- [ ] Indicar constraints CHECK importantes
- [ ] Actualizar leyenda con nuevas tablas

---

**Fecha de actualización:** 1 de diciembre de 2025
**Práctica:** 12 - Triggers Avanzados
**Equipo:** AFKs
