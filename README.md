
# Script de Verificación de Conectividad

Este script de bash (`verificar_conectividad.sh`) realiza un ping a una lista de direcciones IP y registra los resultados en un archivo de reporte. Además, muestra una barra de progreso para indicar el avance del proceso.

## Uso

1. Asegúrate de tener permisos de ejecución para el script:

```bash
sudo chmod +x check_connectivity.sh
```

2. Ejecuta el script:

```bash
sudo ./check_connectivity.sh
```

## Funcionamiento

El script sigue los siguientes pasos:

1. Define un archivo de reporte (reporte_conectividad.log) donde se guardarán los resultados.
2. Limpia el archivo de reporte anterior si existe.
3. Define un encabezado para la tabla en el archivo de reporte.
4. Define una lista de direcciones IP a verificar.
5. Realiza un ping a cada IP de la lista.
6. Muestra una barra de progreso para indicar el avance del proceso.
7. Registra el resultado de cada ping en el archivo de reporte.
8. Verifica si hubo errores y agrega el resultado final al archivo de reporte.
9. Muestra el contenido del archivo de reporte al finalizar.

## Requisitos

Bash (probado en versiones 4.x)
Utilidad ping disponible en el sistema.
Contribuciones
¡Las contribuciones son bienvenidas! Si encuentras un error o quieres mejorar el script, no dudes en abrir un issue o enviar un pull request.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.