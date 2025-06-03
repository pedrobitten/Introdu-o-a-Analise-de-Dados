
from dash import Dash, html, dcc, callback, Output, Input
import pandas as pd
#import os
import plotly.express as px

#os.chdir("C:\\Users\\c2111415\\Documents\\introducao a analise de dados\\Trabalho")
regiao = pd.read_csv("estado.csv")
estado = pd.read_csv("regiao.csv")

#df =  pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/gapminder_unfiltered.csv')

print(regiao)

""""
app = Dash(__name__)

app.layout = [
    html.H1(children='Title of Dash App', style={'textAlign':'center'}),
    dcc.Dropdown(df.country.unique(), 'Canada', id='dropdown-selection'),
    dcc.Graph(id='graph-content')
]

@callback(
    Output('graph-content', 'figure'),
    Input('dropdown-selection', 'value')
)
def update_graph(value):
    dff = df[df.country==value]
    return px.line(dff, x='year', y='pop')

# IMPORTANTE: sem o reloader!
if __name__ == '__main__':
    app.run(debug=True, use_reloader=False)
"""

