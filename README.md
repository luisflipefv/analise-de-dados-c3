# 🏠 House Prices — Data Analysis & Machine Learning

Projeto desenvolvido como avaliação da disciplina de **Data Analysis and Machine Learning** — FAESA Centro Universitário.

O objetivo é explorar o dataset de preços de casas nos Estados Unidos (Kaggle) aplicando técnicas de análise exploratória, feature engineering, aprendizado supervisionado e não supervisionado.

---

## 📂 Estrutura do Repositório

```
analise-de-dados-c3/
│
├── data/
│   ├── train.csv              # Dataset principal (Kaggle)
│   ├── test.csv               # Dataset de teste (Kaggle)
│   └── train_processed.csv    # Dataset processado pelo notebook 01
│
├── notebooks/
│   ├── 01_feature_engineering.ipynb  # EDA & Feature Engineering
│   ├── 02_regressao.ipynb            # Regressão Linear Simples e Múltipla
│   ├── 03_classificacao.ipynb        # Regressão Logística e Random Forest
│   ├── 04_clusterizacao.ipynb        # K-Means, PCA e t-SNE
│   ├── 05_associacao_outliers.ipynb  # Apriori e Local Outlier Factor
│   └── 06_visualizacao.ipynb         # Visualizações e Storytelling
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

---

## 🔬 Etapas do Projeto

### 1. EDA & Feature Engineering (`01_feature_engineering.ipynb`)
- Identificação de variáveis numéricas e categóricas
- Tratamento de valores nulos e outliers
- Criação de features derivadas: área total, área de varandas, banheiros totais, idade do imóvel, tempo desde reforma e indicadores de garagem, porão, lareira e piscina
- Normalização (`StandardScaler`) e codificação de categóricas (`OneHotEncoder`)
- Exportação do dataset processado em `data/train_processed.csv`

### 2. Regressão Linear (`02_regressao.ipynb`)
- Divisão treino/teste 80/20
- Regressão Linear Simples (`GrLivArea → SalePrice`)
- Regressão Linear Múltipla (top 10 features por correlação)
- Métricas: MAE, RMSE, R²
- Plots: Preditos vs Reais, Análise de Resíduos

### 3. Classificação (`03_classificacao.ipynb`)
- Criação de variável binária a partir do `SalePrice`
- Modelos: Regressão Logística e Random Forest
- Métricas: Accuracy, Precision, Recall, F1-Score, Matriz de Confusão

### 4. Clusterização & Redução de Dimensionalidade (`04_clusterizacao.ipynb`)
- Redução de dimensionalidade: PCA para 2 dimensões e t-SNE para visualização
- Clusterização: K-Means com Elbow Method e métrica de validação Silhouette Score
- Interpretação dos perfis de cada cluster

### 5. Regras de Associação & Outliers (`05_associacao_outliers.ipynb`)
- Binarização de features
- Algoritmo Apriori para regras de associação
- Local Outlier Factor (LOF) para detecção de anomalias

### 6. Visualização de Dados (`06_visualizacao.ipynb`)
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

# 2. Abra os notebooks em ordem (01 → 06)
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
