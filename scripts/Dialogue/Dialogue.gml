function create_dialog(_messages){
    if (instance_exists(obj_dialog)) return;
    show_debug_message("criando dialogo")
    var _inst = instance_create_depth(0,0,0, obj_dialog);
    _inst.messages = _messages;
    _inst.current_dialog = 0;
    _inst.current_message = 0;
};

function mentor_popup(_messages) {
    if (instance_exists(obj_dialog)) return;
    
    // Usamos profundidade 0 pois o Draw GUI cuidará da prioridade visual
    var _inst = instance_create_depth(0, 0, 0, obj_dialog);
    _inst.messages = _messages;
    _inst.current_dialog = 0;
    _inst.current_message = 0;
    _inst.is_mentor_popup = true; 
}

global.char_colors = {
    "Amigo": c_orange,
    "Mentor": c_aqua,
    "Banco": c_red,
    "Sorveteiro": c_fuchsia,
};

global.dialog_amigo_completou = [{
    kind: "unique",
    happened: false,
    dialog: [{
        name: "Amigo",
        msg: "Caramba, você achou a chave! Muito obrigado, cara!",
        is_question: false,
        number: 0,
        is_end: false
    },
    {
        name: "Amigo",
        msg: "Vou levar ela agora. Muito obrigado pela ajuda!",
        is_question: false,
        number: 0,
        is_end: true,
        trigger_event: { name: "quest_key", kind: "special", result: 1,}
    }]
}];

dialog_amigo = [ 
    {   kind: "unique",
        happened: false,
        dialog: [
            { name: "Amigo", msg: "Cara, você não sabe o que aconteceu! Baldur's Gate 3 está com 70% de desconto!", is_question: false, number: 0, is_end: false },
            { 
                name: "Amigo", 
                msg: "Você vai comprar né?", 
                is_question: true, 
                options: ["Óbvio", "Queria muito, mas não vai dar..."], 
                option_results: [1, 2], // 1 = Sim, 2 = Não
                choice: "game_promotion", 
                kind: "loss", 
                number: 0, 
                is_end: false 
            },
            // RAMO DO SIM (Resultado 1)
            { 
				name: "Amigo",
				msg: "Boa, sabia que iria comprar!",
				is_question: false,
				number: 1,
				is_end: false
			},
            { name: "Amigo",
				msg: "Amanhã nós jogamos juntos, tchauu.",
				is_question: false,
				number: 1,
				is_end: false
				},
            
            // RAMO DO NÃO (Resultado 2)
            { 
				name: "Amigo",
				msg: "Eita, deixa para lá então...",
				is_question: false,
				number: 2,
				is_end: false
			},
            
            // PARTE COMUM - MISSÃO (Número 3)
            // IMPORTANTE: Definimos o option_results do Sim/Não para que, após as falas 1 ou 2, ele busque o 3
            { 
				name: "Amigo",
				msg: "E cara, você pode me ajudar com uma coisa?",
				is_question: false,
				number: 3,
				is_end: false
			},
            { 
				name: "Amigo",
				msg: "Deixei cair a chave da minha casa no seu quintal... Se você achar, pega pra mim! Se não minha mãe vai me matar!",
				is_question: false,
				number: 3,
				is_end: true
			}
        ]
    },
    {   kind: "pattern",
        happened: false,
        required_event : "",
        dialog: [{ name: "Amigo", msg: "Oi, amigo!", is_question: false, number: 0, is_end: true }]
    }
];

global.dialog_mentor_transicao_fase = [{
    kind: "unique",
    happened: false,
    dialog: [
        { 
            name: "Mentor", 
            msg: "Vejo que você juntou R$ 100! Deseja comprar o fone agora? Isso iniciará a próxima fase e missões pendentes podem ser perdidas.", 
            is_question: true, 
            options: ["Sim, comprar fone", "Ainda não"],
            option_results: [1, 2],
            choice: "phase_transition",
            kind: "special",
            number: -0, 
            is_end: false 
        },
        { 
            name: "Mentor", 
            msg: "Excelente escolha! Com os fones, novas oportunidades de trabalho surgirão. Sua próxima meta é economizar para um celular de R$ 900.", 
            is_question: false, 
            number: 1, // Resposta "Sim"
            is_end: true,
            trigger_event: { name: "start_phase_2", kind: "special", result: 2 } 
        },
        { 
            name: "Mentor", 
            msg: "Tudo bem. Volte quando estiver pronto para avançar.", 
            is_question: false, 
            number: 2, // Resposta "Não"
            is_end: true 
        }
    ]
}];

