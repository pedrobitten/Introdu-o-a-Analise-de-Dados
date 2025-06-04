
from dash import Dash, html, dash_table, dcc
import pandas as pd
import sqlite3
import os
import plotly.express as px

os.chdir("C:\\Users\\c2111415\\Documents\\introducao a analise de dados\\Trabalho")

banco_de_dados = sqlite3.connect("G2.db")
cidade = pd.read_sql_query("select * from Cidade;", banco_de_dados)
data = pd.read_sql_query("select * from Data", banco_de_dados)
estado = pd.read_sql_query("select * from Estado", banco_de_dados)
regiao = pd.read_sql_query("select * from Regiao", banco_de_dados)
data = pd.read_sql_query("select * from Data", banco_de_dados)
registro = pd.read_sql_query("select * from Registro", banco_de_dados)

banco_de_dados.close()

app = Dash(__name__)

app.layout = [
  html.Div(children = "Usando a tabela cidade"), 
  dash_table.DataTable(data = cidade.to_dict('records'), page_size=10),
  dcc.Graph(figure=px.histogram(cidade, x='uf', y='populacao', histfunc='sum')),
  dcc.Graph(figure=px.histogram(cidade, x='nomelocalidade', y='populacao', histfunc='sum'))
]

if __name__ == '__main__':
  app.run(debug=True)

