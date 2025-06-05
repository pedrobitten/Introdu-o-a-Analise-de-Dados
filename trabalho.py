
from dash import Dash, html, dash_table, dcc, callback, Output, Input
import pandas as pd
import sqlite3
import os
import plotly.express as px

#os.chdir("C:\\Users\\c2111415\\Documents\\introducao a analise de dados\\Trabalho")

banco_de_dados = sqlite3.connect("G2.db")
cidade = pd.read_sql_query("select * from Cidade;", banco_de_dados)
data = pd.read_sql_query("select * from Data", banco_de_dados)
estado = pd.read_sql_query("select * from Estado", banco_de_dados)
regiao = pd.read_sql_query("select * from Regiao", banco_de_dados)
data = pd.read_sql_query("select * from Data", banco_de_dados)
registro = pd.read_sql_query("select * from Registro", banco_de_dados)
minas_gerais = pd.read_sql_query("select * from MinasGerais", banco_de_dados)

#pegar o total de casos do Brasil
total_casos_Brasil = sum(registro['casosnovos'])

#pegar o total de casos do Estado e cidade de Minas Gerais
total_casos_estado = 0
total_casos_Belo_Horizonte = 0
for linha in minas_gerais.itertuples():
    
    if linha.nomelocalidade == 'Belo Horizonte':
        total_casos_Belo_Horizonte += int(linha.casosnovos)
    
    else: 
        total_casos_estado += int(linha.casosnovos)

#print(f"Total de casos confirmados no Brasil: {total_casos_Brasil}")
#print(f"Total de casos confirmados nos estados de Minas Gerais: {total_casos_estado}")
#print(f"Total de casos confirmados na cidade de Belo Horizonte: {total_casos_Belo_Horizonte}")

#Total de obitos

#a) Brasil

total_obitos_Brasil = sum(registro['mortesnovas'])

#b) Estado de Minas Gerais e Cidade de Belo Horizonte

total_obitos_estado = 0
total_obitos_Belo_Horizonte = 0
for linha in minas_gerais.itertuples():
    
    if linha.nomelocalidade == 'Belo Horizonte':
        total_obitos_Belo_Horizonte += int(linha.mortesnovas)
    
    else: 
        total_obitos_estado += int(linha.mortesnovas)

#print(f"Total de obitos confirmados no Brasil: {total_obitos_Brasil}")
#print(f"Total de obitos confirmados nos estados de Minas Gerais: {total_obitos_estado}")
#print(f"Total de obitos confirmados na cidade de Belo Horizonte: {total_obitos_Belo_Horizonte}")

#Letalidade 

letalidade_Brasil = total_obitos_Brasil / total_casos_Brasil
#print(letalidade_Brasil)
letalidade_Estado_Minas_Gerais = total_obitos_estado / total_casos_estado
#print(letalidade_Estado_Minas_Gerais)
letalidade_Belo_Horizonte = total_obitos_Belo_Horizonte / total_casos_Belo_Horizonte
#print(letalidade_Belo_Horizonte)

#Mortalidade 

total_habitantes_Brasil = 0

for linha in cidade.itertuples():
    
    if len(str(linha.codigoibge)) == 2:
        total_habitantes_Brasil += int(linha.populacao)

mortalidade_Brasil = total_obitos_Brasil / total_habitantes_Brasil

total_habitantes_Estado_Minas_Gerais = cidade[(cidade['uf'] == 'MG') and (cidade['nomelocalidade'] == None)]
print(total_habitantes_Estado_Minas_Gerais) 
# filtrar total_habitantes_Cidade_Belo_Horizonte = 0

for linha in minas_gerais.itertuples():
    
    if linha.tipo == 2:
        total_habitantes_Brasil += int(linha.populacao)

banco_de_dados.close()

app = Dash(__name__)

app.layout = [
  html.Div([
     html.H2("Escolha o dashboard"), 
     dcc.Dropdown(
        id = 'dashboard-selector', 
        options=[
           {'label': 'Cidade', 'value': 'cidade'}, 
           {'label': 'Registro', 'value': 'registro'}
        ],
        value = 'cidade'
     ), 
     dcc.Graph(id = 'grafico_principal')
  ]),
  #html.Hr(),
  #dcc.RadioItems(options = ['nomelocalidade', 'uf'], value = 'nomelocalidade', id = 'controls-and-radio-item'), 
  #dash_table.DataTable(data = cidade.to_dict('records'), page_size=6),
  
  #dcc.Graph(figure={}, id='controls-and-graph')
]

@callback(
    Output(component_id='grafico_principal', component_property='figure'),
    Input(component_id='dashboard-selector', component_property='value')
)
def update_graph(dashboard_selecionado):

    if dashboard_selecionado == 'cidade':
        fig = px.histogram(cidade, x='nomelocalidade', y='populacao', histfunc='avg', title='População por Localidade')
    elif dashboard_selecionado == 'registro':
        fig = px.histogram(registro, x='tipo', y='casosnovos', histfunc = 'sum',title='Quantidade por Categoria')
    else:
        fig = px.scatter()


    #fig = px.histogram(cidade, x=row_chosen, y='populacao', histfunc='avg')
    return fig

if __name__ == '__main__':
  app.run(debug=True)