dialog_mentor = [
    {   kind: "unique",
        happened: false,
        required_event : "",
        dialog: [
            { 
                name: "Mentor",
                msg: "Bem vindo! Sou seu mentor financeiro.",
                is_question: false,
                number: -1,
                is_end: false
            },
            { 
                name: "Mentor",
                msg: "Nossa meta: Construir liberdade financeira...",
                is_question: false,
                number: -1,
                is_end: false
            },
            {
                name: "Mentor",
                msg: "Ao longo de sua jornada aparecerão oportunidades...",
                is_question: false,
                number: -1,
                is_end: false
            },
            {
                name: "Mentor", 
                msg: "Vamos começar. Qual é o seu objetivo financeiro?",
                is_question: true,
                options: ["Fone de Ouvido: R$100,00 em 4 meses"],   //"Celular: R$900,00 em 9 meses", "Formatura: R$1700,00 em 15 meses"]
                option_results: [1], //[1, 2, 3]
                choice: "meta", 
                kind: "special",
                number: -1,
                is_end: false
            },
            {
                name: "Mentor",
                msg: "Ótimo! Agora que já definiu a sua meta...",
                is_question: false,
                number: -1,
                is_end: false
            },
            {
                name: "Mentor",
                msg: "Em todos os meses, no dia 1º, você receberá uma mesada...",
                is_question: false,
                number: -1,
                is_end: false
            }, 
            { 
                name: "Mentor", 
                msg: "E lembre-se, ganhar não é tudo, você também deve controlar seus gastos! Pressione 'Z' para monitorar seu saldo....",
                is_question: false,
                number: -1,
                is_end: true
            }
        ]
    },
    {   kind: "pattern",
        happened: false,
        required_event : "",
        dialog: [
            { 
                name: "Mentor",
                msg: "Mantenha seu foco, controle seus gastos e alcance a sua meta!",
                is_question: false,
                number: 0,
                is_end: true
            }
        ]
    }
];

global.dialog_sorveteiro = [
    {   
        kind: "pattern",
        happened: false,
        dialog: [
            { 
                name: "Sorveteiro", 
                msg: "Olá! O dia está quente. Aceita um sorvete?", 
                is_question: true, 
                options: ["Casquinha (R$5)", "Copo Médio (R$10)", "Não, obrigado"], 
                option_results: [1, 2, 3], 
                choice: "buy_icecream", 
                kind: "loss", 
                number: 0, 
                is_end: true 
            }
        ]
    }
];

global.dialog_sem_dinheiro = [
    {   
        kind: "pattern",
        happened: false,
        dialog: [
            { 
                name: "Banco", 
                msg: "Você não tem saldo suficiente para esta compra...", 
                is_question: false, 
                number: 0, 
                is_end: true 
            }
        ]
    }
];

global.dialog_shopkeeper_completou = [{
    kind: "unique",
    happened: false,
    dialog: [{
        name: "Tadeu",
        msg: "Olha só! Você realmente achou a pipa e ela ainda está inteirinha!",
        is_question: false,
        number: 0,
        is_end: false
    },
    {
        name: "Tadeu",
        msg: "Vou guardá-la, muito obrigado garoto!",
        is_question: false,
        number: 0,
        is_end: false
    },
    {
        name: "Tadeu",
        msg: "Você é um bom menino! Toma aqui um dinheirinho pra você ficar.!",
        is_question: false,
        number: 0,
        is_end: false
    },
    {
        name: "Tadeu",
        msg: "Agora, me dê licença que vou procurar uma rabiola nova para essa pipa aqui. Até mais!",
        is_question: false,
        number: 0,
        is_end: true,
        trigger_event: { name: "quest_kite", kind: "special", result: 1, reward: 15 }
    }]
}];

