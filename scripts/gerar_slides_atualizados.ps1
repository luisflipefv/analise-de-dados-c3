$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$SlidesDir = Join-Path $Root "slides"
$PlotDir = Join-Path $Root "plots"
$OutPath = Join-Path $SlidesDir "apresentacao_house_prices_c3.pptx"

if (-not (Test-Path $SlidesDir)) {
    New-Item -ItemType Directory -Force -Path $SlidesDir | Out-Null
}

function Rgb($r, $g, $b) { return ($r + ($g * 256) + ($b * 65536)) }

$Navy = Rgb 22 43 58
$Teal = Rgb 38 137 132
$Orange = Rgb 232 126 66
$Green = Rgb 88 156 102
$Gray = Rgb 88 95 105
$Light = Rgb 246 248 250
$White = Rgb 255 255 255
$Dark = Rgb 30 34 39
$Line = Rgb 220 224 228

function Add-Box($slide, $x, $y, $w, $h, $fill, $lineColor = $null) {
    $shape = $slide.Shapes.AddShape(1, $x, $y, $w, $h)
    $shape.Fill.ForeColor.RGB = $fill
    if ($null -eq $lineColor) { $shape.Line.Visible = 0 } else { $shape.Line.ForeColor.RGB = $lineColor }
    return $shape
}

function Add-Text($slide, $text, $x, $y, $w, $h, $size = 22, $bold = $false, $color = $Dark, $align = 1) {
    $shape = $slide.Shapes.AddTextbox(1, $x, $y, $w, $h)
    $range = $shape.TextFrame.TextRange
    $range.Text = $text
    $range.Font.Name = "Aptos"
    $range.Font.Size = $size
    $range.Font.Bold = $(if ($bold) { -1 } else { 0 })
    $range.Font.Color.RGB = $color
    $range.ParagraphFormat.Alignment = $align
    $shape.TextFrame.MarginLeft = 4
    $shape.TextFrame.MarginRight = 4
    $shape.TextFrame.MarginTop = 2
    $shape.TextFrame.MarginBottom = 2
    return $shape
}

function Add-Title($slide, $title, $subtitle = "") {
    Add-Box $slide 0 0 960 58 $Navy | Out-Null
    Add-Text $slide $title 28 10 680 34 24 $true $White 1 | Out-Null
    if ($subtitle.Length -gt 0) {
        Add-Text $slide $subtitle 690 15 242 26 12 $false $White 3 | Out-Null
    }
}

function Add-Bullets($slide, $items, $x, $y, $w, $h, $size = 19, $color = $Dark) {
    $shape = Add-Text $slide ($items -join "`r") $x $y $w $h $size $false $color 1
    for ($i = 1; $i -le $shape.TextFrame.TextRange.Paragraphs().Count; $i++) {
        $p = $shape.TextFrame.TextRange.Paragraphs($i)
        $p.ParagraphFormat.Bullet.Visible = -1
        $p.ParagraphFormat.Bullet.Character = 8226
        $p.ParagraphFormat.SpaceAfter = 7
    }
    return $shape
}

function Add-Kpi($slide, $label, $value, $x, $y, $w, $accent) {
    Add-Box $slide $x $y $w 88 $Light $Line | Out-Null
    Add-Text $slide $value ($x + 10) ($y + 9) ($w - 20) 34 25 $true $accent 2 | Out-Null
    Add-Text $slide $label ($x + 10) ($y + 49) ($w - 20) 28 12 $false $Gray 2 | Out-Null
}

function Add-PictureFit($slide, $path, $x, $y, $maxW, $maxH) {
    if (-not (Test-Path $path)) { return $null }
    $pic = $slide.Shapes.AddPicture($path, 0, -1, $x, $y)
    $scaleW = $maxW / $pic.Width
    $scaleH = $maxH / $pic.Height
    $scale = [Math]::Min($scaleW, $scaleH)
    $pic.Width = $pic.Width * $scale
    $pic.Height = $pic.Height * $scale
    $pic.Left = $x + (($maxW - $pic.Width) / 2)
    $pic.Top = $y + (($maxH - $pic.Height) / 2)
    return $pic
}

