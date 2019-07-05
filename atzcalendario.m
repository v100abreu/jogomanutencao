function [ resultado ] = atzcalendario( existe_evento, ncatastrofes, pevento )
%ATZCALENDARIO atualiza a tabela calendario
%   Remove o mes atual e insere o mes futuro da variavel existe_evento de
%   acordo com a probabilidade descrita por pevento e indica qual problema
%   ira ocorrer dentro de uma lista de ncatastrofes(int)
if nargin <3
    pevento = 0.7;
end
fim = length(existe_evento);

for i = 1:fim-1
    existe_evento(i) = existe_evento(i+1);
end
existe_evento(fim) = abs(round(rand+ pevento-0.5));
if existe_evento(fim) == 1
    existe_evento(fim) = randi(ncatastrofes);
end


resultado = existe_evento;

end