global.dialog_shopkeeper = [
    {   kind: "unique",
        happened: false,
        required_event : "",
        dialog: [
            { 
            name: "Tadeu", 
            msg: "Boa tarde! Seja bem vindo à Lojinha do Tadeu!", 
            is_question: false, 
            number: -1, 
            is_end: false 
            },
            { 
            name: "Tadeu", 
            msg: "O que você deseja?", 
            is_question: true, 
            options: ["Ver o catálogo","Perguntar sobre decoração de pipa (missão)", "Sair"], 
            option_results: [1, 2, 3], 
            choice: "shopkeeper_choice",
            kind: "special", 
            number: 0, 
            is_end: false 
            },
            { name: "Tadeu", 
            msg: "Aqui está o catálogo", 
            is_question: false, 
            number: 1, is_end: true, 
            trigger_event: { name: "open_shop", kind: "special", result: 1 } 
            },
            { 
            name: "Tadeu", 
            msg: "Ah, eu gosto muito de pipas desde criança. Não só vendo elas na loja, eu também brinco de empinar pipa quando posso.", 
            is_question: false, 
            number: 2, 
            is_end: false 
            },
            { 
            name: "Tadeu", 
            msg: "Aliás, no outro dia, estava brincando com minha pipa novinha na praça, mas bateu um vento forte e ela caiu lá pra direita do parque depois de uma cerca. Não consigo chegar lá para recuperá-la", 
            is_question: false, 
            number: 2, 
            is_end: false 
            },
            { 
             name: "Tadeu", 
            msg: "Se você estiver passando por lá qualquer dia e conseguir encontrar a pipa, traz ela para mim, por favor? Se você fizesse isso, eu ficaria muito grato!", 
            is_question: false, 
            number: 2, 
            is_end: true 
            },
            { 
            name: "Tadeu", 
            msg: "Volte sempre!", 
            is_question: false, 
            number: 3, 
            is_end: true 
            },
        ]
    },
    {   
        kind: "pattern",
        happened: false,
        required_event: "",
        dialog: [
            { 
            name: "Tadeu", 
            msg: "Boa tarde! Seja bem vindo à Lojinha do Tadeu!", 
            is_question: false, 
            number: -1, 
            is_end: false 
            },
            { 
            name: "Tadeu", 
            msg: "O que você deseja?", 
            is_question: true, 
            options: ["Ver o catálogo", "Sair"], 
            option_results: [1, 2], 
            choice: "shopkeeper_choice",
            kind: "special", 
            number: 0, 
            is_end: false 
            },
            { name: "Tadeu", 
            msg: "Aqui está o catálogo", 
            is_question: false, 
            number: 1, is_end: true, 
            trigger_event: { name: "open_shop", kind: "special", result: 1 } 
            },
            { 
            name: "Tadeu", 
            msg: "Volte sempre!", 
            is_question: false, 
            number: 2, 
            is_end: true 
            },
        ]
    }
];

global.dialog_influencer_completou = [{
    kind: "unique",
    happened: false,
    dialog: [{
        name: "Influencer",
        msg: "Olha só quem voltou! E trouxe o fone como eu pedi, eu sei que você me ama.",
        is_question: false,
        number: 0,
        is_end: false
    },
    {
        name: "Influencer",
        msg: "Pode deixar comigo. E toma uns trocados aqui para comprar uma balinha que hoje eu tô me sentindo caridoso.!",
        is_question: false,
        number: 0,
        is_end: true,
        trigger_event: { name: "quest_headset", kind: "special", result: 1, reward: 25 }
    }]
}];