function Add-Notes($slide, $text) {
    try { $slide.NotesPage.Shapes.Placeholders(2).TextFrame.TextRange.Text = $text } catch {}
}

$pp = New-Object -ComObject PowerPoint.Application
$pp.Visible = 1
$pres = $pp.Presentations.Add()
$pres.PageSetup.SlideWidth = 960
$pres.PageSetup.SlideHeight = 540

function New-Slide($Title, $Subtitle = "") {
    $slide = $pres.Slides.Add($pres.Slides.Count + 1, 12)
    $slide.FollowMasterBackground = 0
    $slide.Background.Fill.ForeColor.RGB = $White
    Add-Title $slide $Title $Subtitle
    return $slide
}

$s = New-Slide "House Prices: Data Analysis & Machine Learning" "10-15 min"
Add-Text $s "Análise de preços de casas nos EUA usando EDA, feature engineering, modelos supervisionados e não supervisionados." 80 122 800 82 26 $true $Navy 2 | Out-Null
Add-Kpi $s "registros após tratamento" "1458" 105 260 180 $Teal
Add-Kpi $s "features processadas" "298" 300 260 180 $Orange
Add-Kpi $s "R² regressão múltipla" "0,817" 495 260 180 $Green
Add-Kpi $s "acurácia classificação" "92,1%" 690 260 180 $Teal
Add-Text $s "Grupo: Vitor, Luis Felipe, Emanuel, Rogeres, Alessandro e Natalia" 100 435 760 34 17 $false $Gray 2 | Out-Null
Add-Notes $s "Vitor abre com a pergunta central: quais características ajudam a explicar e prever o preço das casas?"

$s = New-Slide "Divisão do Grupo" "responsabilidades"
$rows = @(
    @("Vitor", "EDA, Feature Engineering, integração e organização"),
    @("Luis Felipe", "Regressão linear simples e múltipla"),
    @("Emanuel", "Classificação: Regressão Logística e Random Forest"),
    @("Rogeres", "Clusterização, PCA e t-SNE"),
    @("Alessandro", "Apriori e Local Outlier Factor"),
    @("Natalia", "Visualização de dados e storytelling")
)
$y = 105
foreach ($row in $rows) {
    Add-Box $s 80 $y 160 42 $Light $Line | Out-Null
    Add-Text $s $row[0] 92 ($y + 8) 136 24 18 $true $Navy 2 | Out-Null
    Add-Text $s $row[1] 270 ($y + 6) 600 28 18 $false $Dark 1 | Out-Null
    $y += 58
}
Add-Notes $s "Explicar que a fala é dividida por etapa, mas a narrativa é única."

$s = New-Slide "Fluxo Analítico" "do dado bruto à conclusão"
$steps = @(
    @("1", "EDA e limpeza", $Teal),
    @("2", "Feature engineering", $Orange),
    @("3", "Regressão", $Green),
    @("4", "Classificação", $Teal),
    @("5", "Clusterização", $Orange),
    @("6", "Associação, outliers e storytelling", $Green)
)
$x = 55
foreach ($step in $steps) {
    Add-Box $s $x 150 130 130 $Light $Line | Out-Null
    Add-Text $s $step[0] ($x + 40) 170 50 42 30 $true $step[2] 2 | Out-Null
    Add-Text $s $step[1] ($x + 12) 220 106 45 16 $true $Navy 2 | Out-Null
    $x += 148
}
Add-Text $s "Pergunta-guia: quais fatores estruturais e qualitativos explicam ou predizem o preço de venda?" 90 360 780 60 24 $true $Navy 2 | Out-Null
Add-Notes $s "Fazer a ponte para a limpeza e preparação dos dados."

$s = New-Slide "EDA e Preparação dos Dados" "Vitor"
Add-Bullets $s @(
    "Base original: 1460 linhas e 81 variáveis",
    "Alvo do problema: SalePrice",
    "Tratamento de nulos por mediana/moda",
    "Remoção de outliers em GrLivArea x SalePrice",
    "Normalização de numéricas e One-Hot Encoding de categóricas"
) 58 95 390 320 19 | Out-Null
Add-PictureFit $s (Join-Path $PlotDir "plot_distribuicao_saleprice.png") 485 90 405 180 | Out-Null
Add-PictureFit $s (Join-Path $PlotDir "plot_scatter_area_preco.png") 485 300 405 170 | Out-Null
Add-Notes $s "Vitor: enfatizar que a análise começa entendendo distribuição, nulos, outliers e relações iniciais."

