% Limpa a tela, as variáveis e fecha as janelas anteriores
clc; clear; close all;

% Carrega o pacote de processamento de imagens
% Este pacote fornece funções especializadas para manipulação de imagens
pkg load image;

% ----------------------------------------------------
% ⿡ Leitura da imagem
% ----------------------------------------------------
% A função imread() lê uma imagem do disco
% A imagem é carregada como uma matriz tridimensional (altura x largura x 3)
% Cada canal representa os componentes R (vermelho), G (verde) e B (azul)
img_rgb = imread('imagem_exemplo.png');

% ----------------------------------------------------
% ⿢ Exibição da imagem original (colorida)
% ----------------------------------------------------
% Cria uma nova janela (figura) para exibir a imagem
figure;

% A função imshow() exibe a imagem na tela
% O Octave normaliza automaticamente os valores para visualização adequada
imshow(img_rgb);

% Adiciona um título à figura atual
% Aparece na parte superior da janela de figura
title('Imagem Colorida (RGB)');

% ----------------------------------------------------
% ⿣ Conversão para escala de cinza
% ----------------------------------------------------
% A função rgb2gray() converte a imagem RGB em uma imagem com tons de cinza
% Ela aplica a fórmula: Gray = 0.2989*R + 0.5870*G + 0.1140*B
% Esta fórmula considera a sensibilidade do olho humano às diferentes cores
% O verde tem maior peso porque o olho humano é mais sensível a esta cor
img_gray = rgb2gray(img_rgb);

% ----------------------------------------------------
% ⿤ Exibição da imagem em escala de cinza
% ----------------------------------------------------
% Cria uma nova janela separada para a imagem em escala de cinza
figure;

% Exibe a imagem em escala de cinza na nova janela
% Agora img_gray é uma matriz 2D (altura x largura) contendo valores de intensidade
imshow(img_gray);

% Adiciona um título à imagem em escala de cinza
title('Imagem em Escala de Cinza');
