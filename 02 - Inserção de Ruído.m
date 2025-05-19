% Limpa a tela, as variáveis e fecha as janelas anteriores
clc; clear; close all;

% Carrega o pacote de processamento de imagens do Octave
% Este pacote contém funções específicas para manipulação de imagens
pkg load image

% Leitura da imagem do arquivo
% A função imread carrega a imagem do disco para a memória como uma matriz
% Você pode substituir 'imagem_exemplo.jpg' pelo nome do seu arquivo de imagem
imagem_original = imread('imagem_exemplo.png');

% Inserção do ruído sal e pimenta usando a função imnoise
% salt & pepper: adiciona pixels brancos (sal) e pretos (pimenta) aleatoriamente
% 0.1: densidade do ruído - significa que aproximadamente 10% dos pixels serão afetados
% (5% brancos e 5% pretos)
imagem_ruido = imnoise(imagem_original, 'salt & pepper', 0.1);

% Cria uma nova janela para exibir as imagens
figure;

% Configura o primeiro subplot (posição esquerda)
subplot(1,2,1);

% Exibe a imagem original no primeiro subplot
imshow(imagem_original);

% Adiciona um título à imagem original
title('Imagem Original');

% Configura o segundo subplot (posição direita)
subplot(1,2,2);

% Exibe a imagem com ruído no segundo subplot
imshow(imagem_ruido);

% Adiciona um título à imagem com ruído
title('Imagem com Ruído Sal e Pimenta');

% Salva a imagem com ruído em um arquivo no diretório atual
% Este arquivo será usado pelo código de filtragem apresentado anteriormente
% O formato é determinado pela extensão do arquivo (.jpg neste caso)
imwrite(imagem_ruido, 'sal_pimenta.jpg');
