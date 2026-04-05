
# Laboratorio 4 Parte 2  
# Control de Servomotor usando PWM

## Objetivos

- Comprender cómo se controla un servomotor mediante PWM
- Generar señales PWM utilizando contadores
- Utilizar contadores como divisores de frecuencia
- Implementar control de posición de un servomotor desde una FPGA

---
# 1. Conexión de un servomotor

Un servomotor típico tiene **tres cables**:

| Cable | Función |
|------|------|
Rojo | Alimentación |
Negro / Marrón | Tierra (GND) |
Amarillo / Naranja | Señal PWM |

La señal PWM solo es una **señal de control**, por lo que **no se requiere un driver de potencia** como el L293D o L298N.

El control real del motor se realiza mediante la **electrónica interna del servomotor**.

## Conexión básica

```
FPGA PWM --------> Señal servo
GND FPGA --------> GND servo
Fuente 5V -------> Vcc servo
```

La FPGA únicamente genera la señal PWM.

La alimentación del servo debe provenir de una **fuente externa de 5V**.

Es importante que:
```
GND FPGA = GND fuente externa
```

Esto asegura que la señal PWM tenga una referencia común.

## 2. Señal de control de un servomotor

Los servomotores se controlan mediante una señal **PWM periódica**.

Parámetros principales:

- **Periodo de la señal** : T
- **Ancho del pulso alto** : T_on
- **Duty Cycle**
- **Periodo**: 20 ms

Ecuación del duty cycle:

Duty = T_on / T

Valores típicos de control:

| Posición | Pulso |
|--------|--------|
0° | 1 ms |
90° | 1.5 ms |
180° | 2 ms |

se debe esperar hasta los 20ms para enviar un nuevo angulo.

### Ejemplo conceptual (90°)

Periodo = 20ms  
Pulso = 1.5ms

Diagrama temporal:

```
█████████........................
|--1.5ms-|
|------------20ms----------------|
```

---

# 3. Generación de la señal para el servo

Para generar la señal PWM del servomotor se deben definir:

- **Periodo total** : T
- **Pulso alto** : T_on

Los ciclos necesarios se calculan mediante:



ciclos_pulso = T_on / T_clock

El comparador debe activar la salida mientras:

contador < ciclos_pulso=Cp

---

# 4. Arquitectura sugerida

```
      clock
        |
        v
      contador
        |
        v
Cp->comparador
        |
        v
      PWM_servo
```

El contador define el **periodo total de la señal**(para un servomotor 20ms).

El comparador determina **cuánto tiempo permanece en alto el pulso**(1-2ms).

---

# 5. Actividades

### Actividad 1

Diseñe un **contador** que genere el periodo completo de la señal PWM.

### Actividad 2

Diseñe la lógica que genere pulsos con diferentes valores de **T_on**.

### Actividad 3

Controle la posición del servomotor usando **switches**.

Ejemplo de mapeo:

| Switch | Posición |
|------|------|
00 | 0° |
01 | 90° |
10 | 180° |

---

# 6. Entregables

1. Diagrama de arquitectura del sistema
2. Código Verilog del generador PWM
3. Simulación del PWM
4. Demostración del control del servomotor
