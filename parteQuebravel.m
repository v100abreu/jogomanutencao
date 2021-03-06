classdef parteQuebravel < handle
    
    properties %valores dummy devem ser mudados
        nome = "";
        idade = 1;
        idadeMax = 100; % o valor costuma atingir 99% em 30% da maxima
        custo = 0; %custo unitario
        quantidade = 1;
        qtdnecessaria = 1;
        qualidade = 1;
        horahomem = 1;%hora homem necessaria para uma pe�a apenas
        horahomemT = 1;%hora homem necessaria para todas as pe�as
        limite = 0;%quando o limite � maior que 1 o material quebra
        k1 = 0.1; % fator que corrige a idade maxima 0 a 1; 0,5 valor normal
        k2 = 1; %influencia da qualidade
        k3 = 0.03; %chance de quebrar por evento n�o previsto
        exibir = "";
    end
    
    methods
        function inicial = parteQuebravel % resolve a classe
            % valor entre 0 e 1 que determina a partir de qual valor ele quebra
            idadeCorrigida = inicial.idadeMax*2*inicial.k1;
            inicial.limite = (chance(idadeCorrigida,inicial.idade))*(inicial.k2/inicial.qualidade)+inicial.k3; 
            hora_aux = inicial.horahomem * inicial.qtdnecessaria;
            inicial.horahomemT = hora_aux;
            
        end
        function obj = atualiza(obj)
            idadeCorrigida = obj.idadeMax*2*obj.k1;
            obj.limite = (chance(idadeCorrigida,obj.idade))*(obj.k2/obj.qualidade)+obj.k3; 
            hora_aux = obj.horahomem * obj.qtdnecessaria;
            obj.horahomemT = hora_aux;
        end
        
        function obj = aumentaIdade(obj) % aumenta a idade de todos os objetos
            obj.idade = obj.idade +1;
        end
        
        function obj = atualizaexibir(obj)
            obj.exibir =  {"Voce possui:" 
                obj.quantidade + " unidades de " + obj.qtdnecessaria + " ativas."
                "as pe�as possuem " + obj.idade + " meses"
                "Qualidade: "+obj.qualidade*100+" %"  
                "chance de quebrar � " + obj.limite*100 + " %"
                "Hora homem necessaria " + obj.horahomemT};
        end        
        
    end
    
end