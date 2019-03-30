function [ evento_determinado ] = geracalendario( qual_evento)
%GERACALENDARIO Gera um calendario de problemas 
%   Gera uma tabela onde as catastrofes são selecionadas de acordo com o
%   valor de qual_evento. Este é previamente adequado a quantidade de
%   catastrofes.


tamanho1 = length(qual_evento);
evento_determinado = cell(size(qual_evento));

for i = 1:tamanho1
    if qual_evento(i) ~= 0
        evento_determinado{i} = 'problema';
    else
        evento_determinado{i} = 'ok';
    end
end

end
