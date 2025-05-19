clc; clear; close all;

%% Exemplo 1: Manipulação Básica de Imagens

% Carregando pacotes necessários
pkg load image

% Leitura e exibição básica
img_rgb = imread('imagem_exemplo.png');
figure(1);
imshow(img_rgb);
title('Imagem Original RGB');

% Conversão para escala de cinza
img_gray = rgb2gray(img_rgb);
figure(2);
imshow(img_gray);
title('Imagem em Escala de Cinza');

% Separação e exibição de canais RGB em figuras separadas
red_channel = img_rgb(:,:,1);
green_channel = img_rgb(:,:,2);
blue_channel = img_rgb(:,:,3);

figure(3);
imshow(red_channel);
title('Canal Vermelho');

figure(4);
imshow(green_channel);
title('Canal Verde');

figure(5);
imshow(blue_channel);
title('Canal Azul');

% Histograma da imagem em escala de cinza
figure(6);
imhist(img_gray);
title('Histograma da Imagem');

%% Exemplo 2: Aplicação de Ruído e Filtragem

% Imagem original em escala de cinza
img = imread('imagem_exemplo.png');
if ndims(img) == 3
    img = rgb2gray(img);
end

figure(7);
imshow(img);
title('Imagem Original');

% Adicionando ruído sal e pimenta
img_salt_pepper = imnoise(img, 'salt & pepper', 0.05);
figure(8);
imshow(img_salt_pepper);
title('Ruído Sal e Pimenta');

% Adicionando ruído gaussiano
img_gaussian = imnoise(img, 'gaussian', 0, 0.01);
figure(9);
imshow(img_gaussian);
title('Ruído Gaussiano');

% Aplicação de filtro de média
filter_size = 5;
h = ones(filter_size) / (filter_size^2);  % Kernel de média
img_mean_filter = imfilter(img_salt_pepper, h);
figure(10);
imshow(img_mean_filter);
title('Filtro de Média');

% Aplicação de filtro gaussiano
sigma = 1.5;
img_gaussian_filter = imfilter(img_gaussian, fspecial('gaussian', [7 7], sigma));
figure(11);
imshow(img_gaussian_filter);
title('Filtro Gaussiano');

% Aplicação de filtro de mediana
img_median_filter = medfilt2(img_salt_pepper, [5 5]);
figure(12);
imshow(img_median_filter);
title('Filtro de Mediana');

% Análise quantitativa - Cálculo do MSE (Erro Quadrático Médio)
mse_mean = mean(mean((double(img) - double(img_mean_filter)).^2));
mse_gaussian = mean(mean((double(img) - double(img_gaussian_filter)).^2));
mse_median = mean(mean((double(img) - double(img_median_filter)).^2));

fprintf('MSE (Filtro de Média): %.2f\n', mse_mean);
fprintf('MSE (Filtro Gaussiano): %.2f\n', mse_gaussian);
fprintf('MSE (Filtro de Mediana): %.2f\n', mse_median);

%% Exemplo 3: Operações Morfológicas

% Carregar imagem e converter para binária
img = imread('imagem_exemplo.png');
if ndims(img) == 3
    img = rgb2gray(img);
end

% Binarização com limiar adaptativo
threshold = graythresh(img);
img_bin = im2bw(img, threshold);

figure(13);
imshow(img);
title('Imagem Original');

figure(14);
imshow(img_bin);
title('Imagem Binarizada');

% Definir elemento estruturante
se = strel('square', 3);

% Erosão
img_eroded = imerode(img_bin, se);
figure(15);
imshow(img_eroded);
title('Erosão');

% Dilatação
img_dilated = imdilate(img_bin, se);
figure(16);
imshow(img_dilated);
title('Dilatação');

% Abertura (erosão seguida de dilatação)
img_opened = imopen(img_bin, se);
figure(17);
imshow(img_opened);
title('Abertura');

% Fechamento (dilatação seguida de erosão)
img_closed = imclose(img_bin, se);
figure(18);
imshow(img_closed);
title('Fechamento');

%% Problema 1: Remoção de Ruído em Imagem Médica

% Carregar imagem
img = imread('imagem_exemplo.png');
if ndims(img) == 3
    img = rgb2gray(img);
end

figure(19);
imshow(img);
title('Imagem Médica Original');

% Adicionar ruído speckle (comum em ultrassom)
img_noisy = imnoise(img, 'speckle', 0.08);
figure(20);
imshow(img_noisy);
title('Imagem com Ruído Speckle');

% Aplicar filtro de média
h_mean = fspecial('average', [5 5]);
img_mean = imfilter(img_noisy, h_mean);
figure(21);
imshow(img_mean);
title('Filtro de Média Aplicado');

% Aplicar filtro gaussiano
h_gauss = fspecial('gaussian', [7 7], 1.5);
img_gauss = imfilter(img_noisy, h_gauss);
figure(22);
imshow(img_gauss);
title('Filtro Gaussiano Aplicado');

% Aplicar filtro de mediana
img_median = medfilt2(img_noisy, [5 5]);
figure(23);
imshow(img_median);
title('Filtro de Mediana Aplicado');

%% Problema 2: Contagem de Objetos em Imagem Industrial

% Carregar imagem
img = imread('imagem_exemplo.png');
if ndims(img) == 3
    img = rgb2gray(img);
end

figure(24);
imshow(img);
title('Imagem Industrial Original');

% Binarização
level = graythresh(img);
img_bin = im2bw(img, level);
figure(25);
imshow(img_bin);
title('Imagem Binarizada');

% Operações morfológicas
se = strel('square', 3);
img_opened = imopen(img_bin, se);
img_closed = imclose(img_opened, se);
figure(26);
imshow(img_closed);
title('Imagem após Operações Morfológicas');

% Rotulação de componentes
[labeled, num_objects] = bwlabel(img_closed);

% Colorir objetos separadamente
colored_labels = label2rgb(labeled, 'jet', 'k', 'shuffle');
figure(27);
imshow(colored_labels);
title(['Objetos Identificados: ' num2str(num_objects)]);

% Calcular propriedades dos objetos
props = regionprops(labeled, 'Area', 'Centroid', 'BoundingBox');

% Exibir objetos identificados
figure(28);
imshow(img);
hold on;
for i = 1:num_objects
    % Marcar centroide
    plot(props(i).Centroid(1), props(i).Centroid(2), 'r+', 'MarkerSize', 10);

    % Exibir número do objeto
    text(props(i).Centroid(1)+10, props(i).Centroid(2), num2str(i), 'Color', 'red');

    % Desenhar retângulo envolvente
    rectangle('Position', props(i).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 2);
end
title(['Total de Objetos: ' num2str(num_objects)]);
hold off;

% Mostrar estatísticas dos objetos
areas = [props.Area];
fprintf('Área média dos objetos: %.2f pixels\n', mean(areas));
fprintf('Maior objeto: %.2f pixels\n', max(areas));
fprintf('Menor objeto: %.2f pixels\n', min(areas));
