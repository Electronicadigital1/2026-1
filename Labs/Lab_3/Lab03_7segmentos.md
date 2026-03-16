# Lab 03: Visualización de Resultados en Displays de 7 Segmentos

---

## 📋 Contenido

1. [Objetivos de aprendizaje](#1-objetivos-de-aprendizaje)
2. [Fundamento teórico](#2-fundamento-teórico)
3. [Arquitectura del sistema](#3-arquitectura-del-sistema)
4. [Descripción de los bloques funcionales](#4-descripción-de-los-bloques-funcionales)
5. [Entregables](#5-entregables)

---

## 1. Objetivos de aprendizaje

Al finalizar este laboratorio, el estudiante será capaz de:

1. 🧩 **Diseñar** sistemas digitales utilizando bloques combinacionales.
2. 🔢 **Comprender** la representación de números en BCD y su uso en dispositivos de visualización.
3. 🔗 **Integrar** diferentes bloques funcionales para construir un sistema digital completo.
4. 💻 **Implementar** sistemas digitales utilizando HDL en una FPGA.
5. 🏗️ **Desarrollar** habilidades de diseño modular en sistemas digitales.

---

## 2. Fundamento teórico

### 2.1 BCD (Binary Coded Decimal)

> **BCD (Binary Coded Decimal)** es una representación numérica en la cual cada dígito decimal se codifica utilizando **cuatro bits binarios**.

| Dígito | Bit₃ | Bit₂ | Bit₁ | Bit₀ |
|:------:|:----:|:----:|:----:|:----:|
| 0      | 0    | 0    | 0    | 0    |
| 1      | 0    | 0    | 0    | 1    |
| 2      | 0    | 0    | 1    | 0    |
| 3      | 0    | 0    | 1    | 1    |
| 4      | 0    | 1    | 0    | 0    |
| 5      | 0    | 1    | 0    | 1    |
| 6      | 0    | 1    | 1    | 0    |
| 7      | 0    | 1    | 1    | 1    |
| 8      | 1    | 0    | 0    | 0    |
| 9      | 1    | 0    | 0    | 1    |

> ⚠️ **Nota:** Los códigos del 1010 al 1111 (10–15 en decimal) son **inválidos** en BCD y no representan ningún dígito.

---

### 2.2 Display de 7 segmentos

El display de siete segmentos es un dispositivo electrónico que consta de siete diodos emisores de luz (LED) dispuestos en un patrón definido; encender una combinación particular de éstos permite representar un dígito décimal o hexadécimal Existen dos tipos de display LED de siete segmentos:

* Tipo de cátodo común: en este tipo de display, todos los cátodos de los siete LEDs están conectados entre sí a tierra o $-Vcc$ (por lo tanto, cátodo común) y el LED muestra dígitos cuando se suministra un nivel alto a los ánodos individuales.
    
* Tipo de ánodo común: en este tipo de display, todos los ánodos de los siete LEDs están conectados a $+Vcc$ (por lo tanto, ánodo común) y el LED muestra dígitos cuando se suministra un nivel al bajo a los cátodos individuales.


En las siguientes figuras se muestra cómo se distribuyen los 7 segmentos en el display cuando se tiene una configuración de ánodo común:

<p align="center">
 <img src="/Labs/figs/lab03/segm.png" alt="alt text" width=500 >
</p>


<p align="center">
 <img src="https://exploreembedded.com/wiki/images/1/1a/0SevenSegment.gif" alt="alt text" width=400 >
</p>

## 3. Procedimiento

### Primera parte: Diseño BCD a 7seg

Pasos a seguir:

1. Definir el bloque funcional del diseño:

    <p align="center">
    <img src="/Labs/figs/lab03/Sseg.png" alt="alt text" width=500 >
    </p>


    Como se evidencia, el bloque tiene un puerto de entrada  llamado ```BCD``` de 4 bits y un puerto de salida llamado ```Sseg``` de 7 bits, lo que concuerda con lo mencionado anteriormente.

2.  Definir la descripción funcional del diseño:

    Para ello recuerde que puede hacer uso de las tablas de verdad o de la descripción algorítmica del decodificador BCD a 7 segmentos.

3. Describir usando HDL el comportamiento del diseño.

4. Simulación del diseño.

---

## 4. Arquitectura del sistema

El objetivo del laboratorio es diseñar un sistema digital que permita **visualizar el resultado de un Sumador/Restador aritmética** utilizando displays de siete segmentos.

### Entradas y salidas del sistema

| Signal | Tamaño | Descripción                        |
|--------|--------|------------------------------------|
| `A`    | 4 bits | Primer operando                    |
| `B`    | 4 bits | Segundo operando                   |
| `Op`   | 1 bit  | Operación: `0` = suma, `1` = resta |

El resultado se muestra en **tres displays**:

| Display  | Muestra       |
|----------|---------------|
| Display 1 | Signo        |
| Display 2 | Decenas       |
| Display 3 | Unidades      |

### Diagrama de bloques

<p align="center">
    <img src="/Labs/figs/lab03/BCD to 7Seg Display.png" alt="alt text" width=500 >
    </p>

---

## 4. Descripción de los bloques funcionales
 
El sistema está compuesto por cinco bloques funcionales que trabajan en cascada. Cada bloque tiene una responsabilidad única y bien definida, lo que facilita el diseño modular y la verificación independiente de cada etapa.
 
---
 
### 4.1 Sumador / Restador
 
| Parámetro  | Detalle                            |
|------------|------------------------------------|
| **Entradas** | `A[3:0]`, `B[3:0]`, `Op` (1 bit) |
| **Salida**   | `R[4:0]` (resultado con signo implícito) |
 
Este bloque realiza la operación aritmética entre los dos operandos de 4 bits. La señal de control `Op` determina la operación:
 
- `Op = 0` → **Suma:** `R = A + B`
- `Op = 1` → **Resta:** `R = A - B`
 
El resultado tiene **5 bits** para poder representar tanto el signo  como la magnitud completa. Por ejemplo, la resta puede producir resultados negativos que deben propagarse correctamente al siguiente bloque.
 

---
 
### 4.2 Detector de signo
 
| Parámetro  | Detalle                        |
|------------|--------------------------------|
| **Entrada**  | `R[4:0]`                     |
| **Salidas**  | `signo` (1 bit), `mag[4:0]` |
 
Este bloque analiza el resultado proveniente del sumador/restador y determina si es **positivo o negativo**.
 
- Si el resultado es **positivo**; la magnitud es `R` directamente.
- Si el resultado es **negativo**; la magnitud se obtiene calculando el **complemento a 2** de `R`.
 
La salida `signo` se usará al final para controlar el display del signo, mientras que `mag[4:0]` (la magnitud absoluta) se pasa al siguiente bloque para su procesamiento.

 
---
 
### 4.3 Cálculo de magnitud (Complemento a 2)
 
| Parámetro  | Detalle                              |
|------------|--------------------------------------|
| **Entradas** | `R[4:0]`, `signo`                  |
| **Salida**   | `mag[3:0]` (magnitud sin signo)    |
 
Cuando el resultado es negativo, su representación en complemento a 2 no corresponde directamente a la magnitud visual que queremos mostrar. Este bloque convierte el valor negativo a su equivalente positivo aplicando la operación:
 
```
mag = (~R + 1)
```
 
Si el resultado ya era positivo (`signo = 0`), la magnitud se toma directamente de los bits bajos de `R` sin modificación.
 
La salida de este bloque es siempre un número **positivo de 4 bits**, listo para convertirse a BCD.
 
> 💡 **Ejemplo:** Si `R = 11101` (−3 en complemento a 2), la magnitud calculada será `00011` (3 en binario puro).
 
---
 
### 4.4 Conversor Binario → BCD

| Parámetro  | Detalle |
|------------|--------|
| **Entrada** | `mag[4:0]` |
| **Salidas** | `decenas[3:0]`, `unidades[3:0]` |

Este bloque convierte un número binario en su representación **decimal codificada en BCD**, separando el resultado en dos dígitos independientes: **decenas** y **unidades**.

El valor de entrada representa la **magnitud del resultado de la operación aritmética** y se encuentra en formato binario.

La conversión debe cumplir la relación:

```
N = 10 × decenas + unidades
```
- `N` corresponde al valor binario de entrada  
- `decenas` representa el dígito decimal de las decenas  
- `unidades` representa el dígito decimal de las unidades  

Debido al rango de valores posibles del sistema, las **decenas** pueden tomar únicamente valores pequeños (por ejemplo 0, 1 o 2), mientras que las **unidades** corresponden al residuo de la división decimal.

El bloque debe generar dos códigos **BCD válidos**, los cuales serán utilizados posteriormente por el decodificador de siete segmentos para su visualización.

> Una posible forma de abordar este bloque es analizar el rango de valores posibles de la entrada y determinar qué valores corresponden a cada dígito decimal.
---
 
### 4.5 Decodificador BCD → 7 segmentos
 
| Parámetro  | Detalle                                              |
|------------|------------------------------------------------------|
| **Entrada**  | `digito[3:0]` (código BCD, 0–9)                    |
| **Salida**   | `seg[6:0]` (señales para segmentos a, b, c, d, e, f, g) |
 
Este bloque traduce un dígito BCD (0–9) en las señales de activación de los **7 segmentos** del display. Es esencialmente un bloque de lógica combinacional que implementa una tabla de verdad con 10 entradas válidas.
 
La correspondencia entre el dígito y los segmentos activos depende del tipo de display:
 
| Tipo de display     | Segmento activo con |
|---------------------|---------------------|
| **Cátodo común**    | `1` lógico          |
| **Ánodo común**     | `0` lógico          |
 
> ⚠️ **Importante:** Antes de implementar este bloque, verifica qué tipo de display está disponible en tu FPGA. Usar la polaridad incorrecta hará que los segmentos muestren el complemento del dígito esperado.
 
Las entradas de 1010 a 1111 son **inválidas en BCD** y pueden manejarse apagando todos los segmentos (`seg = 7'b0000000`) o mostrando un símbolo de error.
 
---
 
### 4.6 Display de signo
 
| Parámetro  | Detalle                              |
|------------|--------------------------------------|
| **Entrada**  | `signo` (1 bit)                    |
| **Salida**   | `seg_signo[6:0]`                   |
 
Este bloque controla un display dedicado únicamente a mostrar el **signo del resultado**:
 
- `signo = 0` → se encuentra apagado
- `signo = 1` → muestra `−` (solo el segmento `g` encendido)
 
---

## 5. Entregables

1. Descripción de hardware del sistema.

2. Documentación del ítem anterior en su respectivo archivo ```README.md```.

3. Realice la respectiva simulaciones y muestre evidencias en su archivo ```README.md```.

4. Implemente la descripción HDL en la tarjeta de desarrollo, empleando la ```IDE Quartus``` y muestre en el laboratorio el funcionamiento, empleando los periféricos que requiera.
