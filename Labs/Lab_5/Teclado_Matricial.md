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
<p align="center">
 <img src="/Labs/figs/LabTecladoMatricial/arduino-teclado-matricial-interior.png" alt="tex" width=500 >
</p>
<p align="center">
 Figura 1: Estructura interna del Teclado Matricial
</p>

### 2.2 Escaneo

El sistema activa una fila a la vez y lee las columnas para detectar una tecla.

### 2.3 Detección

Una tecla se identifica mediante la combinación fila-columna.
<p align="center">
 <img src="/Labs/figs/LabTecladoMatricial/Keypad.gif" alt="tex" width=500 >
</p>
<p align="center">
 Figura 1: Escaneo Teclado Matricial
</p>


### 2.4 Rebote

Los botones mecánicos no generan transiciones limpias al ser presionados, sino que producen múltiples cambios rápidos de estado debido al rebote de sus contactos internos. Este fenómeno ocurre típicamente en un intervalo de entre 5 ms y 20 ms.

Por esta razón, es necesario implementar un mecanismo de validación temporal (debounce) que garantice que la señal permanezca estable durante un tiempo mayor al rebote (por ejemplo, 10 ms) antes de considerarla como una pulsación válida.

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

- Cada tecla produce un valor único (0 - 16) 
- No hay rebotes visibles  
- El sistema es estable  

---

## 6. Entregables

- Código Verilog  
- README con explicación  
- Simulación  
- Implementación en FPGA  


