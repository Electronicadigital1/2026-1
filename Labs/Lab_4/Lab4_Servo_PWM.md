# Laboratorio 4 - Parte 2  
# Control de Servomotor usando PWM

## Contenido
1. Objetivos  
2. Fundamento teórico  
   2.1 Conexión de un servomotor  
   2.2 Señal de control PWM  
   2.3 Generación de PWM  
   2.4 Arquitectura del sistema  
3. Actividades  
4. Entregables  

---

## 1. Objetivos

- Comprender el control de servomotores mediante señales PWM  
- Generar señales PWM utilizando contadores  
- Utilizar contadores como divisores de frecuencia  
- Implementar control de posición desde una FPGA  

---

## 2. Fundamento teórico

### 2.1 Conexión y principio de funcionamiento de un servomotor

Un **servomotor** es un sistema electromecánico diseñado para controlar de manera precisa la **posición angular** de un eje. A diferencia de un motor DC convencional, el servomotor no se controla directamente por voltaje o corriente, sino mediante una **señal de control PWM** que indica la posición deseada.


Internamente, un servomotor está compuesto por:

- Un **motor DC**
- Un **sistema de engranajes** (reducción mecánica)
- Un **sensor de posición** (típicamente un potenciómetro)
- Un **circuito de control interno**

Este circuito interno se encarga de:

- Comparar la posición actual con la posición deseada  
- Ajustar automáticamente la corriente del motor  
- Mantener la posición alcanzada  

Por esta razón, el servomotor es un sistema **cerrado (control en lazo cerrado)**, donde el usuario únicamente define la referencia mediante una señal PWM.
<p align="center">
 <img src="/Labs/figs/labservo/Servo-Motor-Internal-Structure-Illustration.png" alt="tex" width=1000 >
</p>
<p align="center">
 Figura 1: Estructura interna del servomotor
</p>


---

### Conexión de un servomotor

Un servomotor típico tiene tres cables:

| Cable | Función |
|------|--------|
| Rojo | Alimentación |
| Negro / Marrón | Tierra (GND) |
| Amarillo / Naranja | Señal PWM |

La señal PWM es únicamente una **señal de control**, por lo que:

- No transporta potencia significativa  
- No requiere un driver de potencia (como L293D o L298N)  
- Solo transmite la referencia de posición al sistema interno del servo  

<p align="center">
 <img src="/Labs/figs/labservo/SERVO_PINS.png" alt="tex" width=1000 >
</p>
<p align="center">
 Figura 2: Esquema de Servo
</p>

---

### Conexión básica

```
FPGA PWM --------> Señal servo
GND FPGA --------> GND servo
Fuente 5V -------> Vcc servo
```

- La FPGA genera únicamente la señal PWM  
- El servomotor debe alimentarse con una fuente externa  

Condición obligatoria:

```
GND FPGA = GND fuente externa
```

---

### 2.2 Señal de control PWM para servomotores

Los servomotores se controlan mediante una señal PWM periódica.

Parámetros principales:

- Periodo (T): 20 ms  
- Ancho del pulso (T_on): 1 ms a 2 ms  
- Duty Cycle  

Ecuación:
$$Duty = \frac{T_{on}}{T}$$


Valores típicos:

| Posición | Pulso |
|----------|--------|
| 0°       | 1 ms   |
| 90°      | 1.5 ms |
| 180°     | 2 ms   |

Se debe respetar el periodo de 20 ms antes de enviar un nuevo valor.

#### Ejemplo (90°)

```
█████████........................
|--1.5ms-|
|------------20ms----------------|
```



---

### 2.4 Arquitectura sugerida del sistema para control de servomotor

El sistema requerido para el control de un servomotor mediante PWM debe implementarse como un **sistema secuencial síncrono**, en el cual el tiempo es representado mediante conteo de ciclos de reloj.

La arquitectura se compone de los siguientes bloques fundamentales:

---

#### Contador de periodo

El sistema debe incluir un **contador binario de tamaño suficiente** para representar el periodo completo de la señal PWM del servomotor.

Este contador:

- Se incrementa en cada flanco de subida del reloj  
- Representa el tiempo dentro de un periodo completo de la señal  
- Debe reiniciarse automáticamente al alcanzar el valor máximo correspondiente al periodo  

---

#### Comparador de reinicio (control de periodo)

Se debe implementar un **comparador** que:

- Compare el valor actual del contador con el valor máximo del periodo  
- Genere la condición de reinicio del contador  

Este bloque garantiza que la señal PWM sea **periódica y estable en el tiempo**.

---

#### Entrada de usuario (resolución de 4 bits)

El sistema debe permitir que el usuario defina el ancho del pulso mediante una entrada digital de **4 bits**.

Esta entrada representa un valor discreto que será interpretado como una posición dentro del rango de operación del servomotor.

---

#### Codificador (mapeo de entrada a tiempo)

Se debe implementar un **bloque de codificación** que:

- Reciba el valor de 4 bits proveniente del usuario  
- Genere un valor de referencia en términos de ciclos de reloj  

Este valor representa el tiempo en alto del pulso PWM dentro del periodo total.

El estudiante deberá definir la relación entre el valor digital de entrada y el tiempo correspondiente, garantizando que se cubra el rango de operación del servomotor.

---

#### Comparador de PWM (generación de la señal)

Se debe implementar un segundo **comparador** que:

- Compare el valor del contador con el valor generado por el codificador  
- Determine el estado de la señal PWM  

Condición de operación:

- Si el contador es menor al valor de referencia → la señal PWM debe estar en alto  
- En caso contrario → la señal PWM debe estar en bajo  

---

### Consideraciones de diseño

si se encuentran una manera de diseñar mas sencilla sin la utilizacion de un bloque especial de verilog son bienvenidas nuevas formas de diseño

El correcto funcionamiento del sistema depende de:

- La adecuada selección del tamaño del contador  
- La correcta definición de los valores de comparación  
- La coherencia entre el periodo total y el ancho del pulso  

El estudiante es responsable de realizar los cálculos necesarios y validar que la señal generada cumpla con las especificaciones del servomotor.

---

### Enfoque del laboratorio

Este diseño busca que el estudiante:

- Comprenda la relación entre tiempo y conteo digital  
- Modele sistemas físicos mediante lógica secuencial  
- Diseñe sistemas parametrizables a partir de entradas digitales  

## 4. Entregables

1. Diagrama de arquitectura  
2. Código Verilog del generador PWM  
3. Simulación funcional  
4. Demostración en hardware  
