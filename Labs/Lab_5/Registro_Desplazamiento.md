# Lab 05 – Parte 2: Registro de Desplazamiento y Sistema de Contraseña con Control de Servo

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

- Implementar registros de desplazamiento para almacenamiento de datos  
- Diseñar un sistema de validación de contraseña  
- Desarrollar una FSM para control del sistema  
- Controlar un servo mediante PWM  
- Integrar un sistema completo entrada → procesamiento → acción  

---

## 2. Fundamento teórico

### 2.1 Registro de desplazamiento por dígitos

Se implementa un registro de 16 bits que almacena 4 dígitos BCD.

Cada nuevo dígito desplaza el contenido 4 bits a la izquierda:

    pass_in <= (pass_in << 4) | key_code;

Ejemplo:

Entrada: 1 → 2 → 3 → 4  
Resultado: 0001 0010 0011 0100  

---

### 2.2 Validación de contraseña

Se compara la entrada con una clave fija:

    parameter PASSWORD = 16'h1234;

    if (pass_in == PASSWORD)

---

### 2.3 Máquina de estados (FSM)

Estados del sistema:

    IDLE → INPUT → VERIFY → OPEN
                     ↓
                   ERROR

---

### 2.4 PWM para servo

- Periodo: 20 ms  
- 1 ms → cerrado  
- 2 ms → abierto  

---

## 3. Descripción del sistema

El sistema debe:

1. Recibir datos del teclado  
2. Almacenar 4 dígitos  
3. Validar contraseña  
4. Activar un servo  

---

## 4. Procedimiento

### Paso 1: Registro de desplazamiento

Implementar:

    pass_in <= (pass_in << 4) | key_code;

---

### Paso 2: Contador

Contar hasta 4 dígitos.

---

### Paso 3: FSM

Controlar flujo del sistema.

---

### Paso 4: Comparación

Comparar con PASSWORD.

---

### Paso 5: PWM

Controlar servo según resultado.

---

## 5. Criterios de validación

- Captura correcta de dígitos  
- Comparación correcta  
- Servo responde correctamente  
- LEDs indican estado  

---

## 6. Entregables

### Código
- Registro  
- FSM  
- Comparador  
- PWM  

### README
- Explicación del diseño  

### Simulación
- Pruebas funcionales  

### FPGA
- Demostración del sistema  

---

## 💡 Nota

El registro desplaza en bloques de 4 bits (BCD), no bit a bit.
