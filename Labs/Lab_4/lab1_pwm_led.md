
# Laboratorio 4 Parte 1  
# Circuitos Secuenciales, Contadores y Generación de PWM

## Objetivos

Al finalizar este laboratorio el estudiante podrá:

- Comprender qué es un circuito secuencial
- Diseñar circuitos secuenciales en Verilog
- Implementar contadores digitales
- Comprender la generación de señales PWM
- Controlar el brillo de un LED usando PWM

---

# 1. Circuitos Secuenciales

Un **circuito secuencial** es un sistema digital cuya salida depende de:

- Entradas actuales
- Estado previo del sistema

Salida = f(Entradas, Estado)

Los circuitos secuenciales utilizan **memoria**, normalmente implementada con **flip‑flops**.

Ejemplos comunes:

- contadores
- registros
- máquinas de estado
- temporizadores

Los cambios de estado ocurren sincronizados con una señal de **reloj (clock)**.

---

# 2. Circuitos Secuenciales en Verilog

En Verilog se describen con bloques `always` activados por el reloj.

Ejemplo de registro:

```verilog
module registro(
    input clk,
    input reset,
    input [3:0] D,
    output reg [3:0] Q
);

always @(posedge clk or posedge reset)
begin
    if(reset)
        Q <= 4'b0000;
    else
        Q <= D;
end

endmodule
```

---

# 3. Contadores

Un **contador** incrementa su valor en cada ciclo de reloj.

Ejemplo contador 4 bits

0000  
0001  
0010  
0011  
...  
1111  
0000  

Un contador de **N bits** tiene:

max = 2^N estados

Para **4 bits**:

2⁴ = 16 estados

---

# 4. PWM (Pulse Width Modulation)

PWM permite controlar potencia usando una señal digital.

Duty Cycle:

Duty = Ton / Tperiodo

Ejemplo visual

25%  ███........  
50%  █████.....  
75%  ███████...  

---

# 5. Generación de PWM con contador

Arquitectura básica:

```
          +-----------+
clock --->| contador  |
          +-----------+
                 |
                 v
           +-----------+
duty ----->|comparador |----> PWM
           +-----------+
```

Regla de funcionamiento
```
if contador < duty  
    PWM = 1  

if contador >= duty  
    PWM = 0  
```
---

# 6. PWM con contador de 4 bits

Un contador de 4 bits tiene **16 niveles**.

Cada paso ≈ 1/16 ≈ **6.25%**

| duty | duty aproximado |
|----|----|
1 | 6% |
4 | 25% |
8 | 50% |
12 | 75% |
15 | 94% |

---

# 7. Diagrama temporal del PWM

Ejemplo contador 4 bits

contador

0 1 2 3 4 5 6 7 8 9 A B C D E F

PWM con duty = 4

```
PWM  ████............
```

PWM con duty = 8

```
PWM  ████████........
```

PWM con duty = 12

```
PWM  ████████████....
```



---

# Actividades

## Actividad 1

Diseñe un **contador de 4 bits**.

## Actividad 2

Diseñe un **comparador** que compare:

contador  
duty

## Actividad 3

Construya un **generador PWM**.

## Actividad 4

Controle el brillo de un LED usando switches para modificar el duty cycle.

---

# Entregables

1. Código del contador
2. Código del PWM
3. Simulación
4. Implementación en FPGA