$s = New-Slide "Feature Engineering" "Vitor"
Add-Bullets $s @(
    "TotalSF: área total combinando porão e pavimentos",
    "TotalBathrooms: banheiros completos e lavabos",
    "HouseAge e YearsSinceRemodel: idade e atualização",
    "HasGarage, HasBasement, HasFireplace e HasPool: atributos estruturais",
    "Base processada final: 1458 linhas x 298 colunas"
) 62 100 430 335 19 | Out-Null
Add-Box $s 540 115 310 225 $Light $Line | Out-Null
Add-Text $s "Por que isso importa?" 570 145 250 32 24 $true $Navy 2 | Out-Null
Add-Text $s "As novas variáveis condensam sinais imobiliários: tamanho, conforto, idade, conservação e estruturas valorizadas." 575 205 240 110 20 $false $Dark 2 | Out-Null
Add-Notes $s "Explicar que as novas features aproximam o dataset da lógica imobiliária."

$s = New-Slide "Regressão: Prever o Preço" "Luis Felipe"
Add-Kpi $s "R² regressão simples" "0,492" 60 100 170 $Orange
Add-Kpi $s "R² regressão múltipla" "0,817" 250 100 170 $Green
Add-Bullets $s @(
    "Modelo simples: GrLivArea -> SalePrice",
    "Modelo múltiplo: top 10 features por correlação",
    "TotalSF e TotalBathrooms aparecem entre os principais preditores",
    "Métricas: MAE, RMSE e R²"
) 60 230 360 210 18 | Out-Null
Add-PictureFit $s (Join-Path $PlotDir "plot_comparacao_metricas.png") 465 88 410 190 | Out-Null
Add-PictureFit $s (Join-Path $PlotDir "plot_preditos_vs_reais.png") 465 305 410 155 | Out-Null
Add-Notes $s "Luis Felipe: explicar que múltiplas variáveis capturam muito mais do que apenas área habitável."

$s = New-Slide "Classificação: Casa Cara ou Barata" "Emanuel"
Add-Bullets $s @(
    "SalePrice convertido em classe binária pela mediana",
    "0 = abaixo da mediana; 1 = acima da mediana",
    "Modelos: Regressão Logística e Random Forest",
    "Métricas: Accuracy, Precision, Recall, F1 e matriz de confusão"
) 60 95 390 220 19 | Out-Null
Add-Kpi $s "Accuracy Reg. Logística" "92,1%" 70 345 175 $Teal
Add-Kpi $s "F1 Reg. Logística" "0,922" 270 345 175 $Green
Add-PictureFit $s (Join-Path $PlotDir "plot_comparativo_metricas_clf.png") 500 92 360 170 | Out-Null
Add-PictureFit $s (Join-Path $PlotDir "plot_confusion_matrix.png") 500 305 360 155 | Out-Null
Add-Notes $s "Emanuel: destacar que as classes ficaram balanceadas e os modelos performaram bem."

$s = New-Slide "Clusterização e Redução de Dimensionalidade" "Rogeres"
Add-Bullets $s @(
    "K-Means para perfis de imóveis sem usar preço no treino",
    "Elbow Method apoiou a escolha de k",
    "PCA e t-SNE para visualização em 2D",
    "PCA explicou 29,5% da variância nas duas primeiras componentes",
    "Silhouette Score: 0,1520, positivo mas com sobreposição natural"
) 50 92 390 330 18 | Out-Null
Add-PictureFit $s (Join-Path $PlotDir "plot_resultados_clusterizacao.png") 475 90 395 295 | Out-Null
Add-Notes $s "Rogeres: ressaltar que PCA é visualização, não substitui a base completa."

