# Laboratorio 4: Circuitos Secuenciales, Contadores y Generación de PWM

## Contenido

1. Objetivos de aprendizaje  
2. Fundamento teórico  
   2.1 Circuitos secuenciales  
   2.2 Contadores digitales  
   2.3 Modulación por ancho de pulso (PWM)  
   2.4 Arquitectura de un generador PWM  
3. Especificación del diseño  
4. Entregables  
5. Material de apoyo  

---

## 1. Objetivos de aprendizaje

- Comprender el funcionamiento de los circuitos secuenciales síncronos.
- Diseñar sistemas digitales utilizando registros y contadores en Verilog.
- Implementar un sistema completo basado en arquitectura modular.
- Diseñar un generador PWM controlado en tiempo real.
- Analizar el impacto de la frecuencia de reloj en sistemas digitales físicos.
- Verificar el funcionamiento del sistema mediante simulación (Icarus Verilog) y testbench.

---

## 2. Fundamento teórico

### 2.1 Circuitos secuenciales

Un circuito secuencial es un sistema digital cuya salida depende no solo de las entradas actuales, sino también del estado previo del sistema, el cual es almacenado en elementos de memoria como los flip-flops.

$$Salida = f(Entradas, Estado)$$

Los sistemas secuenciales síncronos actualizan su estado en función de una señal de reloj (clock), típicamente en el flanco de subida.

En Verilog, estos sistemas se describen mediante bloques always sensibles al reloj:

```verilog
always @(posedge clk)
begin
    // lógica secuencial
end
```


---

### 2.2 Contadores digitales

Un contador es un sistema secuencial que recorre una secuencia de estados de manera controlada por el reloj.

Para un contador de N bits:

Número de estados = $2^N$

Ejemplo para 4 bits:
```
0000 → 0001 → 0010 → ... → 1111 → 0000
```

---

### 2.3 Modulación por ancho de pulso (PWM)

La modulación por ancho de pulso (PWM) es una técnica que permite controlar la potencia promedio entregada a una carga utilizando una señal digital.

$$Duty = \frac{T_{on}}{T_{periodo}}$$

Ejemplo conceptual:

25%  ███........  
50%  █████.....  
75%  ███████...  

---

### 2.4 Arquitectura de un generador PWM

Un generador PWM digital se basa en tres bloques principales:

<p align="center">
 <img src="/Labs/figs/labservo/pwm_led.png" alt="tex" width=1000 >
</p>
<p align="center">
 Figura 1: Esquema de PWM
</p>

Principio de funcionamiento:

```verilog
always @(*)
begin
    case (contador < duty)
        1'b1: PWM = 1'b1;
        1'b0: PWM = 1'b0;
    endcase
end
```
La frecuencia del PWM está dada por:

$$f_{PWM} = \frac{f_{clk}}{2^N}$$

---

## 3. Especificación del diseño

### 3.1 Módulos requeridos

El diseño debe estar estructurado en los siguientes bloques:

1. Divisor de frecuencia  
- Debe reducir la frecuencia del reloj de entrada  
- Debe permitir obtener una frecuencia adecuada para PWM visible  
- Implementado como sistema secuencial  

2. Contador  
- Contador binario de 4 bits  
- Sensible al flanco de subida del reloj dividido  
- Reinicio síncrono o asíncrono  

3. Comparador  
- Implementado de forma estructural  
- Entrada: contador, duty  
- Salida: PWM  

4. Generador PWM  
- Integración de todos los módulos  

---

### 3.2 Interfaz del sistema

Entrada:
- clk
- switches[4:0]

Salida:
- LED

---

### 3.3 Control del duty cycle
```verilog
duty = switches[3:0]
```
---

### 3.4 Comportamiento esperado

- El LED debe variar su brillo según el valor de los switches  
- Cambios en los switches deben reflejarse dinámicamente  
- El sistema debe ser completamente síncrono  
## 4. Entregables
1. Implementación completa en Verilog de:
   - divisor de frecuencia  
   - contador  
   - comparador  
   - sistema PWM  

2. Archivo README.md que incluya:
   - Explicación del diseño  
   - Justificación del divisor de frecuencia  
   - Cálculo de la frecuencia del PWM  
   - Diagrama de bloques del sistema  
   - Descripción de cada módulo  

3. Simulación en Icarus Verilog:
   - Testbench funcional  
   - Evidencia de señales  
   - Uso de GTKWave  

4. Implementación en hardware:
   - Demostración del control de brillo del LED  
   - Uso de switches como entrada