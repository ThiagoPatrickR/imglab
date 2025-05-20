% Limpa a tela, removendo todos os textos e comandos anteriores da janela de comandos
clc;

% Limpa todas as variáveis do workspace, liberando memória
clear;

% Fecha todas as janelas de figuras que possam estar abertas de execuções anteriores
close all;

% Carrega o pacote de processamento de imagens, necessário para as funções especializadas
% É um módulo adicional do Octave que precisa ser carregado explicitamente
pkg load image;

% Lê a imagem com ruído sal e pimenta do diretório atual
% A função imread carrega a imagem e armazena como uma matriz 3D (para RGB) na variável img
img = imread('sal_pimenta.jpg');

% Converte a imagem RGB para escala de cinza
% A função rgb2gray aplica pesos específicos para cada canal de cor (R,G,B)
% e gera uma matriz 2D representando a imagem em tons de cinza
img_gray = rgb2gray(img);

% Cria um filtro gaussiano com tamanho 5x5 e desvio padrão (sigma) de 1.0
% A função fspecial gera matrizes que representam filtros espaciais para processamento de imagem
% 'gaussian' indica um filtro baseado na função gaussiana, que dá mais peso aos pixels centrais
% e menos peso aos pixels mais distantes, seguindo uma distribuição normal
h_gaussian = fspecial('gaussian', [5 5], 1.0);

% Aplica o filtro gaussiano na imagem em escala de cinza
% A função imfilter realiza a convolução entre a imagem e o filtro
% Para cada pixel, o novo valor é uma média ponderada dos pixels vizinhos,
% onde os pesos são determinados pela distribuição gaussiana
img_filtrada_gaussian = imfilter(img_gray, h_gaussian);

% Cria um layout com 1 linha e 2 colunas de subplots (gráficos)
% Seleciona o primeiro subplot (posição 1) para mostrar a imagem original
subplot(1,2,1);

% Exibe a imagem em escala de cinza no subplot selecionado
% imshow normaliza automaticamente os valores para exibição adequada
imshow(img_gray);

% Adiciona um título ao subplot atual
title('Original (Cinza)');

% Seleciona o segundo subplot (posição 2) para mostrar a imagem filtrada
subplot(1,2,2);

% Exibe a imagem após a aplicação do filtro gaussiano
imshow(img_filtrada_gaussian);

% Adiciona um título ao segundo subplot
title('Filtrada (Gaussiana 5x5, \sigma=1.0)');

% Nota: O filtro gaussiano é mais eficaz que o filtro de média para preservar
% bordas enquanto remove o ruído, pois dá mais peso aos pixels centrais
% e diminui gradualmente o peso para pixels mais afastados