$s = New-Slide "Associação e Outliers" "Alessandro"
Add-Bullets $s @(
    "Apriori exigiu binarização em tags interpretáveis",
    "Regras avaliadas por suporte, confiança e lift",
    "Associações fortes envolvem casas grandes, bairros premium e garagens maiores",
    "LOF identificou 73 outliers, cerca de 5% da base",
    "Outliers ajudam a entender casos extremos"
) 55 92 395 335 18 | Out-Null
Add-PictureFit $s (Join-Path $PlotDir "plot_resultados_associacao_outliers.png") 490 95 380 285 | Out-Null
Add-Notes $s "Alessandro: conectar Apriori e LOF com interpretação de padrões e anomalias."

$s = New-Slide "Notebook 06: Resultados Consolidados" "Natalia"
Add-Bullets $s @(
    "Nova seção reúne os resultados dos modelos em painéis visuais",
    "Supervisionados: regressão e classificação no mesmo fluxo",
    "Não supervisionados: clusters, PCA/t-SNE e perfis médios",
    "Associação e outliers: Apriori e LOF em visão consolidada",
    "Placeholders removidos e conclusão executiva atualizada"
) 54 92 350 340 18 | Out-Null
Add-PictureFit $s (Join-Path $PlotDir "plot_resultados_supervisionados.png") 440 84 410 165 | Out-Null
Add-PictureFit $s (Join-Path $PlotDir "plot_painel_consolidado.png") 440 292 410 160 | Out-Null
Add-Notes $s "Natalia: explicar que esse slide responde diretamente ao feedback da avaliação: faltavam gráficos dos modelos no notebook 06."

$s = New-Slide "Visualização e Storytelling" "Natalia"
Add-Bullets $s @(
    "Distribuições mostram assimetria à direita em SalePrice",
    "Heatmap confirma variáveis ligadas ao preço",
    "Scatter e boxplot reforçam impacto de área e qualidade",
    "Parte 5 conecta modelos supervisionados, clusters, Apriori e LOF",
    "Conclusão final sintetiza o raciocínio analítico do projeto"
) 58 95 370 280 19 | Out-Null
Add-PictureFit $s (Join-Path $PlotDir "plot_heatmap_correlacoes.png") 465 80 390 190 | Out-Null
Add-Text $s "Mensagem central: preço é resultado da combinação entre tamanho, qualidade, estrutura e idade do imóvel." 85 390 770 58 24 $true $Navy 2 | Out-Null
Add-Notes $s "Natalia: reforçar que visualização é usada para guiar o leitor, não apenas ilustrar."

$s = New-Slide "Conclusões Principais" "fechamento"
Add-Kpi $s "base final" "1458 x 298" 65 95 190 $Teal
Add-Kpi $s "R² regressão" "0,817" 285 95 170 $Green
Add-Kpi $s "accuracy classificação" "92,1%" 485 95 190 $Orange
Add-Kpi $s "outliers LOF" "73" 705 95 150 $Teal
Add-Bullets $s @(
    "Todos os critérios técnicos foram contemplados",
    "Notebook 06 agora inclui gráficos consolidados dos modelos",
    "Storytelling foi atualizado sem placeholders",
    "Feature engineering aparece nos modelos e na interpretação",
    "O preço é explicado por tamanho, qualidade, estrutura, idade e conservação"
) 105 250 750 190 20 | Out-Null
Add-Notes $s "Fechamento: mencionar que a última rodada de ajustes mira exatamente os descontos da avaliação: visualização e storytelling."

$s = New-Slide "Perguntas" "obrigado"
Add-Text $s "Obrigado!" 80 145 800 70 44 $true $Navy 2 | Out-Null
Add-Text $s "Estamos à disposição para perguntas." 130 240 700 45 28 $false $Gray 2 | Out-Null
Add-Box $s 220 345 520 58 $Light $Line | Out-Null
Add-Text $s "Resposta rápida: Silhouette baixo é esperado em dados imobiliários com sobreposição, mas os clusters ainda têm perfis médios interpretáveis." 245 356 470 34 14 $false $Dark 2 | Out-Null
Add-Notes $s "Backup: explicar PCA como visualização, SalePrice fora do treino dos clusters e importância do feature engineering."

if (Test-Path $OutPath) {
    Remove-Item -LiteralPath $OutPath -Force
}
$pres.SaveAs($OutPath)
$pres.Close()
$pp.Quit()

Write-Output "Slides atualizados em: $OutPath"
