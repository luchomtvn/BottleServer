__author__ = 'Ignacio'

import MySQLdb

from helpers.dato_db import *
from helpers.dato_bd_log import *

pila_medicion = []
pila_comando = []

def cargar_comand_log(valor,respuesta):
    db = MySQLdb.connect("localhost", "ignacio", "mantosamba", "SensorCampoElectroEstatico")
    curs = db.cursor()
    curs.execute("""INSERT INTO comandlog
        values(CURRENT_DATE(), NOW(),%s, %s)""", (valor, respuesta,))
    db.commit()
    db.close()

def cargar_medicion(timestamp, pin, valor):
    db = MySQLdb.connect("localhost", "ignacio", "mantosamba", "SensorCampoElectroEstatico")
    curs = db.cursor()
    curs.execute("""INSERT INTO medicion
            values(%s, %s,%s)""", (timestamp, pin, valor,))
    db.commit()
    db.close()

def cargar_desde_bd_medicion():
    db = MySQLdb.connect("localhost", "ignacio", "mantosamba", "SensorCampoElectroEstatico")
    curs = db.cursor()
    curs.execute("SELECT * FROM medicion")
    dato_medicion_viejo = Dato_db(0, 0, 0)
    for (hora, pin, medicion) in curs:
        dato_medicion = Dato_db(hora, pin, medicion)
        if dato_medicion.hora != dato_medicion_viejo.hora:
            pila_medicion.append(dato_medicion)
        dato_medicion_viejo = dato_medicion
    curs.close()
    return pila_medicion

def cargar_desde_bd_comando():

    db = MySQLdb.connect("localhost", "ignacio", "mantosamba", "SensorCampoElectroEstatico")
    curs = db.cursor()
    curs.execute("SELECT * FROM comandlog")
    dato_comando_viejo = Dato_db_log(0, 0, 0, 0)
    for (fecha, hora, comando, respuesta) in curs:
        dato_comando = Dato_db_log(fecha, hora, comando, respuesta)
        if dato_comando.hora != dato_comando_viejo.hora:
            pila_comando.append(dato_comando)
        dato_comando_viejo = dato_comando
    curs.close()
    return pila_comando

