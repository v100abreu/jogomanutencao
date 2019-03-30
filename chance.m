function [ resultado ] = chance( idadeMax , idadeAtual, vetor )

%CHANCE calcula a propabilidade de um equipamento falhar conforme ele se
%aproxima da sua idade Maxima
%   O grafico parte de uma probabilidade simples de dois eventos ocorrerem
%   simultaneamente dentro de um periodo determinado, no caso do trabalho é
%   a probabilidade do dia da falha coincidir com o dia atual. 


%para teste
if nargin < 3 
    vetor = 0;
end
if nargin < 2
    idadeMax = 12;
    idadeAtual = 11;    
end
if nargin < 1
    vetor = 1;
end
%fim do teste
    
pbarrado = 1;
vetorp = zeros(idadeAtual,1);

for i = 1:(idadeAtual-1)
    pbarrado = pbarrado*(1-i/idadeMax);
    vetorp(i+1,1) = 1-pbarrado;

end

ptotal = 1-pbarrado;

%indica se sera exibida a chance atual ou o vetor de todas chances
if(vetor ~= 0)
    resultado = vetorp;
else
    resultado = ptotal;
end
