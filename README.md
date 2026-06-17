# 🏠 House Prices — Data Analysis & Machine Learning

Projeto desenvolvido como avaliação da disciplina de **Data Analysis and Machine Learning** — FAESA Centro Universitário.

O objetivo é explorar o dataset de preços de casas nos Estados Unidos (Kaggle) aplicando técnicas de análise exploratória, feature engineering, aprendizado supervisionado e não supervisionado.

---

## 👥 Grupo

| Membro | Responsabilidade |
|--------|-----------------|
| Luis Felipe | Regressão Linear & Avaliação |
| Emanuel | Classificação (Regressão Logística / Random Forest) |
| Rogeres | Clusterização & Redução de Dimensionalidade |
| Alessandro | Regras de Associação & Detecção de Outliers |
| Natalia | Visualização de Dados & Storytelling |
| Vitor | Integração Final & Organização do GitHub |

---

## 📂 Estrutura do Repositório

```
house-prices-analysis/
│
├── data/
│   ├── train.csv              # Dataset principal (Kaggle)
│   └── test.csv               # Dataset de teste (Kaggle)
│
├── notebooks/
│   ├── 01_regressao.ipynb           # Regressão Linear + Classificação (Log. / Random Forest)
│   ├── 03_clusterizacao.ipynb       # K-Means, PCA e t-SNE
│   ├── 04_associacao_outliers.ipynb # Apriori e Local Outlier Factor
│   └── 05_visualizacao.ipynb        # Visualizações e Storytelling
│
├── plots/                     # Gráficos gerados pelos notebooks
│
└── README.md
```

---

## 📊 Dataset

**House Prices: Advanced Regression Techniques**  
Disponível em: [kaggle.com/c/house-prices-advanced-regression-techniques](https://www.kaggle.com/c/house-prices-advanced-regression-techniques/data)

O dataset contém **1.460 registros** e **81 variáveis** com características de casas vendidas em Ames, Iowa (EUA), incluindo área, qualidade, número de cômodos, ano de construção, entre outras.

> ⚠️ Os arquivos de dados **não estão incluídos** neste repositório. Faça o download diretamente pelo link acima e coloque os arquivos dentro da pasta `data/`.

---

## 🔬 Etapas do Projeto

### 1. Análise Exploratória & Feature Engineering
- Identificação de variáveis numéricas e categóricas
- Tratamento de valores nulos e outliers
- Criação e transformação de features

### 2. Regressão Linear (`01_regressao.ipynb`)
- Divisão treino/teste 80/20
- Regressão Linear Simples (`GrLivArea → SalePrice`)
- Regressão Linear Múltipla (top 10 features por correlação)
- Métricas: MAE, RMSE, R²
- Plots: Preditos vs Reais, Análise de Resíduos

### 3. Classificação (`01_regressao.ipynb`)
- Criação de variável binária a partir do `SalePrice`
- Modelos: Regressão Logística e Random Forest
- Métricas: Accuracy, Precision, Recall, F1-Score, Matriz de Confusão

### 4. Clusterização & Redução de Dimensionalidade (`03_clusterizacao.ipynb`)
- PCA para 2 dimensões
- t-SNE para visualização
- K-Means com Elbow Method
- Interpretação dos perfis de cada cluster

### 5. Regras de Associação & Outliers (`04_associacao_outliers.ipynb`)
- Binarização de features
- Algoritmo Apriori para regras de associação
- Local Outlier Factor (LOF) para detecção de anomalias

### 6. Visualização de Dados (`05_visualizacao.ipynb`)
- Distribuições, heatmaps e scatter plots
- Painel consolidado de métricas e clusters
- Storytelling da análise

---

## 🚀 Como Executar

### Pré-requisitos
- Python 3.8+
- Jupyter Notebook ou JupyterLab

### Instalação das dependências

```bash
pip install pandas numpy matplotlib seaborn scikit-learn mlxtend
```

### Passos

```bash
# 1. Clone o repositório
git clone https://github.com/luisflipefv/analise-de-dados-c3.git
cd analise-de-dados-c3

# 2. Baixe o dataset do Kaggle e coloque os arquivos em data/

# 3. Abra os notebooks em ordem
jupyter notebook
```

---

## 📦 Dependências

| Biblioteca | Uso |
|------------|-----|
| `pandas` | Manipulação de dados |
| `numpy` | Operações numéricas |
| `matplotlib` | Visualizações |
| `seaborn` | Visualizações estatísticas |
| `scikit-learn` | Modelos de ML e métricas |
| `mlxtend` | Algoritmo Apriori |

---

