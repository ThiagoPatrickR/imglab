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

% Cria um filtro de média (média aritmética) com tamanho 5x5
% A função fspecial gera matrizes que representam filtros espaciais para processamento de imagem
% 'average' indica um filtro onde cada elemento tem valor 1/25 (=1/tamanho da matriz)
h = fspecial('average', [5 5]);

% Aplica o filtro de média na imagem em escala de cinza
% A função imfilter realiza a convolução entre a imagem e o filtro
% Para cada pixel, o valor é substituído pela média dos valores em uma vizinhança 5x5
img_filtrada = imfilter(img_gray, h);

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

% Exibe a imagem após a aplicação do filtro de média
imshow(img_filtrada);

% Adiciona um título ao segundo subplot
title('Filtrada (Média 5x5)');

% Nota: O ponto-e-vírgula (;) no final de cada linha suprime a saída do comando no console
% Se removidos, o Octave imprimiria os valores resultantes de cada operação
