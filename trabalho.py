from dash import Dash, html, dash_table, dcc, callback, Output, Input
import pandas as pd
import sqlite3

import plotly.express as px

def criaCaixa(titulo, vetor_total, cor):

    return html.Div([
        html.Div(titulo, style={
            'fontWeight': 'bold',
            'marginBottom': '10px'
        }),

        html.Ul([
         
            html.Li([
                " • Brasil", 
                html.Div(vetor_total[0], style = {'color': cor})
            ]), 

            html.Li([
                " • Estado de Minas Gerais", 
                html.Div(vetor_total[1], style = {'color': cor})
            ]), 

            html.Li([
                " • Cidade de Belo Horizonte", 
                html.Div(vetor_total[2], style = {'color': cor})
            ]), 

        ], style = {
            'listStyleType': 'none',
            'paddingLeft': '0',
            'fontSize': '12px'
        }),   
    ], 

    style={
        'border': '2px solid #007bff',
        'borderRadius': '15px',
        'padding': '10px',
        'width': '175px',
        'height': '175px',
        'fontFamily': 'Arial',
        'fontSize': '14px',
        'overflow': 'hidden',
        'display': 'flex',
        'flexDirection': 'column',
        'justifyContent': 'center',
        'alignItems': 'flex-start',
        'boxSizing': 'border-box',
        'marginRight': '20px'
    })  

banco_de_dados = sqlite3.connect("G2.db")

cidade = pd.read_sql_query("select * from Cidade;", banco_de_dados)
data = pd.read_sql_query("select * from Data", banco_de_dados)
estado = pd.read_sql_query("select * from Estado", banco_de_dados)
regiao = pd.read_sql_query("select * from Regiao", banco_de_dados)
data = pd.read_sql_query("select * from Data", banco_de_dados)
registro = pd.read_sql_query("select * from Registro", banco_de_dados)
minas_gerais = pd.read_sql_query("select * from MinasGerais", banco_de_dados)

#pegar o total de casos do Brasil
total_casos_Brasil = 0
for linha in registro.itertuples():

        if linha.tipo == 'state':
            total_casos_Brasil += linha.casosnovos



#pegar o total de casos do Estado e cidade de Minas Gerais
total_casos_estado = 0
total_casos_Belo_Horizonte = 0
for linha in minas_gerais.itertuples():
    
    if linha.nomelocalidade == 'Belo Horizonte':
        total_casos_Belo_Horizonte += linha.casosnovos
    
    total_casos_estado += linha.casosnovos


#Total de obitos

#a) Brasil

total_obitos_Brasil = 0
for linha in registro.itertuples():

    if linha.tipo == 'state':
        total_obitos_Brasil += linha.mortesnovas
    
#b) Estado de Minas Gerais e Cidade de Belo Horizonte

total_obitos_estado = 0
total_obitos_Belo_Horizonte = 0
for linha in minas_gerais.itertuples():
    
    if linha.nomelocalidade == 'Belo Horizonte':
        total_obitos_Belo_Horizonte += linha.mortesnovas
    
    total_obitos_estado += linha.mortesnovas



#Letalidade 

letalidade_Brasil = total_obitos_Brasil / total_casos_Brasil

letalidade_Estado_Minas_Gerais = total_obitos_estado / total_casos_estado

letalidade_Belo_Horizonte = total_obitos_Belo_Horizonte / total_casos_Belo_Horizonte


#Mortalidade 

total_habitantes_Brasil = 0

for linha in cidade.itertuples():
    
    if len(str(linha.codigoibge)) == 2:
        total_habitantes_Brasil += int(linha.populacao)

mortalidade_Brasil = total_obitos_Brasil / total_habitantes_Brasil

total_habitantes_Estado_Minas_Gerais = minas_gerais[(minas_gerais['tipo'] == 'state')]
total_habitantes_Estado_Minas_Gerais = total_habitantes_Estado_Minas_Gerais['populacao'].values[0]

mortalidade_Estado_Minas_Gerais = total_obitos_estado / total_habitantes_Estado_Minas_Gerais

total_habitantes_Cidade_BeloHorizonte = minas_gerais[((minas_gerais['nomelocalidade'] == 'Belo Horizonte'))]
total_habitantes_Cidade_BeloHorizonte = total_habitantes_Cidade_BeloHorizonte['populacao'].values[0]

mortalidade_Cidade_BeloHorizonte = total_obitos_Belo_Horizonte / total_habitantes_Cidade_BeloHorizonte

vetor_total_casos_novos = [total_casos_Brasil, total_casos_estado, total_casos_Belo_Horizonte]
vetor_total_obitos = [total_obitos_Brasil, total_obitos_estado, total_obitos_Belo_Horizonte]
vetor_letalidade = [letalidade_Brasil, letalidade_Estado_Minas_Gerais, letalidade_Belo_Horizonte]
vetor_mortalidade = [mortalidade_Brasil, mortalidade_Estado_Minas_Gerais, mortalidade_Cidade_BeloHorizonte]

banco_de_dados.close()

app = Dash(__name__)

app.layout = html.Div([

    html.Div([
        criaCaixa("Total de casos confirmados", vetor_total_casos_novos, 'blue'),
        criaCaixa("Total de óbitos", vetor_total_obitos, 'gold'), 
        criaCaixa("Letalidade", vetor_letalidade, 'purple'), 
        criaCaixa("Mortalidade", vetor_mortalidade, 'red')
    ], style={
        'display': 'flex',
        'flexDirection': 'row'
    })

])
  
'''
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
'''

if __name__ == '__main__':
  app.run(debug=True)

#Aumentar o tamanho das caixas
#Arrendondar os valores de letalidade e mortalidade
