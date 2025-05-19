clc; clear; close all;

pkg load image;

% DILATAÇÃO MORFOLÓGICA EM OCTAVE
% Este código demonstra a aplicação da operação morfológica de dilatação
% Versão compatível com Octave

% Carregar imagem (substitua 'sua_imagem.png' pelo nome do seu arquivo)
% Certifique-se de que a imagem esteja no diretório de trabalho

imagem_original = imread('imagem_exemplo.png');

% Converter para escala de cinza se a imagem for colorida
if size(imagem_original, 3) > 1
    imagem_cinza = rgb2gray(imagem_original);
else
    imagem_cinza = imagem_original;
end

% Criar imagem binária (preto e branco)
% O valor 128 é o limiar - ajuste conforme necessário
imagem_binaria = imagem_cinza > 128;

% CRIAR ELEMENTOS ESTRUTURANTES MANUALMENTE
% Como o strel do Octave é limitado, vamos criar os elementos manualmente

% 1. Elemento estruturante quadrado 3x3
se_quadrado_3x3 = ones(3, 3);

% 2. Elemento estruturante quadrado 5x5
se_quadrado_5x5 = ones(5, 5);

% 3. Elemento estruturante em forma de cruz 3x3
se_cruz_3x3 = [0 1 0; 1 1 1; 0 1 0];

% 4. Elemento estruturante em forma de cruz 5x5
se_cruz_5x5 = [0 0 1 0 0;
               0 0 1 0 0;
               1 1 1 1 1;
               0 0 1 0 0;
               0 0 1 0 0];

% 5. Elemento estruturante circular aproximado 5x5
se_circulo_5x5 = [0 1 1 1 0;
                  1 1 1 1 1;
                  1 1 1 1 1;
                  1 1 1 1 1;
                  0 1 1 1 0];

% 6. Elemento estruturante diagonal
se_diagonal = [1 0 0;
               0 1 0;
               0 0 1];

% APLICAR DILATAÇÃO
% Escolha um dos elementos estruturantes
elemento_estruturante = se_quadrado_3x3;  % Usando quadrado 3x3 como exemplo

% Realizar a dilatação
imagem_dilatada = imdilate(imagem_binaria, elemento_estruturante);

% VISUALIZAÇÃO DOS RESULTADOS
figure('Name', 'Dilatação Morfológica');

% Mostrar imagem original
subplot(2,2,1);
imshow(imagem_original);
title('Imagem Original');

% Mostrar imagem binária
subplot(2,2,2);
imshow(imagem_binaria);
title('Imagem Binária');

% Mostrar imagem dilatada
subplot(2,2,3);
imshow(imagem_dilatada);
title('Imagem Dilatada');

% Comparação lado a lado (binária vs dilatada)
subplot(2,2,4);
% Criar imagem de comparação com sobreposição
imagem_comparacao = zeros(size(imagem_binaria,1), size(imagem_binaria,2), 3);
imagem_comparacao(:,:,1) = imagem_binaria;     % Original em vermelho
imagem_comparacao(:,:,2) = imagem_dilatada;    % Dilatada em verde
imagem_comparacao(:,:,3) = 0;                  % Azul zerado
imshow(imagem_comparacao);
title('Comparação: Vermelho=Original, Verde=Dilatada');

% ANÁLISE ADICIONAL
% Calcular a diferença entre as imagens
diferenca = imagem_dilatada - imagem_binaria;

% Criar nova figura para análise
figure('Name', 'Análise da Dilatação');

% Mostrar apenas os pixels adicionados pela dilatação
subplot(1,2,1);
imshow(diferenca);
title('Pixels Adicionados pela Dilatação');

% Mostrar elemento estruturante usado
subplot(1,2,2);
imshow(elemento_estruturante, []);
title('Elemento Estruturante Usado');

% INFORMAÇÕES SOBRE A DILATAÇÃO
printf('\n=== INFORMAÇÕES DA DILATAÇÃO ===\n');
printf('Tamanho do elemento estruturante: %dx%d\n', size(elemento_estruturante));
printf('Pixels brancos na imagem original: %d\n', sum(imagem_binaria(:)));
printf('Pixels brancos na imagem dilatada: %d\n', sum(imagem_dilatada(:)));
printf('Pixels adicionados: %d\n', sum(imagem_dilatada(:)) - sum(imagem_binaria(:)));

% SALVAR RESULTADOS
% Salvar a imagem dilatada
imwrite(imagem_dilatada, 'resultado_dilatacao.png');
printf('\nImagem dilatada salva como: resultado_dilatacao.png\n');

% EXPERIMENTOS COM DIFERENTES ELEMENTOS ESTRUTURANTES
figure('Name', 'Comparação de Diferentes Elementos Estruturantes');

% Lista de elementos estruturantes para testar
elementos = {se_quadrado_3x3, se_cruz_3x3, se_circulo_5x5, se_diagonal};
nomes = {'Quadrado 3x3', 'Cruz 3x3', 'Círculo 5x5', 'Diagonal'};

% Aplicar dilatação com diferentes elementos
for i = 1:4
    imagem_dilatada_teste = imdilate(imagem_binaria, elementos{i});

    subplot(2,2,i);
    imshow(imagem_dilatada_teste);
    title(nomes{i});
end

% DILATAÇÕES MÚLTIPLAS (aplicar dilatação várias vezes)
figure('Name', 'Dilatações Múltiplas');

imagem_temp = imagem_binaria;
for i = 1:4
    if i > 1
        imagem_temp = imdilate(imagem_temp, se_quadrado_3x3);
    end

    subplot(2,2,i);
    imshow(imagem_temp);
    title(sprintf('%d Dilatação(ões)', i-1));
end

% FUNÇÃO ALTERNATIVA PARA CRIAR ELEMENTO ESTRUTURANTE CIRCULAR
% Esta função cria um elemento estruturante circular aproximado
function se = criar_se_circular(raio)
    tamanho = 2*raio + 1;
    se = zeros(tamanho, tamanho);
    centro = raio + 1;

    for i = 1:tamanho
        for j = 1:tamanho
            distancia = sqrt((i-centro)^2 + (j-centro)^2);
            if distancia <= raio
                se(i,j) = 1;
            end
        end
    end
end

% Criar elementos circulares de diferentes tamanhos
figure('Name', 'Elementos Estruturantes Circulares');

for r = 1:4
    se_circular = criar_se_circular(r);
    subplot(2,2,r);
    imshow(se_circular, []);
    title(sprintf('SE Circular - Raio %d', r));
end

% COMPARAÇÃO COM EROSÃO (se você tiver o resultado da erosão)
% Descomente as linhas abaixo se tiver a imagem erodida
% figure('Name', 'Erosão vs Dilatação');
% subplot(1,3,1);
% imshow(imagem_erodida);
% title('Erosão');
% subplot(1,3,2);
% imshow(imagem_binaria);
% title('Original');
% subplot(1,3,3);
% imshow(imagem_dilatada);
% title('Dilatação');
