"""
Proyecto: Retail Data Pipeline

Fase 3 - Validaciones Locales con Pandas

Objetivo:
- Validar lectura de archivos CSV y JSON.
- Verificar tipos de datos.
- Detectar valores nulos.
- Detectar registros duplicados.

Autor: William
"""

import pandas as pd

df_productos_csv = pd.read_csv(
    r"C:\Users\Ibrianna\Documents\retail-data-pipeline\data\bronze\productos.csv", 
    header = None,
    names = ["ProductoID", "Nombre_Pro", "Categoria", "Precio"])
df_clientes_json = pd.read_json(
    r"C:\Users\Ibrianna\Documents\retail-data-pipeline\data\bronze\clientes.json")
df_ventas_json = pd.read_json(
    r"C:\Users\Ibrianna\Documents\retail-data-pipeline\data\bronze\ventas.json")

print(df_productos_csv.head(),"\n")
print(df_clientes_json.head(),"\n")
print(df_ventas_json.head(),"\n")


print("========== INFO PRODUCTOS ==========","\n")
print(df_productos_csv.info(),"\n")

print("\n========== INFO CLIENTES ==========","\n")
print(df_clientes_json.info(),"\n")

print("\n========== INFO VENTAS ==========","\n")
print(df_ventas_json.info(),"\n")


print("\n========== NULOS PRODUCTOS =========="),"\n"
print(df_productos_csv.isnull().sum(),"\n")

print("\n========== NULOS CLIENTES ==========","\n")
print(df_clientes_json.isnull().sum(),"\n")

print("\n========== NULOS VENTAS ==========","\n")
print(df_ventas_json.isnull().sum(),"\n")

print("\n========== DUPLICADOS PRODUCTOS ==========","\n")
print(df_productos_csv.duplicated().sum(),"\n")

print("\n========== DUPLICADOS CLIENTES ==========","\n")
print(df_clientes_json.duplicated().sum(),"\n")

print("\n========== DUPLICADOS VENTAS ==========","\n")
print(df_ventas_json.duplicated().sum(),"\n")