# Lab 05 – Parte 1: Interfaz con Teclado Matricial en FPGA

---

## 📋 Contenido

1. Objetivos de aprendizaje  
2. Fundamento teórico  
3. Descripción del sistema  
4. Procedimiento  
5. Criterios de validación  
6. Entregables  

---

## 1. Objetivos de aprendizaje

Al finalizar esta parte del laboratorio, el estudiante será capaz de:

- Comprender el funcionamiento de un teclado matricial  
- Implementar el escaneo de filas y lectura de columnas  
- Diseñar un sistema de detección de teclas  
- Sincronizar señales externas  
- Implementar técnicas de debounce  

---

## 2. Fundamento teórico

### 2.1 Teclado matricial

Un teclado matricial organiza las teclas en filas y columnas, reduciendo el número de pines necesarios.

### 2.2 Escaneo

El sistema activa una fila a la vez y lee las columnas para detectar una tecla.

### 2.3 Detección

Una tecla se identifica mediante la combinación fila-columna.

### 2.4 Rebote

Los botones generan ruido eléctrico, por lo que es necesario filtrar señales.

---

## 3. Descripción del sistema

El sistema debe detectar una tecla y mostrar su valor en LEDs.

Entradas:
- clk
- rst
- cols[3:0]

Salidas:
- rows[3:0]
- leds[3:0]
- key_valid

---

## 4. Procedimiento

1. Implementar escaneo de filas  
2. Leer columnas  
3. Detectar tecla  
4. Generar señal válida  
5. Implementar debounce  
6. Mostrar resultado en LEDs  

---

## 5. Criterios de validación

- Cada tecla produce un valor único  
- No hay rebotes visibles  
- El sistema es estable  

---

## 6. Entregables

- Código Verilog  
- README con explicación  
- Simulación  
- Implementación en FPGA  

---

## Comentario

No avanzar a la siguiente parte sin validar completamente esta etapa.