global.dialog_influencer = [
  {
    kind: "unique",
    happened: false,
    required_event: "",
    dialog: [
      {
        name: "Influencer",
        msg: "Fala, pessoal! Acabei de comprar o novo 'Tênis Neon 3000'. Se você não tem um desses, você está perdendo a moda!",
        is_question: false,
        number: -1,
        is_end: false
      },
      {
        name: "Influencer",
        msg: "[O que você faz?]",
        is_question: true,
        options: ["Sair", "Ficar encarando o influencer (missão)"],
        option_results: [1, 2],
        choice: "staring_mission",
        kind: "special",
        number: 0,
        is_end: false
      },
      {
        name: "Influencer",
        msg: "Isso aí, tchau!",
        is_question: false,
        number: 1,
        is_end: true
      },
      {
        name: "Influencer",
        msg: "...",
        is_question: false,
        number: 2,
        is_end: false
      },
      {
        name: "Influencer",
        msg: "...........",
        is_question: false,
        number: 2,
        is_end: false
      },
      {
        name: "Influencer",
        msg: "Tá olhando o quê? Quer uma foto?",
        is_question: false,
        number: 2,
        is_end: false
      },
      {
        name: "Influencer",
        msg: "Não? Então vai ver se eu tô la na esquina vai!!------Naa verdadee! Já que você não tá fazendo nada aí parado...",
        is_question: false,
        number: 2,
        is_end: false
      },
      {
        name: "Influencer",
        msg: "Você bem que podia pegar meu fone de ouvido Hi-Tech T570S que eu deixei na minha mansão particular futurista brilhante.",
        is_question: false,
        number: 2,
        is_end: false
      },
    {
        name: "Influencer",
        msg: "Eu preciso desse fone para gravar meu próximo vídeo. Se você pegar pra mim, talvez eu até marque você no próximo story.",
        is_question: false,
        number: 2,
        is_end: true
    }
    ]
  },
  {
    kind: "pattern",
    happened: false,
    required_event: "",
    dialog: [
        {
            name: "Influencer",
            msg: "Ei! Vi que você guardou sua mesada o mês todo... mas esquece isso! ",
            is_question: false,
            number: -1,
            is_end: false 
        }, 
        {
            name: "Influencer",
            msg: "Se você comprar esse 'Boné de LED' agora, eu te coloco no meu vídeo.",
            is_question: true,
            options: ["Comprar o Boné (-R$50,00)", "Manter meta", "Verificar se o boné é útil"],
            option_results: [1, 2, 3],
            choice: "buy_led_hat",
            kind: "loss",
            number: 0,
            is_end: false 
        }, 
        {
            name: "Influencer",
            msg: "ISSO! O boné ficou incrível. Olha esse brilho!",
            is_question: false,
            number: 1,
            is_end: true 
        }, 
        {
            name: "Influencer",
            msg: "Sério? Você vai preferir guardar dinheiro? Que tédio...",
            is_question: false,
            number: 2,
            is_end: true 
        }, 
        {
            name: "Influencer",
            msg: "Útil? Cara, é um boné que brilha! Tchau!",
            is_question: false,
            number: 3,
            is_end: true 
        }
    ]
  }
];

global.dialog_wanderley = [
    {   
        kind: "pattern",
        happened: false,
        dialog: [

            { 
                name: "Wanderley", 
                msg: "E aí, campeão!  Vai uma coxinha pra viagem aí? Tá na promoção! só 6 reais", 
                is_question: true, 
                options: ["Comprar (R$ 6,00)", "Tô tentando economizar um pouco, seu Wanderley.", "Hoje não, valeu."], 
                option_results: [1, 2, 3],
                choice: "buy_coxinha", 
                kind: "loss", 
                number: 0, 
                is_end: false 
            },

            { 
                name: "Wanderley", 
                msg: "Boa! Toma aqui, cuidado pra não sujar a camisa da escola, que sua mãe fica brava. Até amanhã!", 
                is_question: false, 
                number: 1, 
                is_end: true 
            },

            { 
                name: "Wanderley", 
                msg: "Ah, sei como é que é. Juntar um trocado é difícil mesmo, tudo subindo...", 
                is_question: false, 
                number: 2, 
                is_end: false 
            },
            { 
                name: "Wanderley", 
                msg: "Mas ó, precisando de sustância pra aguentar o caminho até em casa, sabe onde me achar. Juízo aí com esse dinheiro, hein!", 
                is_question: false, 
                number: 2, 
                is_end: true 
            },

            { 
                name: "Wanderley", 
                msg: "Sem problemas, chefe! Passa aqui amanhã que deve ter uma leva saindo quentinha. Bom descanso pra você aí!", 
                is_question: false, 
                number: 3, 
                is_end: true 
            }
        ]
    }
    
];

