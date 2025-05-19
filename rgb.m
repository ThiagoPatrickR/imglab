% Exemplo de dilatação em imagem colorida (processamento por canal)
img = imread('imagem_exemplo.png');
se = strel('square', 5);

% Processa cada canal separadamente
R = imdilate(img(:,:,1), se);
G = imdilate(img(:,:,2), se);
B = imdilate(img(:,:,3), se);

% Recombina os canais
img_dilatada_rgb = cat(3, R, G, B);

% Exibe os resultados
figure;
subplot(1,2,1); imshow(img); title('Original (RGB)');
subplot(1,2,2); imshow(img_dilatada_rgb); title('Dilatada (RGB)');
