% Limpa a tela, as variáveis e fecha as janelas anteriores
clc; clear; close all;

% Carrega o pacote 'image' que contém funções para processamento de imagens
% Este pacote não vem habilitado por padrão no Octave e precisa ser carregado explicitamente
pkg load image;

% Lê a imagem 'imagem_exemplo.jpg' e armazena na variável 'img'
% A função imread carrega a imagem do disco como uma matriz de pixels
img = imread('imagem_exemplo.png');

% Exibe a imagem original em uma nova janela
figure;
imshow(img);
title('Imagem Original Colorida');

% Converte a imagem para escala de cinza
% A matriz 3D (RGB) é convertida para uma matriz 2D de intensidades
img_gray = rgb2gray(img);

% Converte a imagem em escala de cinza para binária usando um threshold de 0.5
% Pixels com intensidade maior que 0.5 (em escala 0-1) se tornam brancos (1)
% Pixels com intensidade menor ou igual a 0.5 se tornam pretos (0)
img_bin = im2bw(img_gray, 0.5);

% Exibe a imagem binária em uma nova janela
figure;
imshow(img_bin);
title('Imagem Binária');

% Cria um elemento estruturante quadrado de tamanho 10x10 para a operação morfológica
% O elemento estruturante define a forma e tamanho da vizinhança usada na morfologia
se = strel('square', 10);

% Aplica a operação de erosão na imagem binária usando o elemento estruturante definido
% A erosão remove pixels das bordas dos objetos (áreas brancas)
% Um pixel permanece branco apenas se todos os pixels dentro da vizinhança definida pelo
% elemento estruturante forem brancos na imagem original
img_erodida = imerode(img_bin, se);

% Cria uma nova figura para exibir os resultados
figure;

% Configura a exibição para mostrar duas imagens lado a lado
% Primeiro subplot: imagem binária original
subplot(1,2,1);
imshow(img_bin);
title('Imagem Binária');

% Segundo subplot: imagem após a erosão
subplot(1,2,2);
imshow(img_erodida);
title('Após a Erosão');
