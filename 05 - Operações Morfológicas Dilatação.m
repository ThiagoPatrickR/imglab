% Limpa a tela, as variáveis e fecha as janelas anteriores
clc; clear; close all;

% Carrega o pacote 'image' que contém funções para processamento de imagens
% Este pacote fornece ferramentas especializadas para manipulação e análise de imagens
pkg load image;

% Lê a imagem 'imagem_exemplo.jpg' e armazena na variável 'img'
% A função imread carrega a imagem do disco para a memória como uma matriz
img = imread('imagem_exemplo.png');

% Exibe a imagem original em uma nova janela
figure;
imshow(img);
title('Imagem Original Colorida');

% Converte a imagem para escala de cinza
% Reduz a imagem de 3 canais (RGB) para um único canal de intensidade
img_gray = rgb2gray(img);

% Converte a imagem em escala de cinza para binária usando um threshold de 0.5
% Pixels com valor acima de 0.5 (em uma escala normalizada de 0-1) se tornam brancos (1)
% Pixels com valor igual ou abaixo de 0.5 se tornam pretos (0)
img_bin = im2bw(img_gray, 0.5);

% Exibe a imagem binária em uma nova janela
figure;
imshow(img_bin);
title('Imagem Binária');

% Cria um elemento estruturante quadrado de tamanho 10x10 para a operação morfológica
% O elemento estruturante define a forma e o tamanho da vizinhança considerada
% durante a operação morfológica
se = strel('square', 10);

% Aplica a operação de dilatação na imagem binária usando o elemento estruturante definido
% A dilatação expande os objetos (regiões brancas) na imagem binária
% Um pixel se torna branco se qualquer pixel dentro da vizinhança definida pelo
% elemento estruturante for branco na imagem original
img_dilatada = imdilate(img_bin, se);

% Cria uma nova figura para exibir os resultados comparativos
figure;

% Configura a exibição para mostrar duas imagens lado a lado
% Primeiro subplot: imagem binária original
subplot(1,2,1);
imshow(img_bin);
title('Imagem Binária');

% Segundo subplot: imagem após a dilatação
subplot(1,2,2);
imshow(img_dilatada);
title('Após a Dilatação');