global.dialog_lucas = [
    {   
        kind: "unique",
        happened: false,
        dialog: [
            // Mensagem introdutória (-1) - Criando o desejo de consumo
            { 
                name: "Lucas", 
                msg: "Cara, você não tem noção! Consegui uma  carta do 'Gato Invisível' ontem. É raríssima!", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
			
			{ 
                name: "Lucas", 
                msg: "Faço por R$ 8,00 só porque a gente é parceiro. Eu ia guardar pra mim, mas tô precisando de uma grana pra um jogo novo.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },

            // BLOCO DE ESCOLHA (0) - A tentação do hobby
            { 
                name: "Lucas", 
                msg: "Quer comprar?", 
                is_question: true, 
                options: ["Comprar (R$ 8,00)", "R$ 8? É muita grana pra um papel...", "Agora não, Lucas. Valeu!"], 
                option_results: [1, 2, 3], 
                choice: "buy_card", 
                kind: "loss", 
                number: 0, 
                is_end: false 
            },

            // RESULTADO 1: Compra efetuada (Ocupa um espaço no inventário e gasta o dinheiro)
            { 
                name: "Lucas", 
                msg: "Valeu! Você não vai se arrepender, olha como ela brilha no sol. Cuida bem dela, hein!", 
                is_question: false, 
                number: 1, 
                is_end: true 
            },

            // RESULTADO 2: Crítica ao preço/Reflexão
            { 
                name: "Lucas", 
                msg: "Papel? Isso aqui é item de colecionador, pô! Mas beleza, depois não chora quando ela valorizar e eu não quiser mais vender.", 
                is_question: false, 
                number: 2, 
                is_end: true 
            },

            // RESULTADO 3: Recusa direta
            { 
                name: "Lucas", 
                msg: "Tranquilo, sem grilo. Vou ver se o pessoal do outro nono ano tem interesse. Falou!", 
                is_question: false, 
                number: 3, 
                is_end: true 
            }
        ]
    },
    {   
        kind: "pattern",
        happened: false,
        dialog: [
            // Mensagem introdutória (-1) - Criando o desejo de consumo
            { 
                name: "Lucas", 
                msg: "E aí, cara!", 
                is_question: false, 
                number: -1, 
                is_end: true 
            },
			
        ]
    }
];

global.dialog_donagraca = [
    {   
        kind: "unique",
        happened: false,
        dialog: [
            // Mensagem introdutória (-1) - Apelo emocional e visual
            { 
                name: "Dona Graça", 
                msg: "Oi, meu filho! Estava aqui arrumando as prateleiras e achei uma pelúcia... não é a coisa mais fofa do mundo?", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
			
			{ 
                name: "Dona Graça", 
                msg: "Essa pelúcia é última que eu tenho, sobrou só essa unidade. Ficaria linda decorando o seu quarto, não acha?", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },

            // BLOCO DE ESCOLHA (0) - A opção de gasto é a 1
            { 
                name: "Dona Graça", 
                msg: "Faço por R$ 12,00 pra você.", 
                is_question: true, 
                options: ["Comprar Pelúcia (R$ 12,00)", "É linda, mas preciso guardar meu dinheiro.", "Agora não, Dona Graça. Obrigado!"], 
                option_results: [1, 2, 3], 
                choice: "buy_plushie", 
                kind: "loss", 
                number: 0, 
                is_end: false 
            },

            // RESULTADO 1: Compra efetuada (Obrigatório ser o 1 para gastos)
            { 
                name: "Dona Graça", 
                msg: "Ai, que bom gosto! Ele vai te dar muita sorte, você vai ver. Anda com cuidado, viu!", 
                is_question: false, 
                number: 1, 
                is_end: true 
            },

            // RESULTADO 2: Recusa consciente (Foco na economia)
            { 
                name: "Dona Graça", 
                msg: "Ah, eu entendo perfeitamente, querido. Está certo em poupar. Você é um bom menino.", 
                is_question: false, 
                number: 2, 
                is_end: true 
            },

            // RESULTADO 3: Recusa direta
            { 
                name: "Dona Graça", 
                msg: "Tudo bem, meu anjo. Passa aqui depois pra me dar um oi, mesmo se não for comprar nada! Vai com Deus.", 
                is_question: false, 
                number: 3, 
                is_end: true 
            }
        ]
    },
    {   
        kind: "unique",
        happened: false,
        dialog: [
            // Mensagem introdutória (-1) - Apelo emocional e visual
            { 
                name: "Dona Graça", 
                msg: "Oi, meu filho! A vendinha está fechada nesses dias...", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
			
			{ 
                name: "Dona Graça", 
                msg: "mas quando eu reabrir vai ter muitas coisinha para você comprar!", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            
            { 
                name: "Dona Graça", 
                msg: "Até mais, viu? Aproveite seu dia!", 
                is_question: false, 
                number: -1, 
                is_end: false 
            } 
        ]
    }
];

global.dialog_luna = [
    {   
        kind: "unique",
        happened: false,
        dialog: [

            { 
                name: "Luna", 
                msg: "Ei, olha só... acabei de terminar esse quadro do parque. Essa vista é linda, né?", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },

            { 
                name: "Luna", 
                msg: "Estou vendendo essa pintura por R$ 20,00. Você quer comprar?", 
                is_question: true, 
                options: ["Comprar Pintura (R$ 20,00)", "É linda, mas não posso gastar agora.", "Não, valeu."], 
                option_results: [1, 2, 3], 
                choice: "buy_painting", 
                kind: "loss", 
                number: 0, 
                is_end: false 
            },

            { 
                name: "Luna", 
                msg: "Valeu demais pelo apoio! Essa aqui é única, viu? Coloca em algum lugar com luz boa que ela transforma o ambiente. Até mais!", 
                is_question: false, 
                number: 1, 
                is_end: true 
            },

            // RESULTADO 2: Recusa consciente (Dificuldade de priorizar)
            { 
                name: "Luna", 
                msg: "Entendo perfeitamente. Às vezes o bolso não acompanha a vontade, né? Mas valeu por parar pra apreciar!", 
                is_question: false, 
                number: 2, 
                is_end: true 
            },

            // RESULTADO 3: Recusa direta
            { 
                name: "Luna", 
                msg: "Beleza! Bom caminho pra você, garoto. Se mudar de ideia, estarei por aqui até o sol se pôr.", 
                is_question: false, 
                number: 3, 
                is_end: true 
            }
        ]
    },
    
    {   
        kind: "pattern",
        happened: false,
        dialog: [
            // Mensagem introdutória (-1) - Foco na apreciação estética
            { 
                name: "Luna", 
                msg: "Oie! Já vendi todas as minhas pinturas essa semana.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            { 
                name: "Luna", 
                msg: "Mas gora vou focar nas minhas energias interiores buscando inspiração para a próxima pintura.", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
            { 
                name: "Luna", 
                msg: "Foi bom falar com você. Até mais!!", 
                is_question: false, 
                number: -1, 
                is_end: false 
            },
        ]    
    }        
];

global.dialog_mentor_low_balance = [{
    kind: "unique",
    happened: false,
    dialog: [
        { 
            name: "Mentor", 
            msg: "Ei, preste atenção! Você tem menos de R$ 50,00.", 
            is_question: false, 
            number: -1, 
            is_end: false 
        },
        { 
            name: "Mentor", 
            msg: "Seu dinheiro está acabando rápido. Se continuar gastando assim, não vai bater sua meta!", 
            is_question: false, 
            number: -1, 
            is_end: true 
        }
    ]
}];

global.dialog_mentor_first_goal_reached = [{
    kind: "unique",
    happened: false,
    dialog: [
        { 
            name: "Mentor", 
            msg: "Parabéns! Você conseguiu guardar R$ 100,00 e agora pode completar a primeira meta de comprar um fone de ouvido!", 
            is_question: false, 
            number: -1, 
            is_end: false 
        },
        { 
            name: "Mentor", 
            msg: "Venha falar comigo na casa inicial para comprar seu fone e avançarmos!", 
            is_question: false, 
            number: -1, 
            is_end: false
        },
        { 
            name: "Mentor", 
            msg: "Cuidado para não gastar seu dinheiro antes de comprar o fone! Pense bem antes de qualquer compra.", 
            is_question: false, 
            number: -1, 
            is_end: true
        }
    ]
}];

